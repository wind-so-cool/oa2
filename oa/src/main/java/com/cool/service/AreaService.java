package com.cool.service;

import com.cool.entity.Area;

import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-07-11 18:21
 */
public interface AreaService extends BaseService<Area> {

    List<Area> getAreaListByParentId(Long parentId);
}
