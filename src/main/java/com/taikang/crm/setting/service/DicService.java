package com.taikang.crm.setting.service;

import com.taikang.crm.setting.model.DicValue;

import java.util.List;
import java.util.Map;

public interface DicService {
    Map<String, List<DicValue>> getAllDics();
}
