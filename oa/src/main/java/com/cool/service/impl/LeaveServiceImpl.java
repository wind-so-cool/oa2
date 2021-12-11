package com.cool.service.impl;

import com.cool.dao.LeaveMapper;
import com.cool.entity.Leave;
import com.cool.service.LeaveService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author 许俊青
 * @Date: 2021-07-06 11:21
 */
@Service
public class LeaveServiceImpl extends BaseServiceImpl<Leave> implements LeaveService {

    @Autowired
    private LeaveMapper leaveMapper;

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;


    @Override
    public Leave getByTaskId(String taskId) {
        String processInstanceId = taskService.createTaskQuery().taskId(taskId).singleResult().getProcessInstanceId();
        ProcessInstance processInstance=runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        String businessKey=processInstance.getBusinessKey();
        String leaveId=businessKey.split("_")[1];
        return leaveMapper.selectByPrimaryKey(Long.valueOf(leaveId));
    }
}
