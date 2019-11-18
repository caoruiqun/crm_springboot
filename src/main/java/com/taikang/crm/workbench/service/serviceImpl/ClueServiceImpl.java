package com.taikang.crm.workbench.service.serviceImpl;

import com.taikang.crm.common.utils.DateTimeUtil;
import com.taikang.crm.common.utils.UUIDUtil;
import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.workbench.mapper.*;
import com.taikang.crm.workbench.model.*;
import com.taikang.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueMapper clueMapper;

    @Autowired
    private ClueRemarkMapper clueRemarkMapper;

    @Autowired
    private ClueActivityRelationMapper clueActivityRelationMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;

    @Autowired
    private ContactsMapper contactsMapper;

    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;

    @Autowired
    private ContactsActivityRelationMapper contactsActivityRelationMapper;

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    @Override
    public boolean addClue(Clue clue) {

        boolean flag = true;

        int insertCount = clueMapper.insertSelective(clue);
        if (insertCount != 1) {
            flag = false;
        }

        return flag;
    }

    @Override
    public Clue queryClueDetail(String id) {

        Clue clue = clueMapper.selectClueDetail(id);

        return clue;
    }

    @Override
    public boolean unbund(String id) {

        boolean flag = true;

        int count = clueActivityRelationMapper.deleteByPrimaryKey(id);
        if (count != 1) {
            flag = false;
        }

        return flag;
    }

    @Override
    public boolean bund2(String clueId, String[] activityIds) {

        boolean flag = true;

        for (String activityId : activityIds) {
            String id = UUIDUtil.getUUID();
            ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
            clueActivityRelation.setId(id);
            clueActivityRelation.setClueId(clueId);
            clueActivityRelation.setActivityId(activityId);

            int insertCount = clueActivityRelationMapper.bund2(clueActivityRelation);
            if(insertCount!=1){
                flag = false;
            }
        }

        return flag;
    }

    @Override
    public boolean bund(List<ClueActivityRelation> activityRelationList) {

        boolean flag = true;

        Map<String,Object> map = new HashMap<>();
        map.put("list", activityRelationList);
//        int insertCount = clueActivityRelationMapper.bund(activityRelationList);
        int insertCount = clueActivityRelationMapper.bund(map);
        if (activityRelationList.size() != insertCount) {
            flag = false;
        }

        return flag;
    }

    @Override
    public boolean conver(String clueId, Tran t, String createBy) {

        System.out.println("进入业务层，执行线索转换操作");

        String createTime = DateTimeUtil.getSysTime();

        boolean flag = true;

        //(1)通过线索id获取线索对象（线索对象当中封装了线索的信息）
        Clue clue = clueMapper.selectByPrimaryKey(clueId);

        //(2) 通过线索对象提取客户信息，当该客户不存在的时候，新建客户（根据公司的名称精确匹配，判断该客户是否存在！）
        //取得公司名称
        String company = clue.getCompany();
        Customer customer = customerMapper.getCustomerByName(company);
        //如果cus为null，说明客户表中没有以这个company公司命名的客户，需要新建一个客户
        if (null == customer) {
            customer = new Customer();
            //将线索对象clue中的信息尽可能的转换到客户对象customer中
            customer.setId(UUIDUtil.getUUID());
            customer.setAddress(clue.getAddress());
            customer.setContactSummary(clue.getContactSummary());
            customer.setCreateBy(createBy);
            customer.setCreateTime(createTime);
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setOwner(clue.getOwner());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setName(company);
            customer.setDescription(clue.getDescription());
            //执行添加客户的操作
            int count1 = customerMapper.insertSelective(customer);
            if (1 != count1) {
                flag = false;
            }
        }

        //(3)通过线索对象提取联系人信息，保存联系人
        Contacts contacts = new Contacts();
        //从线索对象c中，提取出与联系人相关的信息，转换成联系人
        contacts.setId(UUIDUtil.getUUID());
        contacts.setSource(clue.getSource());
        contacts.setOwner(clue.getOwner());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(clue.getJob());
        contacts.setFullname(clue.getFullname());
        contacts.setEmail(clue.getEmail());
        contacts.setDescription(clue.getDescription());
        contacts.setCustomerId(customer.getId());
        contacts.setCreateTime(createTime);
        contacts.setCreateBy(createBy);
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setAppellation(clue.getAppellation());
        contacts.setAddress(clue.getAddress());
        //添加联系人
        int count2 = contactsMapper.insertSelective(contacts);
        if(count2!=1){
            flag = false;
        }

        //--------------------------------------------------------------------------------
        //--------------------------注意：以上第2步和第3步分别处理了客户和联系人------------
        //--------------------------以下需求如果用到客户的id，我们使用customer.getId()
        // -------------------------以下需求如果用到联系人的id，我们使用contacts.getId()---------
        //--------------------------------------------------------------------------------

        //(4) 线索备注转换到客户备注以及联系人备注
        //查询出与该线索关联的备注信息列表
        List<ClueRemark> clueRemarkList = clueRemarkMapper.getClueRemarkListByClueId(clueId);
        //遍历出来每一条线索备注的记录
        for (ClueRemark clueRemark : clueRemarkList) {
            //取得需要转的备注信息
            String noteContent = clueRemark.getNoteContent();

            //创建客户备注对象
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCreateBy(createBy);
            customerRemark.setCreateTime(createTime);
            customerRemark.setEditFlag("0");
            customerRemark.setNoteContent(noteContent);
            customerRemark.setCustomerId(customer.getId());
            //添加客户备注
            int count3 = customerRemarkMapper.insertSelective(customerRemark);
            if(count3!=1){
                flag = false;
            }

            //创建联系人备注对象
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setCreateTime(createTime);
            contactsRemark.setEditFlag("0");
            contactsRemark.setNoteContent(noteContent);
            contactsRemark.setContactsId(contacts.getId());
            //添加联系人备注
            int count4 = contactsRemarkMapper.insertSelective(contactsRemark);
            if(count4!=1){
                flag = false;
            }

        }

        //(5) “线索和市场活动”的关系转换到“联系人和市场活动”的关系
        //查询出与该线索关联的 "线索市场活动关联关系" 的列表
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationMapper.getListByClueId(clueId);
        //遍历出每一条关联关系
        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList) {
            //取出每一条记录中的市场活动id
            String activityId = clueActivityRelation.getActivityId();
            //使用每一个activityId和联系人id做新的关联关系
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setActivityId(activityId);
            contactsActivityRelation.setContactsId(contacts.getId());
            //添加联系人与市场活动的关联关系
            int count5 = contactsActivityRelationMapper.insertSelective(contactsActivityRelation);
            if(count5!=1){
                flag = false;
            }
        }

        //(6) 如果有创建交易需求，创建一条交易
        //如果t不为null，则需要创建一条交易
        if (t != null) {
            //t对象在控制器中已经封装了一些信息:id,name,money,expectedDate,stage,activityId,createBy,createTime
            //其他的信息，一部分来自于线索对象clue的转换，一部分来自于第二步和第三步产生的客户id和联系人id
            t.setSource(clue.getSource());
            t.setOwner(clue.getOwner());
            t.setNextContactTime(clue.getNextContactTime());
            t.setDescription(clue.getDescription());
            t.setCustomerId(customer.getId());
            t.setContactSummary(clue.getContactSummary());
            t.setContactsId(contacts.getId());
            //添加交易
            int count6 = tranMapper.insertSelective(t);
            if(count6!=1){
                flag = false;
            }

            //(7) 如果创建了交易，则创建一条该交易下的交易历史
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(UUIDUtil.getUUID());
            tranHistory.setCreateBy(createBy);
            tranHistory.setCreateTime(createTime);
            tranHistory.setExpectedDate(t.getExpectedDate());
            tranHistory.setMoney(t.getMoney());
            tranHistory.setStage(t.getStage());
            tranHistory.setTranId(t.getId());
            //添加交易历史
            int count7 = tranHistoryMapper.insertSelective(tranHistory);
            if(count7!=1){
                flag = false;
            }
        }

        //(8)删除线索备注
        for (ClueRemark clueRemark : clueRemarkList) {
            int count8 = clueRemarkMapper.deleteByPrimaryKey(clueRemark.getId());
            if(count8!=1){
                flag = false;
            }
        }

        //(9)删除线索和市场活动的关系
        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList) {
            int count9 = clueActivityRelationMapper.deleteByPrimaryKey(clueActivityRelation.getId());
            if(count9!=1){
                flag = false;
            }
        }

        //(10) 删除线索
        int count10 = clueMapper.deleteByPrimaryKey(clueId);
        if(count10!=1){
            flag = false;
        }

        return flag;
    }

    @Override
    public PaginationVO<Clue> pageList(Map<String, Object> paraMap) {

        int total = clueMapper.getTotal();

        List<Clue> clueList = clueMapper.getDataList(paraMap);

        PaginationVO<Clue> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(clueList);

        return vo;
    }


}
