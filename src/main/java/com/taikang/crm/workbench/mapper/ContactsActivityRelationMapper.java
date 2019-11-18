package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.ContactsActivityRelation;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContactsActivityRelationMapper {
    int deleteByPrimaryKey(String id);

    int insert(ContactsActivityRelation record);

    int insertSelective(ContactsActivityRelation record);

    ContactsActivityRelation selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ContactsActivityRelation record);

    int updateByPrimaryKey(ContactsActivityRelation record);
}