package com.taikang.crm.workbench.controller;

import com.taikang.crm.common.utils.DateTimeUtil;
import com.taikang.crm.common.utils.UUIDUtil;
import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.setting.model.User;
import com.taikang.crm.setting.service.UserService;
import com.taikang.crm.workbench.model.Activity;
import com.taikang.crm.workbench.model.Clue;
import com.taikang.crm.workbench.model.ClueActivityRelation;
import com.taikang.crm.workbench.model.Tran;
import com.taikang.crm.workbench.service.ActivityService;
import com.taikang.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ClueController {

    @Autowired
    private UserService userService;

    @Autowired
    private ClueService clueService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping("/workbench/clue/getUserList.do")
    @ResponseBody
    public Object getUserList() {

        System.out.println("进入到取得用户信息列表的操作");

        List<User> userList = userService.getUserList();

        return userList;
    }



    @RequestMapping("/workbench/clue/save.do")
    @ResponseBody
    public Object save(HttpServletRequest request,Clue clue) {

        System.out.println("执行线索的添加操作");

        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        clue.setId(id);
        clue.setCreateTime(createTime);
        clue.setCreateBy(createBy);

        boolean flag = clueService.addClue(clue);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);

        return retMap;
    }



    @RequestMapping("/workbench/clue/pageList.do")
    @ResponseBody
    public Object pageList(HttpServletRequest request,
                           @RequestParam(value = "pageNo", required = true) String pageNoStr,
                           @RequestParam(value = "pageSize", required = true) String pageSizeStr) {

        System.out.println("查询线索信息列表");

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

        PaginationVO<Clue> retVo = clueService.pageList(paraMap);

        return retVo;

    }



    @RequestMapping("/workbench/clue/detail.do")
    public String detail(Model model, @RequestParam(value = "id", required = true) String id) {

        System.out.println("进入到 跳转到线索详细信息页 的操作");

        Clue clue = clueService.queryClueDetail(id);

        model.addAttribute("c", clue);

        return "forward:/workbench/clue/detail.jsp";
    }



    @RequestMapping("/workbench/clue/getActivityListByClueId.do")
    @ResponseBody
    public Object getActivityListByClueId( @RequestParam(value = "clueId", required = true) String clueId) {

        System.out.println("根据线索id查询关联的市场活动列表");

        List<Activity> activityList = activityService.getActivityListByClueId(clueId);

        return activityList;
    }



    @RequestMapping("/workbench/clue/unbund.do")
    @ResponseBody
    public Object unbund(@RequestParam(value = "id", required = true) String id) {

        System.out.println("进入到解除关联操作（线索与市场活动关联关系表的删除操作）");

        boolean flag = clueService.unbund(id);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);

        return retMap;
    }



    @RequestMapping("/workbench/clue/getActivityListByNameNotByClueId.do")
    @ResponseBody
    public Object getActivityListByNameNotByClueId(@RequestParam(value = "aname", required = true) String aname,
                                                   @RequestParam(value = "clueId", required = true) String clueId) {

        System.out.println("进入到查询市场活动列表的操作（根据名称模糊查+根据线索id排除掉已经关联过的市场活动）");


        Map<String,String> map = new HashMap<String,String>();
        map.put("aname", aname);
        map.put("clueId", clueId);

        List<Activity> activityList = activityService.getActivityListByNameNotByClueId(map);

        return activityList;
    }



    @RequestMapping("/workbench/clue/bund.do")
    @ResponseBody
    public Object bund(@RequestParam(value = "cid", required = true) String clueId,
                       @RequestParam(value = "aid", required = true) String[] activityIds) {

        System.out.println("进入到关联市场活动的操作");

        /*
            参数：
                一个clueId
                多个activityId
         */


//        Map<String,String> paraMap = new HashMap<String,String>();
//        List<ClueActivityRelation> activityRelationList = new ArrayList<>();
//
//        for (String activityId : activityIds) {
//            String id = UUIDUtil.getUUID();
//
//            ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
//            clueActivityRelation.setId(id);
//            clueActivityRelation.setClueId(clueId);
//            clueActivityRelation.setActivityId(activityId);
//
//            activityRelationList.add(clueActivityRelation);
//        }

        boolean flag = clueService.bund2(clueId,activityIds);
//        boolean flag = clueService.bund(activityRelationList);

        Map<String,Object> retMap = new HashMap<String,Object>();
        retMap.put("success",flag);

        return retMap;
    }



    @RequestMapping("/workbench/clue/getActivityListByName.do")
    @ResponseBody
    public Object getActivityListByName(@RequestParam(value = "aname", required = true) String aname) {

        System.out.println("取得市场活动信息列表（根据名称模糊查）");

        List<Activity> activityList = activityService.getActivityListByName(aname);

        return activityList;
    }


    /*@RequestParam(value = "clueId", required = true) String clueId,
    @RequestParam(value = "flag", required = false) String falg*/

    @RequestMapping("/workbench/clue/convert.do")
//    @ResponseBody
    public void convert(HttpServletRequest request, HttpServletResponse response) throws IOException {

        System.out.println("执行线索的转换操作");

        String clueId = request.getParameter("clueId");
        String flag = request.getParameter("flag");
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        Tran t = null;
        if (flag != null) {
            t = new Tran();

            String id = UUIDUtil.getUUID();
            String money = request.getParameter("money");
            String name = request.getParameter("name");
            String expectedDate = request.getParameter("expectedDate");
            String stage = request.getParameter("stage");
            String activityId = request.getParameter("activityId");
            String createTime = DateTimeUtil.getSysTime();

            t.setId(id);
            t.setMoney(money);
            t.setName(name);
            t.setExpectedDate(expectedDate);
            t.setStage(stage);
            t.setActivityId(activityId);
            t.setCreateBy(createBy);
            t.setCreateTime(createTime);
        }

        boolean flag1 = clueService.conver(clueId, t, createBy);
        if (flag1) {
            response.sendRedirect(request.getContextPath() + "/workbench/clue/index.jsp");
        }

//        return "redirect:/crm/workbench/clue/index.jsp";
    }
}
