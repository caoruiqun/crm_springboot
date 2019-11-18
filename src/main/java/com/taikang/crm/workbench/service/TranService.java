package com.taikang.crm.workbench.service;

import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.workbench.model.Tran;

import java.util.Map;

public interface TranService {
    PaginationVO<Tran> pageList(Map<String, Object> paraMap);

    boolean save(Tran tran);

    Tran detail(String id);

    Map<String, Object> getCharts();

    boolean changeStage(Tran tran);
}
