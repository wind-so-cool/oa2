package com.cool.controller;

import com.cool.common.R;
import com.cool.common.Utils;
import com.cool.entity.Leave;
import com.cool.entity.Page;
import com.cool.entity.User;
import com.cool.service.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Author 许俊青
 * @Date: 2021-07-06 12:20
 */
@Controller
@RequestMapping("leave")
public class LeaveController extends BaseController {

    @Autowired
    private LeaveService leaveService;

    @GetMapping("getLeavePage")
    public String getLeavePage(Page<Leave> page,Leave leave, ModelMap modelMap) {
        modelMap.put("page", leaveService.getByPage(page,leave));
        modelMap.put("url", "leave/getLeavePage?");
        return "leave/leaveList";
    }

    @GetMapping("toAddLeave")
    public String toAddLeave() {
        return "leave/leaveAdd";
    }

    @PostMapping("addLeave")
    @ResponseBody
    public R addLeave(Leave leave) {
        User user= Utils.getCurrentUser();

        leave.setUserId(user.getUserId());
        leave.setUserName(user.getUserName());
        leaveService.add(leave);
        return R.ok();
    }



}
