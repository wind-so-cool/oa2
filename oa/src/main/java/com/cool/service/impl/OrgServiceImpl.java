package com.cool.service.impl;

import com.cool.dao.OrgMapper;
import com.cool.entity.Org;
import com.cool.service.OrgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-06-23 18:53
 */
@Service
public class OrgServiceImpl extends BaseServiceImpl<Org> implements OrgService {

    @Autowired
    private OrgMapper orgMapper;


    @Override
    public List<Org> getOrgListByParentId(Long id) {
        return orgMapper.getOrgListByParentId(id);
    }

    @Override
    public List<Org> getOrgListByParentIds(Long[] ids) {
        return orgMapper.getOrgListByParentIds(ids);
    }
}
