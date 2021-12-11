package com.cool.listener;

import com.cool.common.Utils;
import com.cool.entity.User;
import com.cool.service.UserService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

/**
 * @Author 许俊青
 * @Date: 2021-11-06 14:02
 */
public class NextTaskListener implements TaskListener {
    @Override
    public void notify(DelegateTask delegateTask) {
        ServletRequestAttributes attributes= (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request=attributes.getRequest();
        ServletContext context=request.getServletContext();
        WebApplicationContext ctx= WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        UserService userService=ctx.getBean(UserService.class);
        User currentUser= Utils.getCurrentUser();
        User mgr=userService.getMgrByUserId(currentUser.getUserId());
        delegateTask.setAssignee(mgr.getUserName());
    }
}
