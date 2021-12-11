package com.cool.controller;

import com.cool.common.R;
import com.cool.entity.Page;
import com.cool.entity.User;
import com.cool.service.UserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

/**
 * @Author 许俊青
 * @Date: 2021-07-06 12:20
 */
@Controller
@RequestMapping("userController")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    @RequiresPermissions(value="user:getUserPage")
    @GetMapping("getUserPage")
    public String getUserPage(Page<User> page,User user, ModelMap modelMap) {
        modelMap.put("page", userService.getByPage(page,user));
        modelMap.put("url", "userController/getUserPage?");
        return "user/userList";
    }


    @RequiresPermissions(value="user:toAddUser")
    @GetMapping("toAddUser")
    public String userAdd() {
        return "user/userAdd";
    }

    @PostMapping("addUser")
    @ResponseBody
    public R addUser(User user) {
        userService.add(user);
        return R.ok();
    }

    @GetMapping("toUserUpdate/{id}")
    public String toUserUpdate(@PathVariable Long id, ModelMap map) {
        User user = userService.getById(id);
        System.out.println(user);
        map.put("user", user);
        return "user/userUpdate";
    }

    @PutMapping("updateUser")
    @ResponseBody
    public R updateUser(User user) {
        userService.update(user);
        return R.ok();
    }

    @DeleteMapping(value = "delUser/{id}", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R delUser(@PathVariable Long id) {
        userService.delete(id);
        return R.ok();

    }


    @DeleteMapping(value = "batchDel", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R batchDel(@RequestParam("ids[]") Long[] ids) {
        userService.batchDel(ids);
        return R.ok();

    }

}
