package com.cool.entity;

import java.util.Date;

public class Leave {
    private Long id;

    private Long userId;

    private String userName;

    private String reason;

    private String ps;

    private Date createDate;

    private Long state;

    private Long days;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason == null ? null : reason.trim();
    }

    public String getPs() {
        return ps;
    }

    public void setPs(String ps) {
        this.ps = ps == null ? null : ps.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Long getState() {
        return state;
    }

    public void setState(Long state) {
        this.state = state;
    }

    public Long getDays() {
        return days;
    }

    public void setDays(Long days) {
        this.days = days;
    }
}