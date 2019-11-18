package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.Activity;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Mapper
public interface ActivityMapper {
    int deleteByPrimaryKey(String id);

    int insert(Activity record);

    int insertSelective(Activity record);

    Activity selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Activity record);

    int updateByPrimaryKey(Activity record);

    int getTotalByCondition(Map<String, Object> paraMap);

    List<Activity> getActivityListByCondition(Map<String, Object> paraMap);

    int deleteByIds(String[] ids);

    Activity selectById(String id);

    List<Activity> getActivityListByClueId(String clueId);

    List<Activity> getActivityListByNameNotByClueId(Map<String, String> map);

    List<Activity> getActivityListByName(String aname);
}