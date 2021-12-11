package com.cool.controller;

import com.cool.common.R;
import com.cool.entity.Page;
import com.cool.entity.Role;
import com.cool.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("roleController")
public class RoleController{

	@Autowired
	private RoleService roleService;


	@GetMapping("getRolePage")
	public String getRolePage(Page<Role> page, Role role, ModelMap modelMap) {
		modelMap.put("page", roleService.getByPage(page,role));
		modelMap.put("url", "roleController/getRolePage?");
		return "role/roleList";
	}

	@GetMapping("toAddRole")
	public String roleAdd() {
		return "role/roleAdd";
	}

	@PostMapping("addRole")
	@ResponseBody
	public R addRole(Role role) {
		roleService.add(role);
		return R.ok();
	}

	@GetMapping("toRoleUpdate/{id}")
	public String toRoleUpdate(@PathVariable Long id, ModelMap map) {
		Role role = roleService.getById(id);
		System.out.println(role);
		map.put("role", role);
		return "role/roleUpdate";
	}

	@PutMapping("updateRole")
	@ResponseBody
	public R updateRole(Role role) {
		roleService.update(role);
		return R.ok();
	}

	@DeleteMapping(value = "delRole/{id}", produces = "application/json;charset=utf-8")
	@ResponseBody
	public R delRole(@PathVariable Long id) {
		roleService.delete(id);
		return R.ok();

	}


	@DeleteMapping(value = "batchDel", produces = "application/json;charset=utf-8")
	@ResponseBody
	public R batchDel(@RequestParam("ids[]") Long[] ids) {
		roleService.batchDel(ids);
		return R.ok();

	}

}