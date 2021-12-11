package com.cool.service;

import com.cool.entity.Page;
import com.cool.entity.WorkFlowDto;
import com.github.pagehelper.PageInfo;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;

import java.io.InputStream;
import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-11-14 19:25
 */
public interface WorkFlowService {

    PageInfo<Deployment> getDeploymentList(Page<Object> page);

    PageInfo<ProcessDefinition> getProcessDefList(Page<Object> page);

    void delete(String id);

    InputStream showProcessDiagram(String deploymentId, String diagramName);

    void addDeploy(InputStream inputStream, String name);

    PageInfo<Task> getTaskList(Page<Object> page);

    void startProcess(Long leaveId);

    List<String> getLineListByTaskId(String taskId);

    List<Comment> getComentsByTaskId(String taskId);

    void completeMyTask(WorkFlowDto dto);
}
