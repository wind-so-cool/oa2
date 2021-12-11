package com.cool.service;

import com.cool.entity.Org;

import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-06-23 23:08
 */
public interface OrgService extends BaseService<Org> {
    List<Org> getOrgListByParentId(Long id);

    List<Org> getOrgListByParentIds(Long[] ids);
}
