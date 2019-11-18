package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.ContactsRemark;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContactsRemarkMapper {
    int deleteByPrimaryKey(String id);

    int insert(ContactsRemark record);

    int insertSelective(ContactsRemark record);

    ContactsRemark selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ContactsRemark record);

    int updateByPrimaryKey(ContactsRemark record);
}