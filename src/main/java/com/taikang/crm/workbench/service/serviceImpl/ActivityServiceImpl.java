package com.taikang.crm.workbench.service.serviceImpl;

import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.setting.mapper.UserMapper;
import com.taikang.crm.setting.model.User;
import com.taikang.crm.workbench.mapper.ActivityMapper;
import com.taikang.crm.workbench.mapper.ActivityRemarkMapper;
import com.taikang.crm.workbench.model.Activity;
import com.taikang.crm.workbench.model.ActivityRemark;
import com.taikang.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ActivityRemarkMapper activityRemarkMapper;

    @Autowired
    private  UserMapper userMapper;


    @Override
    public boolean save(Activity activity) {

        boolean flag =true;

        int insertCount = activityMapper.insertSelective(activity);
        if (insertCount != 1) {
            flag = false;
        }

        return flag;
    }

    @Override
    public PaginationVO<Activity> pageList(Map<String, Object> paraMap) {
        //取total
        int totalCount = activityMapper.getTotalByCondition(paraMap);
        //取dataList
        List<Activity> dataList = activityMapper.getActivityListByCondition(paraMap);

        PaginationVO<Activity> vo = new PaginationVO<>();
        vo.setDataList(dataList);
        vo.setTotal(totalCount);

        return vo;
    }

    @Override
    public boolean delete(String[] ids) {

        boolean flag = true;

        //删除与市场活动关联的备注信息
        //应该删除的记录数
        int count1 = activityRemarkMapper.getCountByAids(ids);

        //实际删除的记录数
        int count2 = activityRemarkMapper.deleteByAids(ids);

        if (count1 != count2) {
            flag = false;
        }

        //删除市场活动
        int count3 = activityMapper.deleteByIds(ids);
        if (ids.length != count3) {
            flag = false;
        }

        return flag;


    }

    @Override
    public Map<String, Object> getUserListAndActivity(String id) {

        //取得用户列表
        List<User> uList = userMapper.getUserList();
        //获取市场活动
        Activity a = activityMapper.selectByPrimaryKey(id);

        //将uList和a存放到map中
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("uList", uList);
        map.put("a", a);

        return map;
    }

    @Override
    public boolean modifyActivity(Activity activity) {

        boolean flag = true;

        int updateCount = activityMapper.updateByPrimaryKeySelective(activity);

        if (updateCount != 1) {
            flag = false;
        }

        return flag;
    }

    @Override
    public Activity queryActivity(String id) {

        Activity activity = activityMapper.selectById(id);

        return activity;
    }

    @Override
    public List<ActivityRemark> getRemarkListByAid(String aid) {

        List<ActivityRemark> activityRemarkList = activityRemarkMapper.selectRemarkListByAid(aid);

        return activityRemarkList;
    }


    @Override
    public boolean saveRemark(ActivityRemark activityRemark) {

        boolean flag = true;

        int insertCount= activityRemarkMapper.insertSelective(activityRemark);
        if (insertCount != 1) {
            flag = false;
        }

        return flag;
    }

    @Override
    public boolean modifyActivityRemark(ActivityRemark activityRemark) {

        boolean flag = true;

        int updateCount = activityRemarkMapper.updateByPrimaryKeySelective(activityRemark);
        if (updateCount != 1) {
            flag = false;
        }

        return flag;
    }

    @Override
    public boolean removeActivityRemarkById(String id) {

        boolean flag = true;

        int deleteCount = activityRemarkMapper.deleteByPrimaryKey(id);
        if (deleteCount != 1) {
            flag = false;
        }

        return flag;
    }

    @Override
    public List<Activity> getActivityListByClueId(String clueId) {

        List<Activity>  activityList = activityMapper.getActivityListByClueId(clueId);

        return activityList;
    }

    @Override
    public List<Activity> getActivityListByNameNotByClueId(Map<String, String> map) {

        List<Activity> activityList = activityMapper.getActivityListByNameNotByClueId(map);

        return activityList;
    }

    @Override
    public List<Activity> getActivityListByName(String aname) {

        List<Activity> activityList = activityMapper.getActivityListByName(aname);

        return activityList;
    }

}
