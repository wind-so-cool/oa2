package com.cool.service;

import com.cool.entity.Leave;

/**
 * @Author 许俊青
 * @Date: 2021-07-06 11:20
 */
public interface LeaveService extends BaseService<Leave> {


    Leave getByTaskId(String taskId);
}
