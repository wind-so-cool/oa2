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
        <title>菜单列表</title>
        </head>
        <body>
        <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 数据管理 <span class="c-gray en">&gt;</span>菜单管理 <span
        class="c-gray en">&gt;</span> 菜单列表 <a class="btn btn-success radius r mr-20"
        style="line-height:1.6em;margin-top:3px"
        href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
        <div class="pd-20">
        <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l"><a href="javascript:;" onclick="batchDel()"
        class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a
        href="javascript:;" onclick="menuAdd('添加菜单','menuController/toAddMenu','800','650')"
        class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加菜单 </a></span> <span
        class="r">共有数据：<strong>54</strong> 条</span></div>
        <table class="table table-border table-bordered table-bg">
        <thead>

        <tr class="text-c">
        <th width=idth="25"><input type="checkbox" name="" value=""></th>
        <th width="40">ID</th>
        <th width="200">菜单名称</th>
        <th width="200">父菜单名称</th>
        <th width="200">类型</th>
        <th width="60">菜单路径</th>
        <th width="60">权限码</th>
        <th width="70">描述</th>
        <th width="70">是否发布</th>
        <th width="150">创建时间</th>
        <th width="70">操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="m">
            <tr class="text-c">
            <td style="width:50px"><input type="checkbox" value="${m.menuId}" id="menuId"></td>
            <td>${m.menuId}</td>
            <td>${m.menuName}</td>
            <td>${m.menuParentName}</td>
            <td>${m.menuType==1?"目录":m.menuType==2?"菜单":"按钮"}</td>
            <td>${m.menuPath }</td>
            <td>${m.permissionCode}</td>
            <td>${m.descContent }</td>
            <td>${m.isPublish==1?"已发布":"未发布" }</td>
            <td><fmt:formatDate value="${m.createdDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>

            <td class="td-manage"><a style="text-decoration:none" onClick="admin_stop(this,'10001')"
            href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a> <a
            title="编辑" href="javascript:;"
            onclick="menuUpdate('菜单编辑','menuController/toMenuUpdate/${m.menuId}','800','650')" class="ml-5"
            style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除"
            href="javascript:;"
            onclick="menuDel('${m.menuId}')"
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
        <script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
        <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript" src="js/H-ui.js"></script>
        <script type="text/javascript" src="js/H-ui.admin.js"></script>
        <script type="text/javascript" src="js/oa_utils.js"></script>
        <script type="text/javascript">
        /*
        参数解释：
        title 标题
        url 请求的url
        id 需要操作的数据id
        w 弹出层宽度（缺省调默认值）
        h 弹出层高度（缺省调默认值）
        */
        /*菜单-增加*/
        function menuAdd(title, url, w, h) {
        layer_show(title, url, w, h);
        }

        /*菜单-编辑*/
        function menuUpdate(title, url, w, h) {
        layer_show(title, url, w, h);
        }

        /*管理员-停用*/
        function admin_stop(obj, id) {
        layer.confirm('确认要停用吗？', function (index) {
        //此处请求后台程序，下方是成功后的前台处理……

        $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_start(this,id)" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
        $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">已禁用</span>');
        $(obj).remove();
        layer.msg('已停用!', {icon: 5, time: 1000});
        });
        }

        /*管理员-启用*/
        function admin_start(obj, id) {
        layer.confirm('确认要启用吗？', function (index) {
        //此处请求后台程序，下方是成功后的前台处理……


        $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
        $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
        $(obj).remove();
        layer.msg('已启用!', {icon: 6, time: 1000});
        });
        }

        /*菜单删除*/
        function menuDel(id) {
        layer.confirm('菜单删除须谨慎，确认要删除吗？', function (index) {
        $.ajax({
        url: "menuController/delMenu/" + id,
        type: "delete",
        success: function (data) {
        resultMsg(data);
        }
        })


        });
        }

        //批量删除
        function batchDel() {
        let ids = [];
        $("#menuId:checked").each(function (i, e) {
        ids.push(e.value);
        });
        $.ajax({
        url: "menuController/batchDel/",
        type: "post",
        data: {ids: ids, _method: "delete"},
        success: function (data) {
        resultMsg(data, false);
        }
        })

        }

        function getQueryParams(){
        return $("form").serialize();
        }
        </script>
        </body>
        </html>