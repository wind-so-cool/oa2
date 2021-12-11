<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

%>
<html>
<head>
    <base href="<%=basePath %>"/>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
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
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>组织列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 数据管理 <span
        class="c-gray en">&gt;</span> 组织管理<span
        class="c-gray en">&gt;</span> 组织列表 <a class="btn btn-success radius r mr-20"
                                              style="line-height:1.6em;margin-top:3px"
                                              href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="">
    <div class="cl pd-5 bg-1 bk-gray"><span class="l"> <a href="javascript:;" onclick="batchDel()"
                                                          class="btn btn-danger radius"><i
            class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" href="javascript:;"
                                                          onclick="orgAdd('添加组织','orgController/toAddOrg','800')"><i
            class="Hui-iconfont">&#xe600;</i> 添加组织</a> </span></div>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr class="text-c">
            <th width="25"><input type="checkbox" value=""></th>
            <th width="40">ID</th>
            <th width="200">组织名称</th>
            <th width="200">父组织名称</th>
            <th width="300">组织描述</th>
            <th width="200">显示顺序</th>
            <th width="70">是否可用</th>
            <th width="200">创建时间</th>
            <th width="70">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="org">

            <tr class="text-c">
                <td><input type="checkbox" value="${org.orgId}" name="orgId" id="orgId"></td>
                <td>${org.orgId}</td>
                <td>${org.orgName}</td>
                <td>${org.orgParentName}</td>
                <td>${org.orgDesc}</td>
                <td>${org.dispIndex}</td>
                <td>${org.state eq 1?"可用":"禁用"}</td>
                <td><fm:formatDate value="${org.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"></fm:formatDate></td>

                <td class="f-14"><a title="编辑" href="javascript:;"
                                    onclick="orgUpdate('编辑组织','orgController/toUpdateOrg/${org.orgId}','800')"
                                    style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除"
                                                                                                             href="javascript:;"
                                                                                                             onclick="orgDel('${org.orgId}')"
                                                                                                             class="ml-5"
                                                                                                             style="text-decoration:none"><i
                        class="Hui-iconfont">&#xe6e2;</i></a></td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
    <jsp:include page="/common/page.jsp"></jsp:include>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="js/oa_utils.js"></script>
<script type="text/javascript">
    /*组织-添加*/
    function orgAdd(title, url, w, h) {
        layer_show(title, url, w, h);
    }

    /*组织-编辑*/
    function orgUpdate(title, url, id, w, h) {
        layer_show(title, url, w, h);
    }

    /*组织-删除*/
    function orgDel(id) {
        layer.confirm('组织删除须谨慎，确认要删除吗？', function (index) {
            $.ajax({
                url: "orgController/delOrg/" + id,
                type:"delete",
                success:function(data) {
                    resultMsg(data);
                }
            })
        });
    }

    //批量删除
    function batchDel() {
        let ids = [];
        $("#orgId:checked").each(function (i, e) {
            ids.push(e.value);
        });


        $.ajax({
            url: "orgController/batchDel",
            type:"post",
            data:{ids:ids,_method:"delete"},
            success:function(data) {
                resultMsg(data, false);
            }
        })

    }

</script>
</body>
</html>