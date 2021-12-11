package com.cool.test;

import com.alibaba.fastjson.util.IOUtils;
import org.activiti.engine.*;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author 许俊青
 * @Date: 2021-06-23 16:54
 */

@RunWith(value= SpringJUnit4ClassRunner.class)
@ContextConfiguration(value="classpath:spring-mybatis.xml")
public class Test1 {

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    @org.junit.Test
    public void testSqlSessionFactory(){
        System.out.println(sqlSessionFactory);
    }

    @org.junit.Test
    public void initActiviti(){
        ProcessEngineConfiguration processEngineConfiguration=ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration();
        processEngineConfiguration.setJdbcDriver("com.mysql.jdbc.Driver");
        processEngineConfiguration.setJdbcUrl("jdbc:mysql://localhost:3306/oa?useUnicode=true&characterEncoding=utf8&serverTimezone=GMT%2B8");
        processEngineConfiguration.setJdbcUsername("root");
        processEngineConfiguration.setJdbcPassword("123456");
        processEngineConfiguration.setDatabaseSchemaUpdate("true");
        ProcessEngine processEngine=processEngineConfiguration.buildProcessEngine();
        System.out.println(processEngine);
    }

    @org.junit.Test
    public void testProcessDeploy(){
        ProcessEngine processEngine= ProcessEngines.getDefaultProcessEngine();
        RepositoryService repositoryService=processEngine.getRepositoryService();
        DeploymentBuilder deploymentBuilder=repositoryService.createDeployment();
        deploymentBuilder.addClasspathResource("hello.bpmn");
        deploymentBuilder.addClasspathResource("hello.png");
        deploymentBuilder.name("第一次部署流程图");
        Deployment deployment=deploymentBuilder.deploy();
        System.out.println("部署成功");
        System.out.println("部署名称:"+deployment.getName());
        System.out.println("部署id:"+deployment.getId());
        System.out.println("部署时间:"+deployment.getDeploymentTime());
    }

    @org.junit.Test
    public void testDelProcessDeploy(){
        ProcessEngine processEngine= ProcessEngines.getDefaultProcessEngine();
        RepositoryService repositoryService=processEngine.getRepositoryService();
        repositoryService.deleteDeployment("901");
    }

    @org.junit.Test
    public void testGetProcessPng(){
        ProcessEngine processEngine= ProcessEngines.getDefaultProcessEngine();
        RepositoryService repositoryService=processEngine.getRepositoryService();
        InputStream is = repositoryService.getResourceAsStream("301", "hello.png");
        File file=new File("./hello.png");
        try {
            Files.copy(is, Paths.get(file.getAbsolutePath()));
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            IOUtils.close(is);
        }
    }
    @org.junit.Test
    public void testStartProcessIns(){
        ProcessEngine processEngine= ProcessEngines.getDefaultProcessEngine();
        RuntimeService runtimeService=processEngine.getRuntimeService();
        ProcessInstance processInstance=runtimeService.startProcessInstanceByKey("hello");
        System.out.println("流程实例id:"+processInstance.getProcessInstanceId());
        System.out.println("流程定义id:"+processInstance.getProcessDefinitionId());
    }

    @org.junit.Test
    public void testQueryTaskByProcessInsId(){
        ProcessEngine processEngine= ProcessEngines.getDefaultProcessEngine();
        TaskService taskService=processEngine.getTaskService();
        TaskQuery taskQuery=taskService.createTaskQuery();
        Task task=taskQuery.processInstanceId("1501").singleResult();
        System.out.println("taskId:"+task.getId());
        System.out.println("节点名称:"+task.getName());
        System.out.println("处理人:"+task.getAssignee());
        System.out.println("流程实例id:"+task.getProcessInstanceId());
        System.out.println("流程定义id:"+task.getProcessDefinitionId());
    }
    @org.junit.Test
    public void testCompleteProcess(){
        String taskId="1202";
        ProcessEngine processEngine= ProcessEngines.getDefaultProcessEngine();
        TaskService taskService=processEngine.getTaskService();
        Map<String,Object> map=new HashMap<>();
        map.put("outcome","同意");
        taskService.complete(taskId,map);
        System.out.println("完成了taskId ["+taskId+"] 的任务");
    }
}
