package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.TranRemark;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TranRemarkMapper {
    int deleteByPrimaryKey(String id);

    int insert(TranRemark record);

    int insertSelective(TranRemark record);

    TranRemark selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TranRemark record);

    int updateByPrimaryKey(TranRemark record);
}