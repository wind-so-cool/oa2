package com.cool.service;

import com.cool.entity.Role;

import java.util.List;

public interface RoleService extends BaseService<Role>{

    List<Role> getRoleList();
}