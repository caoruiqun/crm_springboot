package com.taikang.crm.workbench.mapper;

import com.taikang.crm.workbench.model.Tran;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TranMapper {
    int deleteByPrimaryKey(String id);

    int insert(Tran record);

    int insertSelective(Tran record);

    Tran selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Tran record);

    int updateByPrimaryKey(Tran record);

    int getTotal();

    List<Tran> getDataList(Map<String, Object> paraMap);

    Tran detail(String id);

    List<Map<String, Object>> getCharts();

    int changeStage(Tran tran);
}