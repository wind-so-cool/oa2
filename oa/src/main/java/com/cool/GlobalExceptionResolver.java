package com.cool;

import com.alibaba.fastjson.JSON;
import com.cool.common.OAException;
import com.cool.common.R;
import com.cool.common.ResultCode;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authz.AuthorizationException;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Component
@Slf4j
public class GlobalExceptionResolver implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        ModelAndView modelAndView = new ModelAndView("../common/error");
        modelAndView.addObject("code", 500);
        modelAndView.addObject("message", "系统异常!");
        String errorLog = "系统异常";
        if (handler instanceof HandlerMethod) {
            HandlerMethod method = (HandlerMethod) handler;
            ResponseBody responseBody = method.getMethod().getDeclaredAnnotation(ResponseBody.class);
            if (responseBody == null) {
                //返回视图
                if (ex instanceof OAException) {
                    OAException oae = (OAException) ex;
                    modelAndView.addObject("message", oae.getMessage());
                    errorLog = oae.getMessage();

                }else if(ex instanceof AuthenticationException){
                    AuthenticationException ae= (AuthenticationException) ex;
                    modelAndView.addObject("message", "用户名或密码错误");
                    modelAndView.setViewName("login");
                    errorLog = "用户名或密码错误";

                } else if(ex instanceof AuthorizationException){
                    AuthorizationException ae= (AuthorizationException) ex;
                    modelAndView.setViewName("../common/unauthorized");
                    errorLog = "你没有权限访问";

                }

            } else {
                //返回json数据
                R r = R.error().message("系统异常");


                 /*  if(ex instanceof UnauthorizedException){
                    UnauthorizedException ue= (UnauthorizedException) ex;
                    r.code(ResultCode.UNAUTHORIZED);
                    r.message("未授权");
                    errorLog="未授权";
                }*/
                if (ex instanceof OAException) {
                    OAException oae = (OAException) ex;
                    r.message(oae.getMessage());
                    errorLog = oae.getMessage();
                }else if(ex instanceof AuthorizationException){
                    AuthorizationException ae = (AuthorizationException) ex;
                    r.message("你没有权限访问");
                    r.setCode(ResultCode.UNAUTHORIZED);
                    errorLog = "你没有权限访问";

                }
                PrintWriter out = null;
                try {
                    response.setContentType("application/json;charset=UTF-8");
                    out = response.getWriter();
                    out.write(JSON.toJSONString(r));
                } catch (IOException e) {
                    e.printStackTrace();
                }
                log.error(errorLog, ex);
                return null;
            }
        }
        log.error(errorLog, ex);
        return modelAndView;
    }
}
