<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=request.getContextPath() + "/"%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <title></title>
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red"></span>请假天数：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="${leave.days}" placeholder="" id="days" name="days"
                       datatype="*1-3" disabled="disabled" nullmsg="请假天数不能为空" errorsmg="请输入1-3位请假天数">
            </div>
            <div class="col-4"></div>
        </div>

        <div class="row cl">
            <label class="form-label col-3"><span class="c-red"></span>请假事由：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="${leave.reason}" placeholder="" id="content" name="content"
                       datatype="*2-50" disabled="disabled" nullmsg="请假事由不能为空" errorsmg="请假事由为2-50字">
            </div>
            <div class="col-4"></div>
        </div>

        <div class="row cl">
            <label class="form-label col-3">请假备注：</label>
            <div class="formControls col-5">
                <textarea id="remark" name="remark" cols="" rows="" class="textarea" placeholder="请输入请假备注...150个字符以内"
                          dragonfly="true" disabled="disabled" onKeyUp="textarealength(this,150)">${leave.ps}</textarea>
            </div>
            <div class="col-4"></div>
        </div>
    </form>

    <form class="form form-horizontal">

        <div class="row cl">
            <label class="form-label col-3">批注信息：</label>
            <div class="formControls col-5">
                <textarea id="comment" name="comment" cols="" rows="" class="textarea" placeholder="请输入批注信息...150个字符以内"
                          dragonfly="true" onKeyUp="textarealength(this,150)"></textarea>
                <input id="taskId" name="taskId" type="hidden" value="${taskId}"></input>
                <input id="leaveId" name="leaveId" type="hidden" value="${leave.id}"></input>

            </div>
            <div class="col-4"></div>
        </div>

        <div class="row cl">
            <div class="col-9 col-offset-3">
                <c:forEach items="${lineList}" var="lineName">
                    <input class="btn btn-primary radius" name="outcome" onclick="completeMyTask('${lineName}')"
                           type="button" value="${lineName}">
                </c:forEach>
            </div>
        </div>
    </form>
</div>


<div class="pd-20">
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="4">任务批注信息列表</th>
        </tr>

        <tr class="text-c">
            <th width="40">任务ID</th>
            <th width="80">批注信息</th>
            <th width="80">处理时间</th>
            <th width="80">办理人</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${comments}" var="comment">
            <tr class="text-c">
                <td>${comment.taskId}</td>
                <td>${comment.fullMessage}</td>
                <td><fmt:formatDate value="${comment.time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${comment.userId}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="lib/layer/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="js/oa_utils.js"></script>
<script type="text/javascript" src="js/getArea.js"></script>

<script type="text/javascript">
    $(function () {
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-menu-add").Validform(
            {
                tiptype: 2,
                callback: function (form) {
                    submitForm("form-menu-add", "leavebill/addLeavebill");
                    return false;
                }
            });


    });

    function completeMyTask(outcome) {
        let params = {
            taskId: $("#taskId").val(),
            comment:$("#comment").val(),
            leaveId:$("#leaveId").val(),
            outcome:outcome
        };
        $.post("/workFlow/completeMyTask",params,function(data){
            console.log(data);
            if (data.success) {
                window.location.href="/workFlow/toTaskPage";
            } else {
                layer.msg(data.message, {icon: 2, time: 1000});
            }
        })
    }

</script>
</body>
</html>