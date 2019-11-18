package com.taikang.crm.workbench.controller;

import com.taikang.crm.common.utils.DateTimeUtil;
import com.taikang.crm.common.utils.UUIDUtil;
import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.config.PropertiesListenerConfig;
import com.taikang.crm.setting.model.User;
import com.taikang.crm.setting.service.UserService;
import com.taikang.crm.workbench.model.Activity;
import com.taikang.crm.workbench.model.Contacts;
import com.taikang.crm.workbench.model.Tran;
import com.taikang.crm.workbench.model.TranHistory;
import com.taikang.crm.workbench.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class TranController {

    @Autowired
    private TranService tranService;

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private ContactsService contactsService;

    @Autowired
    private TranHistoryService tranHistoryService;

    @RequestMapping("/workbench/transaction/pageList.do")
    @ResponseBody
    public Object pageList(HttpServletRequest request,
                           @RequestParam(value = "pageNo", required = true) String pageNoStr,
                           @RequestParam(value = "pageSize", required = true) String pageSizeStr) {

        System.out.println("查询交易信息列表");

        //我们现在有的是页码pageNo和每页展现的记录数pageSize
        int pageNo = Integer.valueOf(pageNoStr);
        int pageSize = Integer.valueOf(pageSizeStr);

        //但是我们后台真正要用的是略过的记录数skipCount和每页展现的记录数pageSize
        int skipCount = (pageNo-1)*pageSize;

        //以上操作过后，为sql语句中传递的与分页相关的参数以及条件查询相关的参数就全了
        Map<String,Object> paraMap = new HashMap<String,Object>();
        paraMap.put("skipCount", skipCount);
        paraMap.put("pageSize", pageSize);

         /*
            业务层应该为我们返回什么？

                total
                dataList

                业务层为控制器返回两项或者是两项以上的信息，我们可以选择使用

                map：
                    map.put("total",total);
                    map.put("dataList",dataList);


                vo：
                    vo.setTotal(total);
                    vo.setDataList(dataList);

                由于这两项数据复用率高，所以我们有必要创建一个vo类，简化操作
         */

        PaginationVO<Tran> retVo = tranService.pageList(paraMap);

        return retVo;

    }



    @RequestMapping("/workbench/transaction/add.do")
//    @ResponseBody
    public String add(Model model,HttpServletRequest request) {

        System.out.println("跳转到交易的添加页");

        List<User> userList = userService.getUserList();

        model.addAttribute("uList", userList);

//        request.setAttribute("uList", userList);

//        return "forward:/workbench/transaction/save.jsp";
        return "workbench/transaction/save";
    }



    @RequestMapping("/workbench/transaction/getCustomerName.do")
    @ResponseBody
    public Object getCustomerName(@RequestParam(value = "name", required = true) String name) {

        System.out.println("根据客户名称模糊查询客户名称列表");

        List<String> nameList = customerService.getCustomerName(name);


        return nameList;
    }


    @RequestMapping("/workbench/transaction/getActivityListByName.do")
    @ResponseBody
    public Object getActivityListByName(@RequestParam(value = "aname", required = true) String aname) {

        System.out.println("取得市场活动源列表（根据名称模糊查）");

        List<Activity> activityList = activityService.getActivityListByName(aname);

        return activityList;

    }

    @RequestMapping("/workbench/transaction/getContactsListByName.do")
    @ResponseBody
    public Object getContactsListByName(@RequestParam(value = "cname", required = true) String cname) {

        System.out.println("取得联系人列表（根据名称模糊查）");

        List<Contacts> contactsList = contactsService.getContactsListByName(cname);

        return contactsList;

    }



    @RequestMapping("/workbench/transaction/save.do")
//    @ResponseBody
    public void save(HttpServletRequest request, HttpServletResponse response,Tran tran) throws IOException {

        System.out.println("执行交易的添加操作");

        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        //我们现在只有客户名称，id问题在业务层再处理
        tran.setId(id);
        tran.setCreateBy(createBy);
        tran.setCreateTime(createTime);

        boolean flag = tranService.save(tran);

        if(flag){

            response.sendRedirect(request.getContextPath() + "/workbench/transaction/index.jsp");

        }
    }



    @RequestMapping("/workbench/transaction/ss.do")
    @ResponseBody
    public Map<String, String> ss() {

        System.out.println("解析属性文件");

        /*Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(PropertiesListenerConfig.getAllProperty());*/

        Map<String, String> map = PropertiesListenerConfig.getAllProperty();

        return map;
    }

//        @RequestMapping("/workbench/transaction/ss.do")
//        @ResponseBody
//        public String ss(String stage) {
//
//            System.out.println("解析属性文件");
//
//            Map<String, String> map = PropertiesListenerConfig.getAllProperty();
//
//            String value = map.get(stage);
//
//            return value;
//        }

    @RequestMapping("/workbench/transaction/detail.do")
    public String detail(Model model,HttpServletRequest request, String id) {

        System.out.println("跳转到交易详细信息页");

        Tran tran = tranService.detail(id);

        Map<String, String> map = PropertiesListenerConfig.getAllProperty();
        String stage = tran.getStage();
        String possibility = map.get(stage);
        tran.setPossibility(possibility);

        model.addAttribute("t", tran);

        return "workbench/transaction/detail";
    }


    @RequestMapping("/workbench/transaction/getHistoryListByTranId.do")
    @ResponseBody
    public Object getHistoryListByTranId(@RequestParam(value = "tranId", required = true) String id) {

        System.out.println("根据交易id取得交易历史列表");

        List<TranHistory> tranHistoryList = tranHistoryService.getHistoryListByTranId(id);

        Map<String, String> map = PropertiesListenerConfig.getAllProperty();

        for (TranHistory tranHistory : tranHistoryList) {
            String stage = tranHistory.getStage();
            String possibility = map.get(stage);
            tranHistory.setPossibility(possibility);
        }

        return tranHistoryList;
    }


    @RequestMapping("/workbench/transaction/changeStage.do")
    @ResponseBody
    public Object changeStage(HttpServletRequest request,Tran tran) {

        System.out.println("执行 改变阶段的操作");
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        LocalDateTime editTime1 = LocalDateTime.now();
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String editTime = dateTimeFormatter.format(editTime1);

        Map<String, String> map = PropertiesListenerConfig.getAllProperty();
        String stage = tran.getStage();
        String possibility = map.get(stage);

        tran.setPossibility(possibility);
        tran.setEditBy(editBy);
        tran.setEditTime(editTime);

        boolean flag = tranService.changeStage(tran);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success", flag);
        retMap.put("t", tran);

        return retMap;
    }



    @RequestMapping("/workbench/transaction/getCharts.do")
    @ResponseBody
    public Object getCharts() {

        System.out.println("取得 统计交易阶段数量漏斗图 的数据");

        /*
            前端要的
            {"total":100,"dataList":[{value: ?, name: '?'},{value: ?, name: '?'},{value: ?, name: '?'},]}

            前端同时要两组或两组以上的数据，我们应该为前端提供的是map或者vo的解析，临时使用map即可
            map
                total
                dataList
         */
        Map<String,Object> map = tranService.getCharts();

        return map;
    }


//    @RequestMapping("/workbench/transaction/getStageInfo.do")
//    @ResponseBody
//    public Object getStageInfo(HttpServletRequest request , String currentPossibility, String currentStage) {
//
//        System.out.println("取得 阶段");
//
//        //准备类型为阶段的9条字典值列表
//        ServletContext application = request.getServletContext();
//
//        List<DicValue> dvList = (List<DicValue>)application.getAttribute("stageList");
//
//        //准备阶段和可能性之间的对应关系
//        Map<String, String> map = PropertiesListenerConfig.getAllProperty();
//
//        //准备前面正常阶段和后面丢失阶段的分界点下标
//        int point = 0;
//        for(int i=0;i<dvList.size();i++){
//            DicValue dv = dvList.get(i);
//            String stage = dv.getValue();
//            String possibility = map.get(stage);
//            if("0".equals(possibility)){
//                point = i;
//                break;
//            }
//        }
//
//        //return data
//        Map<String,Object> retMap = new HashMap<>();
////        retMap.put("dvList", dvList);
////        retMap.put("map", map);
////        retMap.put("point", point);
//        List<String> textList = new ArrayList<>();
//        List<Integer> idList = new ArrayList<>();
//        List<String> stageList = new ArrayList<>();
////        List<Map<String,Object>> resultList = new ArrayList<>();
////        Map<String,Object> resultMap = new HashMap<>();
//
////        ResultVo resultVo = new ResultVo();
//
//        //如果当前阶段的可能性为0 前7个图标一定是黑圈，后两个图标一个是红叉，一个是黑叉
//        if("0".equals(currentPossibility)){
//
//            for(int i=0;i<dvList.size();i++) {
//
//                //遍历数据字典值集合stageList,取得每一个遍历出来的阶段以及遍历出来的阶段对应的可能性
//                DicValue dv = dvList.get(i);
//                String listStage = dv.getValue();
//                String listPossibility = map.get(listStage);
//
//                //如果遍历出来的阶段的可能性为0 说明是后两个阶段
//                if ("0".equals(listPossibility)) {
//                    //判断如果是当前阶段
//                    if (listStage.equals(currentStage)) {
//
//                        //红叉------------------------------------
//                        textList.add(dv.getText());
//                        idList.add(i);
//                        stageList.add(listStage);
//
//                    //如果不是当前阶段
//                    } else {
//
//                        //黑叉-------------------------------------
//                        textList.add(dv.getText());
//                        idList.add(i);
//                        stageList.add(listStage);
//                    }
//
//                //如果遍历出来的阶段的可能性不为0 说明是前7个阶段
//                } else {
//                    //黑圈----------------------------------------------------
//                    textList.add(dv.getText());
//                    idList.add(i);
//                    stageList.add(listStage);
//                }
//            }
//
//        //如果当前阶段的可能性不为0 前7个图标有可能是绿圈，绿色标记，黑圈，后两个图标一定是黑叉
//        }else{
//
//            //准备当前阶段的分界点下标
//            int index = 0;
//            for(int i=0;i<dvList.size();i++){
//
//                DicValue dv = dvList.get(i);
//                String stage = dv.getValue();
//                if(currentStage.equals(stage)){
//                    index = i;
//                    break;
//                }
//            }
//
//            for(int i=0;i<dvList.size();i++) {
//
//                //取得每一个遍历出来的阶段以及遍历出来的阶段对应的可能性
//                DicValue dv = dvList.get(i);
//                String listStage = dv.getValue();
//                String listPossibility = map.get(listStage);
//
//                //如果遍历出来的阶段的可能性为0 说明是后两个阶段
//                if("0".equals(listPossibility)) {
//
//                    //黑叉-----------------------------------------
//                    textList.add(dv.getText());
//                    idList.add(i);
//                    stageList.add(listStage);
//
//
//                //如果遍历出来的阶段的可能性不为0	说明是前7个阶段
//                }else{
//
//                    //如果是当前阶段
//                    if(i==index) {
//
//                        //绿色标记-------------------------------------------
//                        textList.add(dv.getText());
//                        idList.add(i);
//                        stageList.add(listStage);
//
//                    //如果小于当前阶段
//                    }else if(i<index){
//
//                        //绿圈---------------------------------------------
//                        textList.add(dv.getText());
//                        idList.add(i);
//                        stageList.add(listStage);
//
//                        //如果大于当前阶段
//                    }else {
//
//                        //黑圈---------------------------------------------
//                        textList.add(dv.getText());
//                        idList.add(i);
//                        stageList.add(listStage);
//                    }
//                }
//
//            }
//
//        }
//
//
//        retMap.put("dataContent", textList);
//        retMap.put("id", idList);
//        retMap.put("listStage", stageList);
//
//
//        return retMap;
//    }
}
