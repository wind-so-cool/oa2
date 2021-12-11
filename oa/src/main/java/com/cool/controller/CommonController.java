package com.cool.controller;

import com.cool.entity.Menu;
import com.cool.entity.User;
import com.cool.service.MenuService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-12-05 16:09
 */
@Controller
public class CommonController {

    @Autowired
    private MenuService menuService;

    @GetMapping("toLogin")
    public String toLogin() {
        return "redirect:/application/login.jsp";
    }

    @PostMapping("login")
    public String login(String username, String password, HttpServletRequest request){
        Subject user= SecurityUtils.getSubject();
        if(!user.isAuthenticated()){
            UsernamePasswordToken token=new UsernamePasswordToken(username,password);
            user.login(token);
            User sessionUser=(User)SecurityUtils.getSubject().getPrincipal();
            List<Menu> menus=menuService.getMenuListByUserId(sessionUser.getUserId());
            request.setAttribute("menus",menus);

        }
        return "../index";
    }


}
