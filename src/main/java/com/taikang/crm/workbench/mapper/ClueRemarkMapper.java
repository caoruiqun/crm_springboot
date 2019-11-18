package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.ClueRemark;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ClueRemarkMapper {
    int deleteByPrimaryKey(String id);

    int insert(ClueRemark record);

    int insertSelective(ClueRemark record);

    ClueRemark selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ClueRemark record);

    int updateByPrimaryKey(ClueRemark record);

    List<ClueRemark> getClueRemarkListByClueId(String clueId);
}