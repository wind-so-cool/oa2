package com.cool.controller;

import com.cool.common.R;
import com.cool.entity.Menu;
import com.cool.entity.Page;
import com.cool.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("menuController")
public class MenuController{

	@Autowired
	private MenuService menuService;


	@GetMapping("getMenuPage")
	public String getMenuPage(Page<Menu> page, Menu menu, ModelMap modelMap) {
		modelMap.put("page", menuService.getByPage(page,menu));
		modelMap.put("url", "menuController/getMenuPage?");
		return "menu/menuList";
	}

	@GetMapping("toAddMenu")
	public String menuAdd() {
		return "menu/menuAdd";
	}

	@PostMapping("addMenu")
	@ResponseBody
	public R addMenu(Menu menu) {
		menuService.add(menu);
		return R.ok();
	}

	@GetMapping("toMenuUpdate/{id}")
	public String toMenuUpdate(@PathVariable Long id, ModelMap map) {
		Menu menu = menuService.getById(id);
		System.out.println(menu);
		map.put("menu", menu);
		return "menu/menuUpdate";
	}

	@PutMapping("updateMenu")
	@ResponseBody
	public R updateMenu(Menu menu) {
		menuService.update(menu);
		return R.ok();
	}

	@DeleteMapping(value = "delMenu/{id}", produces = "application/json;charset=utf-8")
	@ResponseBody
	public R delMenu(@PathVariable Long id) {
		menuService.delete(id);
		return R.ok();

	}


	@DeleteMapping(value = "batchDel", produces = "application/json;charset=utf-8")
	@ResponseBody
	public R batchDel(@RequestParam("ids[]") Long[] ids) {
		menuService.batchDel(ids);
		return R.ok();

	}

	@ResponseBody
	@GetMapping(value = "getMenuList", produces = "application/json;charset=utf-8")
	public List<Map<String, Object>> getMenuList(Long id) {
		if (id == null) {
			id = -1L;
		}
		List<Menu> menuList = menuService.getMenuListByParentId(id);
		List<Map<String, Object>> data = new ArrayList<>();
		for (Menu menu : menuList) {
			Map<String, Object> map = new HashMap<>();
			map.put("id", menu.getMenuId());
			map.put("name", menu.getMenuName());
			map.put("isParent", !CollectionUtils.isEmpty(menuService.getMenuListByParentId(menu.getMenuId())));
			data.add(map);
		}
		return data;
	}

}