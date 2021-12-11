package com.cool.controller;

import com.cool.common.R;
import com.cool.entity.Org;
import com.cool.entity.Page;
import com.cool.service.OrgService;
import com.cool.service.UserService;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
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
 * @Date: 2021-06-23 23:05
 */
@Controller
@RequestMapping("orgController")
@Slf4j
public class OrgController {

    @Autowired
    private UserService userService;


    @Autowired
    private OrgService orgService;

    @GetMapping("getOrgPage")
    public String getOrgPage(Page<Org> page, ModelMap map) {
        PageInfo<Org> pageInfo = orgService.getByPage(page, null);
        map.put("page", pageInfo);
        map.put("url", "orgController/getOrgPage?");
        return "org/orgList";
    }

    @GetMapping("toAddOrg")
    public String toAddOrg() {
        return "org/orgAdd";
    }

    @PostMapping(value = "addOrg", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R addOrg(Org org) {
        orgService.add(org);
        return R.ok();
    }


    @ResponseBody
    @GetMapping(value = "getOrgList", produces = "application/json;charset=utf-8")
    public List<Map<String, Object>> getOrgList(Long id) {
        if (id == null) {
            id = -1L;
        }
        List<Org> orgList = orgService.getOrgListByParentId(id);
        List<Map<String, Object>> data = new ArrayList<>();
        for (Org org : orgList) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", org.getOrgId());
            map.put("name", org.getOrgName());
            map.put("isParent", !CollectionUtils.isEmpty(orgService.getOrgListByParentId(org.getOrgId())));
            data.add(map);
        }
        return data;
    }

    @GetMapping("toUpdateOrg/{id}")
    public String toUpdateOrg(@PathVariable Long id, ModelMap map) {
        Org org = orgService.getById(id);
        map.put("org", org);
        return "org/orgUpdate";
    }

    @PutMapping(value = "updateOrg", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R upadteOrg(Org org) {
        orgService.update(org);
        return R.ok();
    }

    @DeleteMapping(value = "delOrg/{id}", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R delOrg(@PathVariable Long id) {
        List<Org> orgList = orgService.getOrgListByParentId(id);
        int userCount = userService.getUserCountByOrgId(id);
        if (CollectionUtils.isEmpty(orgList) && userCount == 0) {
            orgService.delete(id);
            return R.ok();
        }
        return R.error().message("该组织下有子组织或有员工,不能删除");

    }


    @DeleteMapping(value = "batchDel", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R batchDel(@RequestParam("ids[]") Long[] ids) {
        List<Org> subOrgList = orgService.getOrgListByParentIds(ids);
        int userCount = userService.getUserCountByOrgIds(ids);
        ;
        if (CollectionUtils.isEmpty(subOrgList) && userCount == 0) {
            orgService.batchDel(ids);
            return R.ok();
        }

        return R.error().message("所选组织下有子组织或有员工,不能删除");

    }

}
