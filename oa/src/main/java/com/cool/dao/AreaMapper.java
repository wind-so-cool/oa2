package com.cool.dao;

import com.cool.entity.Area;

import java.util.List;

public interface AreaMapper extends BaseMapper<Area>{

    List<Area> getAreaListByParentId(Long parentId);

}