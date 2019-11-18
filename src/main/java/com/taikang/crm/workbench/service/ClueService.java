package com.taikang.crm.workbench.service;

import com.taikang.crm.common.vo.PaginationVO;
import com.taikang.crm.workbench.model.Clue;
import com.taikang.crm.workbench.model.ClueActivityRelation;
import com.taikang.crm.workbench.model.Tran;

import java.util.List;
import java.util.Map;

public interface ClueService {
    boolean addClue(Clue clue);

    Clue queryClueDetail(String id);

    boolean unbund(String id);


//    boolean bund2(String clueId, String[] activityIds);

    boolean bund(List<ClueActivityRelation> activityRelationList);

    boolean conver(String clueId, Tran t, String createBy);

    PaginationVO<Clue> pageList(Map<String, Object> paraMap);

    boolean bund2(String clueId, String[] activityIds);
}
