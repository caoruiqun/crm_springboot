package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.TranHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TranHistoryMapper {
    int deleteByPrimaryKey(String id);

    int insert(TranHistory record);

    int insertSelective(TranHistory record);

    TranHistory selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TranHistory record);

    int updateByPrimaryKey(TranHistory record);

    List<TranHistory> getHistoryListByTranId(String id);
}