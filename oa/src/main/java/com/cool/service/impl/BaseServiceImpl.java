package com.cool.service.impl;

import com.cool.dao.BaseMapper;
import com.cool.entity.Page;
import com.cool.service.BaseService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-06-23 18:29
 */
public abstract class BaseServiceImpl<T> implements BaseService<T> {

    @Autowired
    private BaseMapper<T> baseMapper;

    @Override
    public int add(T t) {
        return baseMapper.insertSelective(t);
    }

    @Override
    public int update(T t) {
        return baseMapper.updateByPrimaryKeySelective(t);
    }

    @Override
    public int delete(Long id) {
        return baseMapper.deleteByPrimaryKey(id);
    }

    @Override
    public T getById(Long id) {
        return baseMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo<T> getByPage(Page<T> page, T t) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<T> list=baseMapper.getList(t);
        return new PageInfo<T>(list);
    }

    @Override
    public int batchDel(Long[] ids) {
        return baseMapper.batchDel(ids);
    }
}
