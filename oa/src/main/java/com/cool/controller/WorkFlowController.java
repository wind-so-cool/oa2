package com.cool.controller;

import com.cool.common.R;
import com.cool.entity.Leave;
import com.cool.entity.Page;
import com.cool.entity.WorkFlowDto;
import com.cool.service.LeaveService;
import com.cool.service.WorkFlowService;
import org.activiti.engine.task.Comment;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-11-14 19:22
 */
@Controller
@RequestMapping("/workFlow")
public class WorkFlowController {

    @Autowired
    private WorkFlowService workFlowService;

    @Autowired
    private LeaveService leaveService;




    @GetMapping("toDeploymentAndProcessDefPage")
    public String toDeploymentAndProcessDefPage(Page<Object> page, ModelMap map) {
        map.put("page", workFlowService.getDeploymentList(page));
        map.put("page2", workFlowService.getProcessDefList(page));
        map.put("url","/workFlow/toDeploymentAndProcessDefPage?");
        return "workFlow/deploymentAndProcessDefList";
    }


    @GetMapping("toTaskPage")
    public String toTaskPage(Page<Object> page, ModelMap map) {
        map.put("page", workFlowService.getTaskList(page));
        map.put("url","/workFlow/toTaskPage?");
        return "workFlow/taskList";
    }


    @DeleteMapping(value = "delDeployment/{id}", produces = "application/json;charset=utf-8")
    @ResponseBody
    public R delDeployement(@PathVariable String id) {
        workFlowService.delete(id);
        return R.ok();

    }
    @GetMapping("showProcessDiagram")
    public void showProcessDiagram(String deploymentId, String diagramName, HttpServletResponse response) throws IOException {
        InputStream is = null;
        try {
            is = workFlowService.showProcessDiagram(deploymentId, diagramName);
            IOUtils.copy(is, response.getOutputStream());
        } finally {
            if (is != null) {
                is.close();
            }
        }


    }

    @PostMapping("addDeploy")
    public String addDeploy(MultipartFile file,String name) throws IOException {
        workFlowService.addDeploy(file.getInputStream(),name);
        return "redirect:toDeploymentAndProcessDefPage";
    }

    @GetMapping("startProcess")
    public String startProcess(Long leaveId){
        workFlowService.startProcess(leaveId);
        return "redirect:toTaskPage";
    }

    @GetMapping("getTaskInfo")
    public String getTaskInfo(String taskId,ModelMap map){
        Leave leave=leaveService.getByTaskId(taskId);
        List<String> lineList=workFlowService.getLineListByTaskId(taskId);
        List<Comment> comments=workFlowService.getComentsByTaskId(taskId);
        map.put("leave",leave);
        map.put("lineList",lineList);
        map.put("comments",comments);
        map.put("taskId",taskId);
        return "workFlow/taskInfo";
    }

    @PostMapping("completeMyTask")
    @ResponseBody
    public R completeMyTask(WorkFlowDto dto){
        workFlowService.completeMyTask(dto);
        return R.ok();


    }
}
