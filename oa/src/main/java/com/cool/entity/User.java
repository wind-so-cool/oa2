package com.cool.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class User {
    private Long userId;

    private Long orgId;

    private String userName;

    private String userPassword;

    private String mobilePhone;

    private String email;

    private String orgName;

    private String userChName;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date userBirthday;

    private Short userSex;

    private String userPhotoUrl;

    private Integer provinceId;

    private String provinceName;

    private Integer cityId;

    private String cityName;

    private Integer countryId;

    private String contryName;

    private String hobby;

    private String introduce;

    private Date createdDate;

    private Long mgrId;

    public Long getMgrId() {
        return mgrId;
    }

    public void setMgrId(Long mgrId) {
        this.mgrId = mgrId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword == null ? null : userPassword.trim();
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone == null ? null : mobilePhone.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getUserChName() {
        return userChName;
    }

    public void setUserChName(String userChName) {
        this.userChName = userChName == null ? null : userChName.trim();
    }

    public Date getUserBirthday() {
        return userBirthday;
    }

    public void setUserBirthday(Date userBirthday) {
        this.userBirthday = userBirthday;
    }

    public Short getUserSex() {
        return userSex;
    }

    public void setUserSex(Short userSex) {
        this.userSex = userSex;
    }

    public String getUserPhotoUrl() {
        return userPhotoUrl;
    }

    public void setUserPhotoUrl(String userPhotoUrl) {
        this.userPhotoUrl = userPhotoUrl == null ? null : userPhotoUrl.trim();
    }

    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName == null ? null : provinceName.trim();
    }

    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName == null ? null : cityName.trim();
    }

    public Integer getCountryId() {
        return countryId;
    }

    public void setCountryId(Integer countryId) {
        this.countryId = countryId;
    }

    public String getContryName() {
        return contryName;
    }

    public void setContryName(String contryName) {
        this.contryName = contryName == null ? null : contryName.trim();
    }

    public String getHobby() {
        return hobby;
    }

    public void setHobby(String hobby) {
        this.hobby = hobby == null ? null : hobby.trim();
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce == null ? null : introduce.trim();
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", orgId=" + orgId +
                ", userName='" + userName + '\'' +
                ", userPassword='" + userPassword + '\'' +
                ", mobilePhone='" + mobilePhone + '\'' +
                ", email='" + email + '\'' +
                ", orgName='" + orgName + '\'' +
                ", userChName='" + userChName + '\'' +
                ", userBirthday=" + userBirthday +
                ", userSex=" + userSex +
                ", userPhotoUrl='" + userPhotoUrl + '\'' +
                ", provinceId=" + provinceId +
                ", provinceName='" + provinceName + '\'' +
                ", cityId=" + cityId +
                ", cityName='" + cityName + '\'' +
                ", countryId=" + countryId +
                ", contryName='" + contryName + '\'' +
                ", hobby='" + hobby + '\'' +
                ", introduce='" + introduce + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }
}