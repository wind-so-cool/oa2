package com.cool.service.impl;

import com.cool.dao.RoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import com.cool.entity.Role;
import com.cool.service.RoleService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl extends BaseServiceImpl<Role> implements RoleService{

	@Autowired
	private RoleMapper roleMapper;

	@Override
	public List<Role> getRoleList() {
		return roleMapper.getList(null);
	}


}