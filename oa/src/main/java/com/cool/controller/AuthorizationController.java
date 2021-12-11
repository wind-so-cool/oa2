package com.cool.controller;

import com.cool.common.R;
import com.cool.entity.Menu;
import com.cool.entity.Page;
import com.cool.entity.Role;
import com.cool.entity.User;
import com.cool.service.MenuService;
import com.cool.service.RoleService;
import com.cool.service.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 许俊青
 * @Date: 2021-10-19 22:14
 */
@Controller
@RequestMapping("authorization")
public class AuthorizationController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    @GetMapping("toAuthorizationPage")
    public String toAuthorizationPage(ModelMap map){
        List<Role> roleList=roleService.getRoleList();
        map.put("roleList",roleList);
        return "authorization/authorization";
    }

    @GetMapping("getAuthorizedUserListByRoleId/{roleId}")
    public String getAuthorizedUserListByRoleId(@PathVariable String roleId,String queryType, ModelMap map, Page<User> page){
        PageInfo<User> pageInfo=userService.getAuthorizedUserListByRoleId(roleId,page);
        map.put("page",pageInfo);
        map.put("url", "authorization/getAuthorizedUserListByRoleId/"+roleId+"?");
        map.put("roleId",roleId);
        map.put("queryType",queryType);
        return "authorization/authorizedUserList";
    }
    @GetMapping("getAuthorizedMenuListByRoleId/{roleId}")
    public String getAuthorizedMenuListByRoleId(@PathVariable String roleId,String queryType, ModelMap map, Page<Menu> page){
        PageInfo<Menu> pageInfo=menuService.getAuthorizedMenuListByRoleId(roleId,page);
        map.put("page",pageInfo);
        map.put("url", "authorization/getAuthorizedMenuListByRoleId/"+roleId+"?");
        map.put("roleId",roleId);
        map.put("queryType",queryType);
        return "authorization/authorizedMenuList";
    }

    @DeleteMapping(value = "delUserRole", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R delUserRole(Long userId,Long roleId) {
        userService.delUserRole(userId,roleId);
        return R.ok();

    }
    @DeleteMapping(value = "delRoleMenu", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R delRoleMenu(Long menuId,Long roleId) {
        /*boolean isParent=!CollectionUtils.isEmpty(menuService.getMenuListByParentId(menuId));
        if(isParent){
            menuService.deleteRoleMenuBy
        }*/
        menuService.delRoleMenu(menuId,roleId);
        return R.ok();

    }

    @GetMapping("getToBeAuthorizedUserPage")
    public String getToBeAuthorizedUserPage(Page<User> page,User user,String roleId, ModelMap modelMap,String queryType) {
        modelMap.put("page", userService.getToBeAuthorizedUserPage(page,user,roleId));
        modelMap.put("url", "authorization/getToBeAuthorizedUserPage?");
        modelMap.put("roleId",roleId);
        modelMap.put("queryType",queryType);
        return "authorization/authorizeUser";
    }

    @PostMapping("authorizeUser")
    @ResponseBody
    public R authorizeUser(@RequestParam("userIds[]")List<Long> userIds,Long roleId){
        userService.authorizeUser(userIds,roleId);
        return R.ok();

    }

    @ResponseBody
    @GetMapping(value = "getMenuList", produces = "application/json;charset=utf-8")
    public List<Map<String, Object>> getMenuList(Long id,Long roleId) {
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
            map.put("checked",menuService.getRoleMenuCount(roleId,menu.getMenuId())!=0);
            data.add(map);
        }

        return data;
    }

    @PostMapping("authorizeMenu")
    @ResponseBody
    public R authorizeMenu(@RequestParam("menuIds[]")List<Long> menuIds,Long roleId){
        menuService.authorizeMenu(menuIds,roleId);
        return R.ok();

    }

}
