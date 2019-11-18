package com.taikang.crm.workbench.service;

import com.taikang.crm.workbench.model.TranHistory;

import java.util.List;

public interface TranHistoryService {
    List<TranHistory> getHistoryListByTranId(String id);
}
