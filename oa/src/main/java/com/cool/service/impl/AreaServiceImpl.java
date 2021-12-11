package com.cool.service.impl;

import com.cool.dao.AreaMapper;
import com.cool.entity.Area;
import com.cool.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-07-11 18:22
 */
@Service
public class AreaServiceImpl extends BaseServiceImpl<Area> implements AreaService {

    @Autowired
    private AreaMapper areaMapper;

    public List<Area> getAreaListByParentId(Long parentId){
        return areaMapper.getAreaListByParentId(parentId);
    }
}
