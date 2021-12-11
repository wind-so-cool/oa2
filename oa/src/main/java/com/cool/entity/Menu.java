package com.cool.entity;

import java.util.Date;

public class Menu {
    private Long menuId;

    private Long menuParentId;

    private String menuName;

    private Short menuType;

    private String menuPath;

    private String descContent;

    private Short isPublish;

    private Date createdDate;

    private String menuParentName;

    private String permissionCode;

    public String getPermissionCode() {
        return permissionCode;
    }

    public void setPermissionCode(String permissionCode) {
        this.permissionCode = permissionCode;
    }

    public String getMenuParentName() {
        return menuParentName;
    }

    public void setMenuParentName(String menuParentName) {
        this.menuParentName = menuParentName;
    }

    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public Long getMenuParentId() {
        return menuParentId;
    }

    public void setMenuParentId(Long menuParentId) {
        this.menuParentId = menuParentId;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName == null ? null : menuName.trim();
    }

    public Short getMenuType() {
        return menuType;
    }

    public void setMenuType(Short menuType) {
        this.menuType = menuType;
    }

    public String getMenuPath() {
        return menuPath;
    }

    public void setMenuPath(String menuPath) {
        this.menuPath = menuPath == null ? null : menuPath.trim();
    }

    public String getDescContent() {
        return descContent;
    }

    public void setDescContent(String descContent) {
        this.descContent = descContent == null ? null : descContent.trim();
    }

    public Short getIsPublish() {
        return isPublish;
    }

    public void setIsPublish(Short isPublish) {
        this.isPublish = isPublish;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
}