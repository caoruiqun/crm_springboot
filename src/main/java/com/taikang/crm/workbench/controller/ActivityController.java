package com.taikang.crm.workbench.controller;

import com.taikang.crm.common.utils.DateTimeUtil;
import com.taikang.crm.common.utils.UUIDUtil;
import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.setting.model.User;
import com.taikang.crm.setting.service.UserService;
import com.taikang.crm.workbench.model.Activity;
import com.taikang.crm.workbench.model.ActivityRemark;
import com.taikang.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @Autowired
    private UserService userService;

    @RequestMapping("/workbench/activity/getUserList.do")
    @ResponseBody
    public Object getUserList() {

        System.out.println("进入到查询用户信息列表的操作");

        List<User> userList = userService.getUserList();

        return userList;
    }

    @RequestMapping("/workbench/activity/save.do")
    @ResponseBody
    public Object save(HttpServletRequest request,Activity activity) {

        System.out.println("进入到市场活动的添加操作");

        String id = UUIDUtil.getUUID();
        //创建时间：当前系统的时间
        String createTime = DateTimeUtil.getSysTime();
        //创建人：当前登录系统的用户
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        activity.setId(id);
        activity.setCreateBy(createBy);
        activity.setCreateTime(createTime);

        boolean flag = activityService.save(activity);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);

        return retMap;
    }



    @RequestMapping("/workbench/activity/pageList.do")
    @ResponseBody
    public Object pageList(HttpServletRequest request) {
//        @RequestBody Map<String,Object> reqMap
        System.out.println("查询市场活动信息列表(结合分页查询+条件查询)");

        //条件查询相关的参数
//        String name = reqMap.get("name").toString();
//        String owner = reqMap.get("owner").toString();
//        String startDate = reqMap.get("startDate").toString();
//        String endDate = reqMap.get("endDate").toString();
        String name = request.getParameter("name");
        String owner = request.getParameter("owner");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        //分页查询相关的参数
//        String pageNoStr = reqMap.get("pageNo").toString();
//        String pageSizeStr = reqMap.get("pageSize").toString();
        String pageNoStr = request.getParameter("pageNo");
        String pageSizeStr = request.getParameter("pageSize");

        //我们现在有的是页码pageNo和每页展现的记录数pageSize
        int pageNo = Integer.valueOf(pageNoStr);
        int pageSize = Integer.valueOf(pageSizeStr);

        //但是我们后台真正要用的是略过的记录数skipCount和每页展现的记录数pageSize
        int skipCount = (pageNo-1)*pageSize;

        //以上操作过后，为sql语句中传递的与分页相关的参数以及条件查询相关的参数就全了
        Map<String,Object> paraMap = new HashMap<String,Object>();
        paraMap.put("name", name);
        paraMap.put("owner", owner);
        paraMap.put("startDate", startDate);
        paraMap.put("endDate", endDate);
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

        PaginationVO<Activity> retVo = activityService.pageList(paraMap);

        return retVo;
    }




    @RequestMapping("/workbench/activity/delete.do")
    @ResponseBody
    public Object delete(@RequestParam(value = "id", required = true) String[] ids) {
//        @RequestParam(value = "id[]", required = false) String[] ids
        System.out.println("执行市场活动的删除操作");

//        String ids[] = request.getParameterValues("id");

        boolean flag = activityService.delete(ids);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);

        return retMap;
    }



    @RequestMapping("/workbench/activity/getUserListAndActivity.do")
    @ResponseBody
    public Object getUserListAndActivity(@RequestParam(value = "id", required = true) String id) {

        System.out.println("进入到取得用户信息列表和单条市场活动记录的操作");

        Map<String,Object> retMap = activityService.getUserListAndActivity(id);

        return retMap;
    }



    @RequestMapping("/workbench/activity/update.do")
    @ResponseBody
    public Object update(HttpServletRequest request,Activity activity) {

        System.out.println("进入到市场活动的修改操作");

        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        activity.setEditBy(editBy);
        activity.setEditTime(editTime);

        boolean flag = activityService.modifyActivity(activity);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);

        return retMap;
    }




    @RequestMapping("/workbench/activity/detail.do")
//    @ResponseBody
    public String detail(Model model,@RequestParam(value = "id",required = true) String id) {

        System.out.println("进入到 跳转到 指定记录的详细信息页 的操作");

        Activity activity = activityService.queryActivity(id);

//        request.setAttribute("a", a);
        model.addAttribute("a", activity);
        return "forward:/workbench/activity/detail.jsp";
    }

    @RequestMapping("/workbench/activity/getRemarkListByAid.do")
    @ResponseBody
    public Object getRemarkListByAid(@RequestParam(value = "aid",required = true) String aid) {

        System.out.println("根据市场活动id，取得关联的备注信息列表");

        List<ActivityRemark> activityRemarkList = activityService.getRemarkListByAid(aid);

        return activityRemarkList;
    }



    @RequestMapping("/workbench/activity/saveRemark.do")
    @ResponseBody
    public Object saveRemark(HttpServletRequest request, ActivityRemark activityRemark) {

        System.out.println("进入到添加备注的操作");

        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String editFlag = "0";

        activityRemark.setId(id);
        activityRemark.setCreateTime(createTime);
        activityRemark.setCreateBy(createBy);
        activityRemark.setEditFlag(editFlag);

        boolean flag = activityService.saveRemark(activityRemark);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);
        retMap.put("ar",activityRemark);

        return retMap;
    }



    @RequestMapping("/workbench/activity/updateRemark.do")
    @ResponseBody
    public Object updateRemark(HttpServletRequest request, ActivityRemark activityRemark) {

        System.out.println("进入到修改备注的操作");

        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        String editFlag = "1";

        activityRemark.setEditTime(editTime);
        activityRemark.setCreateBy(editBy);
        activityRemark.setEditFlag(editFlag);

        boolean flag = activityService.modifyActivityRemark(activityRemark);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);
        retMap.put("ar",activityRemark);

        return retMap;
    }



    @RequestMapping("/workbench/activity/deleteRemark.do")
    @ResponseBody
    public Object deleteRemark(@RequestParam(value = "id",required = true) String id) {

        System.out.println("进入到删除备注的操作");

        boolean flag = activityService.removeActivityRemarkById(id);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);

        return retMap;
    }
}
