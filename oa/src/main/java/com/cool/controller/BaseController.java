package com.cool.controller;

import lombok.extern.slf4j.Slf4j;

/**
 * @Author 许俊青
 * @Date: 2021-06-26 20:25
 */
@Slf4j
public class BaseController{



/*
    public <T>  Map<String,Object> executeAndReturn(BaseService<T> baseService,String methodName,Object param,String  operation,int expectedCount){
        Map<String,Object> map=new HashMap<>();

        try{
            Class<?> targetClass=AopUtils.getTargetClass(baseService);
            ResolvableType resolvableType = ResolvableType.forClass(targetClass).getSuperType();
            ResolvableType[] types = resolvableType.getGenerics();
            Class<?> genericity= types[0].resolve();
            Method method=baseService.getClass().getMethod(methodName,param.getClass()==genericity?Object.class:param.getClass());
            int count=(int)method.invoke(baseService,param);
            map.put("flag",0);
            map.put("msg",operation+"失败");
            if(count==expectedCount){
                map.put("flag",1);
                map.put("msg",operation+"成功");
            }
        }catch(Exception e){
            log.error(operation+"失败",e);
        }


        return map;
    }
*/


}
