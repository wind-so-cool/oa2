package com.cool.test;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.runtime.ProcessInstance;
import org.junit.Test;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipInputStream;

/**
 * @Author 许俊青
 * @Date: 2021-11-06 16:30
 */
public class Test2 {
    
    @Test
    public void testDeployeeProcessIns() throws FileNotFoundException {
        ProcessEngine processEngine= ProcessEngines.getDefaultProcessEngine();
        RepositoryService repositoryService=processEngine.getRepositoryService();
        DeploymentBuilder deploymentBuilder=repositoryService.createDeployment();
        deploymentBuilder.name("测试请假流程");
        deploymentBuilder.addZipInputStream(new ZipInputStream(new FileInputStream("E:\\project\\oa\\src\\main\\resources\\hello3.zip")));
        Deployment deployment=deploymentBuilder.deploy();
        System.out.println("部署成功");
        System.out.println("部署id:"+deployment.getId());
        System.out.println("部署名称:"+deployment.getName());
        
    }

    @Test
    public void testStartProcessIns() throws FileNotFoundException {
        ProcessEngine processEngine= ProcessEngines.getDefaultProcessEngine();
        RuntimeService runtimeService=processEngine.getRuntimeService();
        Map<String,Object> map=new HashMap<>();
        map.put("username","张三");
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("hello3", map);
        System.out.println("流程实例id:"+processInstance.getProcessInstanceId());
        System.out.println("流程定义id:"+processInstance.getProcessDefinitionId());
    }
}
