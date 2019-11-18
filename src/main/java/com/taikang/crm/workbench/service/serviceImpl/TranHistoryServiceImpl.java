package com.taikang.crm.workbench.service.serviceImpl;

import com.taikang.crm.workbench.mapper.TranHistoryMapper;
import com.taikang.crm.workbench.model.TranHistory;
import com.taikang.crm.workbench.service.TranHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: crm
 * @description:
 * @author: CaoRuiqun
 * @create: 2019-10-10 21:10
 **/
@Service
public class TranHistoryServiceImpl implements TranHistoryService {

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    @Override
    public List<TranHistory> getHistoryListByTranId(String id) {

        List<TranHistory> tranHistoryList = tranHistoryMapper.getHistoryListByTranId(id);

        return tranHistoryList;
    }
}
