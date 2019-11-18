package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.Contacts;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ContactsMapper {
    int deleteByPrimaryKey(String id);

    int insert(Contacts record);

    int insertSelective(Contacts record);

    Contacts selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Contacts record);

    int updateByPrimaryKey(Contacts record);

    List<Contacts> getContactsListByName(String cname);
}