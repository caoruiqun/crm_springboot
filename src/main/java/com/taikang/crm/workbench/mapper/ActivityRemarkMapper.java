package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.ActivityRemark;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface ActivityRemarkMapper {
    int deleteByPrimaryKey(String id);

    int insert(ActivityRemark record);

    int insertSelective(ActivityRemark record);

    ActivityRemark selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ActivityRemark record);

    int updateByPrimaryKey(ActivityRemark record);

    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    List<ActivityRemark> selectRemarkListByAid(String aid);
}