package com.taikang.crm.workbench.service.serviceImpl;

import com.taikang.crm.workbench.mapper.ContactsMapper;
import com.taikang.crm.workbench.model.Contacts;
import com.taikang.crm.workbench.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ContactsServiceImpl implements ContactsService {

    @Autowired
    private ContactsMapper contactsMapper;

    @Override
    public List<Contacts> getContactsListByName(String cname) {

        List<Contacts> contactsList = contactsMapper.getContactsListByName(cname);

        return contactsList;
    }
}
