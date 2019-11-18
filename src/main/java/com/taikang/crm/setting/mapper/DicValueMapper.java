package com.taikang.crm.setting.mapper;

import com.taikang.crm.setting.model.DicValue;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface DicValueMapper {
    int deleteByPrimaryKey(String id);

    int insert(DicValue record);

    int insertSelective(DicValue record);

    DicValue selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(DicValue record);

    int updateByPrimaryKey(DicValue record);

    List<DicValue> getDicValueListByCode(String code);
}