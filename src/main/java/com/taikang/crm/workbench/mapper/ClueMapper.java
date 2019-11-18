package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.Clue;
import com.taikang.crm.workbench.model.Customer;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ClueMapper {
    int deleteByPrimaryKey(String id);

    int insert(Clue record);

    int insertSelective(Clue record);

    Clue selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Clue record);

    int updateByPrimaryKey(Clue record);

    Clue selectClueDetail(String id);

    int getTotal();

    List<Clue> getDataList(Map<String, Object> paraMap);
}