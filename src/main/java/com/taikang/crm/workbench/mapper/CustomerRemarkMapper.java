package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.CustomerRemark;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerRemarkMapper {
    int deleteByPrimaryKey(String id);

    int insert(CustomerRemark record);

    int insertSelective(CustomerRemark record);

    CustomerRemark selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(CustomerRemark record);

    int updateByPrimaryKey(CustomerRemark record);
}