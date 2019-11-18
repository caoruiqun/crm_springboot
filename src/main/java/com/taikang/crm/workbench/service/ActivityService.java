package com.taikang.crm.workbench.service;

import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.workbench.model.Activity;
import com.taikang.crm.workbench.model.ActivityRemark;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    boolean save(Activity activity);

    PaginationVO<Activity> pageList(Map<String, Object> paraMap);

    boolean delete(String[] ids);

    Map<String, Object> getUserListAndActivity(String id);

    boolean modifyActivity(Activity activity);

    Activity queryActivity(String id);

    List<ActivityRemark> getRemarkListByAid(String aid);

    boolean saveRemark(ActivityRemark activityRemark);

    boolean modifyActivityRemark(ActivityRemark activityRemark);

    boolean removeActivityRemarkById(String id);

    List<Activity> getActivityListByClueId(String clueId);

    List<Activity> getActivityListByNameNotByClueId(Map<String, String> map);

    List<Activity> getActivityListByName(String aname);
}
