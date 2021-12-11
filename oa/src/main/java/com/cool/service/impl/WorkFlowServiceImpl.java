package com.cool.service.impl;

import com.cool.common.OAException;
import com.cool.common.Utils;
import com.cool.dao.LeaveMapper;
import com.cool.entity.Leave;
import com.cool.entity.Page;
import com.cool.entity.WorkFlowDto;
import com.github.pagehelper.PageInfo;
import com.cool.service.WorkFlowService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.*;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;

/**
 * @Author 许俊青
 * @Date: 2021-11-14 19:27
 */
@Service
public class WorkFlowServiceImpl implements WorkFlowService {

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private TaskService taskService;

    @Autowired
    private LeaveMapper leaveMapper;

    @Override
    public PageInfo<Deployment> getDeploymentList(Page<Object> page) {
        DeploymentQuery query=repositoryService.createDeploymentQuery();
        int firstResult=page.getPageSize()*(page.getCurrentPage()-1);
        int maxResults=page.getCurrentPage()*page.getPageSize();
        List<Deployment> deploymentList= query.orderByDeploymenTime().desc().listPage(firstResult,maxResults);
        PageInfo<Deployment> pageInfo=new PageInfo<>();
        long total=query.count();
        pageInfo.setList(deploymentList);
        pageInfo.setTotal(total);
        pageInfo.setPageNum(page.getCurrentPage());
        pageInfo.setPageSize(page.getPageSize());
        return pageInfo;
    }

    @Override
    public PageInfo<ProcessDefinition> getProcessDefList(Page<Object> page) {
        ProcessDefinitionQuery query=repositoryService.createProcessDefinitionQuery();
        int firstResult=page.getPageSize()*(page.getCurrentPage()-1);
        int maxResults=page.getCurrentPage()*page.getPageSize();
        List<ProcessDefinition> processDefList=query.orderByProcessDefinitionId().desc().listPage(firstResult,maxResults);
        PageInfo<ProcessDefinition> pageInfo=new PageInfo<>();
        long total=query.count();
        pageInfo.setList(processDefList);
        pageInfo.setTotal(total);
        pageInfo.setPageNum(page.getCurrentPage());
        pageInfo.setPageSize(page.getPageSize());
        return pageInfo;
    }

    @Override
    public void delete(String id) {
        ProcessDefinition processDefinition=repositoryService.createProcessDefinitionQuery().deploymentId(id).singleResult();
        Execution execution=runtimeService.createExecutionQuery().processDefinitionId(processDefinition.getId()).singleResult();
        if(execution!=null){
            throw new OAException("流程正在执行,无法删除");
        }
        repositoryService.deleteDeployment(id);

    }
    @GetMapping("showProcessDiagram")
    @Override
    public InputStream showProcessDiagram(String deploymentId, String diagramName) {
        return repositoryService.getResourceAsStream(deploymentId,diagramName);
    }

    @Override
    public void addDeploy(InputStream inputStream, String name) {
        DeploymentBuilder builder=repositoryService.createDeployment();
        builder.name(name);
        builder.addZipInputStream(new ZipInputStream(inputStream));
        builder.deploy();
    }

    @Override
    public PageInfo<Task> getTaskList(Page<Object> page) {
        TaskQuery query=taskService.createTaskQuery();
        int firstResult=page.getPageSize()*(page.getCurrentPage()-1);
        int maxResults=page.getCurrentPage()*page.getPageSize();
        List<Task> taskList=query.taskAssignee(Utils.getCurrentUser().getUserName()).orderByTaskCreateTime().desc().listPage(firstResult,maxResults);
        PageInfo<Task> pageInfo=new PageInfo<>();
        long total=query.count();
        pageInfo.setList(taskList);
        pageInfo.setTotal(total);
        pageInfo.setPageNum(page.getCurrentPage());
        pageInfo.setPageSize(page.getPageSize());
        return pageInfo;
    }

    @Override
    @Transactional
    public void startProcess(Long leaveId) {
        Leave leave=leaveMapper.selectByPrimaryKey(leaveId);
        String key=leave.getClass().getSimpleName();
        String businessKey=key+"_"+leaveId;
        Map<String,Object> variables=new HashMap<>();
        variables.put("username",Utils.getCurrentUser().getUserName());
        runtimeService.startProcessInstanceByKey(key,businessKey,variables);
        leave.setState(1L);
        leaveMapper.updateByPrimaryKeySelective(leave);
    }

    @Override
    public List<String> getLineListByTaskId(String taskId) {
        Task task=taskService.createTaskQuery().taskId(taskId).singleResult();
        ProcessInstance processInstance=runtimeService.createProcessInstanceQuery().processInstanceId(task.getProcessInstanceId()).singleResult();
        String processDefineId=processInstance.getProcessDefinitionId();
        String activityId=processInstance.getActivityId();
        //ProcessDefinitionEntity processDefinitionEntity= (ProcessDefinitionEntity) repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefineId).singleResult();
        ProcessDefinitionEntity processDefinitionEntity= (ProcessDefinitionEntity) repositoryService.getProcessDefinition(processDefineId);
        ActivityImpl activity=processDefinitionEntity.findActivity(activityId);
        List<PvmTransition> outgoingTransitions = activity.getOutgoingTransitions();
        List<String> lineList=new ArrayList<>();
        outgoingTransitions.forEach(o->{
            String name= (String) o.getProperty("name");
            if(StringUtils.isNotBlank(name)){
                lineList.add(name);
            }
        });
        return lineList;
    }

    @Override
    public List<Comment> getComentsByTaskId(String taskId) {
        String processInstanceId=taskService.createTaskQuery().taskId(taskId).singleResult().getProcessInstanceId();
        List<Comment> comments = taskService.getProcessInstanceComments(processInstanceId);
        return comments;
    }

    @Override
    @Transactional
    public void completeMyTask(WorkFlowDto dto) {
        Task task=taskService.createTaskQuery().taskId(dto.getTaskId()).singleResult();

        Map<String,Object> variables=new HashMap<>();
        variables.put("outcome",dto.getOutcome());
        Authentication.setAuthenticatedUserId(Utils.getCurrentUser().getUserName());
        taskService.addComment(dto.getTaskId(),task.getProcessInstanceId(),dto.getComment());
        taskService.complete(dto.getTaskId(),variables);
        ProcessInstance processInstance=runtimeService.createProcessInstanceQuery().processInstanceId(task.getProcessInstanceId()).singleResult();
        Leave leave=new Leave();
        leave.setId(dto.getLeaveId());
        if(processInstance==null){
            leave.setState(4L);
        }else{
            Task currentTask=taskService.createTaskQuery().processInstanceId(processInstance.getProcessInstanceId()).singleResult();
            String currentTaskName=currentTask.getName();
            leave.setState("学生提交".equals(currentTaskName)?1L:"讲师审批".equals(currentTaskName)?2L:3L);
        }

        leaveMapper.updateByPrimaryKeySelective(leave);

    }
}
