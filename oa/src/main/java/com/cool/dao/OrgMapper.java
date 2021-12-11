package com.cool.dao;

import com.cool.entity.Org;

import java.util.List;

public interface OrgMapper extends BaseMapper<Org>{

    List<Org> getOrgListByParentId(Long id);

    List<Org> getOrgListByParentIds(Long[] ids);
}