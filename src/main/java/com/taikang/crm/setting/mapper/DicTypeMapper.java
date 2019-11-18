package com.taikang.crm.setting.mapper;

import com.taikang.crm.setting.model.DicType;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface DicTypeMapper {
    int deleteByPrimaryKey(String code);

    int insert(DicType record);

    int insertSelective(DicType record);

    DicType selectByPrimaryKey(String code);

    int updateByPrimaryKeySelective(DicType record);

    int updateByPrimaryKey(DicType record);

    List<DicType> getDicTypeList();
}