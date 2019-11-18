package com.taikang.crm.workbench.service;

import com.taikang.crm.workbench.model.Contacts;

import java.util.List;

public interface ContactsService {
    List<Contacts> getContactsListByName(String cname);
}
