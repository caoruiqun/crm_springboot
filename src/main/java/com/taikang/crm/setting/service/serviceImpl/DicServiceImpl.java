package com.taikang.crm.setting.service.serviceImpl;

import com.taikang.crm.setting.mapper.DicTypeMapper;
import com.taikang.crm.setting.mapper.DicValueMapper;
import com.taikang.crm.setting.model.DicType;
import com.taikang.crm.setting.model.DicValue;
import com.taikang.crm.setting.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DicServiceImpl implements DicService {

    @Autowired
    private DicTypeMapper dicTypeMapper;

    @Autowired
    private DicValueMapper dicValueMapper;

    @Override
    public Map<String, List<DicValue>> getAllDics() {

        Map<String, List<DicValue>> map = new HashMap<String, List<DicValue>>();

        List<DicType> dicTypeList = dicTypeMapper.getDicTypeList();

        for (DicType dicType : dicTypeList) {
            String code = dicType.getCode();
            List<DicValue> dicValueList = dicValueMapper.getDicValueListByCode(code);
            map.put(code+"List", dicValueList);
        }

        return map;
    }
}
