package com.taikang.crm.setting.model;

/**
 * Author: 恩诺国际
 * 2019/4/25
 */
public class User {

    /*
        时间相关：
            对于系统中时间相关字符串的操作：
                常见的使用方式为：
                    年月日：yyyy-MM-dd 10位
                    年月日时分秒：yyyy-MM-dd HH:mm:ss 19位
                    expireTime：年月日时分秒
                    createTime：年月日时分秒
                    editTime：年月日时分秒


        登录相关：
            loginAct账号，loginPwd密码，expireTime失效时间，lockState锁定状态，allowIps允许访问的ip地址

     */

    private String id;  //主键 UUID
    private String loginAct;    //登录账号
    private String name;    //用户真实姓名
    private String loginPwd;    //登录密码
    private String email;   //邮箱
    private String expireTime;  //失效时间
    private String lockState;   //锁定状态  0：锁定  1：启用
    private String deptno;  //部门编号
    private String allowIps;    //允许访问的ip地址群 如果同时允许多个ip地址访问，ip地址之间使用逗号分隔
    private String createTime;  //创建时间
    private String createBy;    //创建人
    private String editTime;    //修改时间
    private String editBy;  //修改人

    public String getId() {
        return id;
    }

    public User setId(String id) {
        this.id = id;
        return this;
    }

    public String getLoginAct() {
        return loginAct;
    }

    public User setLoginAct(String loginAct) {
        this.loginAct = loginAct;
        return this;
    }

    public String getName() {
        return name;
    }

    public User setName(String name) {
        this.name = name;
        return this;
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public User setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
        return this;
    }

    public String getEmail() {
        return email;
    }

    public User setEmail(String email) {
        this.email = email;
        return this;
    }

    public String getExpireTime() {
        return expireTime;
    }

    public User setExpireTime(String expireTime) {
        this.expireTime = expireTime;
        return this;
    }

    public String getLockState() {
        return lockState;
    }

    public User setLockState(String lockState) {
        this.lockState = lockState;
        return this;
    }

    public String getDeptno() {
        return deptno;
    }

    public User setDeptno(String deptno) {
        this.deptno = deptno;
        return this;
    }

    public String getAllowIps() {
        return allowIps;
    }

    public User setAllowIps(String allowIps) {
        this.allowIps = allowIps;
        return this;
    }

    public String getCreateTime() {
        return createTime;
    }

    public User setCreateTime(String createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getCreateBy() {
        return createBy;
    }

    public User setCreateBy(String createBy) {
        this.createBy = createBy;
        return this;
    }

    public String getEditTime() {
        return editTime;
    }

    public User setEditTime(String editTime) {
        this.editTime = editTime;
        return this;
    }

    public String getEditBy() {
        return editBy;
    }

    public User setEditBy(String editBy) {
        this.editBy = editBy;
        return this;
    }
}




























