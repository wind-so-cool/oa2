package com.cool.dao;

import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-06-23 18:31
 */
public interface BaseMapper<T> {

    int deleteByPrimaryKey(Long orgId);

    int insert(T record);

    int insertSelective(T record);

    T selectByPrimaryKey(Long orgId);

    int updateByPrimaryKeySelective(T record);

    int updateByPrimaryKey(T record);

    List<T> getList(T t);

    int batchDel(Long[] ids);
}
