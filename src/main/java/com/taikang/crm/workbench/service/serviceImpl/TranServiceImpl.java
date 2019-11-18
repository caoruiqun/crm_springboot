package com.taikang.crm.workbench.service.serviceImpl;

import com.taikang.crm.common.utils.DateTimeUtil;
import com.taikang.crm.common.utils.UUIDUtil;
import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.workbench.mapper.CustomerMapper;
import com.taikang.crm.workbench.mapper.TranHistoryMapper;
import com.taikang.crm.workbench.mapper.TranMapper;
import com.taikang.crm.workbench.model.Customer;
import com.taikang.crm.workbench.model.Tran;
import com.taikang.crm.workbench.model.TranHistory;
import com.taikang.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TranServiceImpl implements TranService {

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    @Autowired
    private CustomerMapper customerMapper;


    @Override
    public PaginationVO<Tran> pageList(Map<String, Object> paraMap) {

        int total = tranMapper.getTotal();

        List<Tran> tranList = tranMapper.getDataList(paraMap);

        System.out.println(tranList.size());

        PaginationVO<Tran> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(tranList);

        return vo;
    }

    @Override
    public boolean save(Tran tran) {

        boolean flag = true;

        /*
            根据客户的名称customerName，查询客户
         */
        String customerId = tran.getCustomerId();

        Customer customer = customerMapper.getCustomerByName(customerId);

        //判断cus，如果为null，说明没有这个客户，需要新添加一个客户
        if (null == customer) {
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerId);
            customer.setCreateBy(tran.getCreateBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            //添加客户
            int count1 = customerMapper.insertSelective(customer);
            if (count1 != 1) {
                flag = false;
            }
        }

        //处理完客户之后，将客户id封装到tran对象中，添加交易
        tran.setCustomerId(customer.getId());

        int insertCount = tranMapper.insertSelective(tran);
        if (insertCount != 1) {
            flag = false;
        }

        //添加交易后，一定要伴随着产生一条交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setCreateBy(tran.getCreateBy());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setStage(tran.getStage());
        tranHistory.setTranId(tran.getId());

        int insertCount2 = tranHistoryMapper.insertSelective(tranHistory);
        if (1 != insertCount2) {
            flag = false;
        }

        return flag;
    }

    @Override
    public Tran detail(String id) {

        Tran tran = tranMapper.detail(id);

        return tran;
    }

    @Override
    public Map<String, Object> getCharts() {

        //取得total
        int total = tranMapper.getTotal();


        //取得dataList
        /*[
            {value: 60, name: '访问'},
            {value: 40, name: '咨询'},
            {value: 20, name: '订单'},
            {value: 80, name: '点击'},
            {value: 100, name: '展现'}
        ]*/
        List<Map<String, Object>> dataList = tranMapper.getCharts();

        //将total和dataList保存到map中
        Map<String, Object> map = new HashMap<>();
        map.put("total", total);
        map.put("dataList", dataList);

        return map;
    }

    @Override
    public boolean changeStage(Tran tran) {

        boolean flag = true;

        int count = tranMapper.changeStage(tran);
        if (count != 1) {
            flag = false;
        }

        TranHistory th = new TranHistory();
        th.setId(UUIDUtil.getUUID());
        th.setCreateBy(tran.getEditBy());
        th.setCreateTime(DateTimeUtil.getSysTime());
        th.setExpectedDate(tran.getExpectedDate());
        th.setMoney(tran.getMoney());
        th.setStage(tran.getStage());
        th.setTranId(tran.getId());
        int count2 = tranHistoryMapper.insertSelective(th);
        if(count2!=1){
            flag = false;
        }


        return flag;
    }
}
