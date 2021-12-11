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
    <title>流程部署及流程定义列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 流程管理 <span class="c-gray en">&gt;</span> 部署管理 <span
        class="c-gray en">&gt;</span> 流程部署及流程定义列表 <a class="btn btn-success radius r mr-20"
                                                     style="line-height:1.6em;margin-top:3px"
                                                     href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">


    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="5">流程部署信息表</th>
        </tr>

        <tr class="text-c">
            <th width="25"><input type="checkbox" name="" value=""></th>
            <th width="40">部署ID</th>
            <th width="80">部署名称</th>
            <th width="80">发布时间</th>
            <th width="100">操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="d">
            <tr class="text-c">
                <td><input type="checkbox" value="${d.id}" id="id"></td>
                <td>${d.id}</td>
                <td>${d.name}</td>
                <td><fmt:formatDate value="${d.deploymentTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                <td class="td-manage">
                    <a title="删除"
                       href="javascript:;"
                       onclick="deploymentDel('${d.id}')"
                       class="ml-5"
                       style="text-decoration:none"><i
                            class="Hui-iconfont">&#xe6e2;</i></a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    


</div>
<div class="pd-20">


    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="9">流程定义信息表</th>
        </tr>

        <tr class="text-c">
            <th width="25"><input type="checkbox" name="" value=""></th>
            <th width="40">流程定义ID</th>
            <th width="80">名称</th>
            <th width="80">流程定义Key</th>
            <th width="80">流程定义版本</th>
            <th width="80">流程定义规则文件名称</th>
            <th width="80">流程定义规则图片名称</th>
            <th width="80">流程定义部署ID</th>
            <th width="100">操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page2.list}" var="p">
            <tr class="text-c">
                <td><input type="checkbox" value="${p.id}" id="id"></td>
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td>${p.key}</td>
                <td>${p.version}</td>
                <td>${p.resourceName}</td>
                <td>${p.diagramResourceName}</td>
                <td>${p.deploymentId}</td>
                <td class="td-manage">
                    <a title="查看流程图"
                       href="/workFlow/showProcessDiagram?deploymentId=${p.deploymentId}&diagramName=${p.diagramResourceName}" target="_blank"
                       class="ml-5"
                       style="text-decoration:none">查看流程图</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <jsp:include page="/common/page.jsp"></jsp:include>


</div>

<div class="pd-20">
    <form action="workFlow/addDeploy" method="post" class="form form-horizontal" enctype="multipart/form-data">
        <div class="row cl">
            <label class="form-label col-1 ">流程名称：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" name="name" datatype="*2-16" nullmsg="流程名不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-1">流程图：</label>
            <span class="btn-upload form-group">
			<input class="input-text upload-url" type="text" name="uploadfile-2" id="uploadfile-2" readonly  datatype="*" nullmsg="请添加附件！" style="width:200px">
				<a href="javascript:void();" class="btn btn-primary upload-btn"><i class="Hui-iconfont">&#xe642;</i> 浏览文件</a>
				<input type="file" multiple name="file" class="input-file">
			</span>
        </div>

        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
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