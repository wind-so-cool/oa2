package com.cool.service;

import com.cool.entity.Page;
import com.github.pagehelper.PageInfo;

/**
 * @Author 许俊青
 * @Date: 2021-06-23 18:06
 */
public interface BaseService<T>{

    public int add(T t);

    int update(T t);

    int delete(Long id);

    T getById(Long id);

    PageInfo<T> getByPage(Page<T> page, T t);

    int batchDel(Long[] ids);


}
