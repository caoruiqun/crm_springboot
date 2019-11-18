package com.taikang.crm.workbench.model;

/**
 * Author: 恩诺国际
 * 2019/4/26
 */
public class ActivityRemark {

    private String id;  //主键
    private String noteContent; //备注信息
    private String createTime;  //创建时间
    private String createBy;    //创建人
    private String editTime;    //修改时间
    private String editBy;  //修改人
    private String editFlag;    //是否修改过的标记  0：未修改  1：已修改
    private String activityId;  //外键：市场活动id 关联tbl_activity

    public String getId() {
        return id;
    }

    public ActivityRemark setId(String id) {
        this.id = id;
        return this;
    }

    public String getNoteContent() {
        return noteContent;
    }

    public ActivityRemark setNoteContent(String noteContent) {
        this.noteContent = noteContent;
        return this;
    }

    public String getCreateTime() {
        return createTime;
    }

    public ActivityRemark setCreateTime(String createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getCreateBy() {
        return createBy;
    }

    public ActivityRemark setCreateBy(String createBy) {
        this.createBy = createBy;
        return this;
    }

    public String getEditTime() {
        return editTime;
    }

    public ActivityRemark setEditTime(String editTime) {
        this.editTime = editTime;
        return this;
    }

    public String getEditBy() {
        return editBy;
    }

    public ActivityRemark setEditBy(String editBy) {
        this.editBy = editBy;
        return this;
    }

    public String getEditFlag() {
        return editFlag;
    }

    public ActivityRemark setEditFlag(String editFlag) {
        this.editFlag = editFlag;
        return this;
    }

    public String getActivityId() {
        return activityId;
    }

    public ActivityRemark setActivityId(String activityId) {
        this.activityId = activityId;
        return this;
    }
}
