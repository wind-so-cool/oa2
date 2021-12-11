package com.cool.test;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;

/**
 * @Author 许俊青
 * @Date: 2021-11-06 14:02
 */
public class NextTaskListener implements TaskListener {
    @Override
    public void notify(DelegateTask delegateTask) {
        String taskName=delegateTask.getName();
        if("讲师审批".equals(taskName)){
            delegateTask.setAssignee("王老师");
        }else if("班主任审批".equals(taskName)){
            delegateTask.setAssignee("黄老师");
        }
    }
}
