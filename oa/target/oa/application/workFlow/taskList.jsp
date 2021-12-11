<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

%>
<html>
<head>
    <base href="<%=basePath %>"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <LINK rel="Bookmark" href="/favicon.ico">
    <LINK rel="Shortcut Icon" href="/favicon.ico"/>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="lib/html5.js"></script>
    <script type="text/javascript" src="lib/respond.min.js"></script>
    <script type="text/javascript" src="lib/PIE_IE678.js"></script>
    <![endif]-->
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <!--[if IE 6]>
    <script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>任务列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 流程管理 <span class="c-gray en">&gt;</span> 任务管理 <span
        class="c-gray en">&gt;</span> 任务列表 <a class="btn btn-success radius r mr-20"
                                                     style="line-height:1.6em;margin-top:3px"
                                                     href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">


    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="6">任务列表</th>
        </tr>

        <tr class="text-c">
            <th width="25"><input type="checkbox" name="" value=""></th>
            <th width="40">任务ID</th>
            <th width="80">任务名称</th>
            <th width="80">创建时间</th>
            <th width="80">办理人</th>
            <th width="100">操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="t">
            <tr class="text-c">
                <td><input type="checkbox" value="${t.id}" id="id"></td>
                <td>${t.id}</td>
                <td>${t.name}</td>
                <td><fmt:formatDate value="${t.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                <td>${t.assignee}</td>

                <td class="td-manage">
                    <a title="处理任务"
                       href="/workFlow/getTaskInfo?taskId=${t.id}"
                       onclick=""
                       class="ml-5"
                       style="text-decoration:none">处理任务</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <jsp:include page="/common/page.jsp"></jsp:include>



</div>




<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="js/oa_utils.js"></script>
<script type="text/javascript">


    /*流程部署-删除*/
    function deploymentDel(id) {
        layer.confirm('流程部署删除须谨慎，确认要删除吗？', function (index) {
            $.ajax({
                url: "workFlow/delDeployment/" + id,
                type: "delete",
                success: function (data) {
                    resultMsg(data);
                }
            })


        });
    }


</script>
</body>
</html>