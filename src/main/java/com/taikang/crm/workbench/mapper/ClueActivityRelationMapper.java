package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.Clue;
import com.taikang.crm.workbench.model.ClueActivityRelation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ClueActivityRelationMapper {
    int deleteByPrimaryKey(String id);

    int insert(ClueActivityRelation record);

    int insertSelective(ClueActivityRelation record);

    ClueActivityRelation selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ClueActivityRelation record);

    int updateByPrimaryKey(ClueActivityRelation record);

    int bund2(ClueActivityRelation clueActivityRelation);

//    int bund(List<ClueActivityRelation> activityRelationList);

    List<ClueActivityRelation> getListByClueId(String clueId);

    int bund(Map<String, Object> map);
}