package com.cool.controller;

import com.cool.common.R;
import com.cool.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * @Author 许俊青
 * @Date: 2021-07-11 18:24
 */
@Controller
@RequestMapping("areaController")
public class AreaController{

    @Autowired
    private AreaService areaService;

    @ResponseBody
    @GetMapping("getAreaListByParentId/{parentId}")
    public R getAreaListByParentId(@PathVariable Long parentId){
        Map<String,Object> resultMap=new HashMap<>();
        resultMap.put("areaList",areaService.getAreaListByParentId(parentId));
        return R.ok().data(resultMap);
    }
}
