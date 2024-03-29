package com.taikang.crm.setting.model;

/**
 * Author: 恩诺国际
 * 2019/4/28
 */
public class DicType {

    private String code;
    private String name;
    private String description;

    public String getCode() {
        return code;
    }

    public DicType setCode(String code) {
        this.code = code;
        return this;
    }

    public String getName() {
        return name;
    }

    public DicType setName(String name) {
        this.name = name;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public DicType setDescription(String description) {
        this.description = description;
        return this;
    }
}
