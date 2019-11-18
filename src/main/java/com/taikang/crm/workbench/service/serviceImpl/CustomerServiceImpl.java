package com.taikang.crm.workbench.service.serviceImpl;

import com.taikang.crm.workbench.mapper.CustomerMapper;
import com.taikang.crm.workbench.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<String> getCustomerName(String name) {

        List<String> nameList = customerMapper.getCustomerName(name);

        return nameList;
    }
}
