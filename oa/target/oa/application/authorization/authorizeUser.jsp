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
    <script type="text/javascript" src="/lib/html5.js"></script>
    <script type="text/javascript" src="/lib/respond.min.js"></script>
    <script type="text/javascript" src="/lib/PIE_IE678.js"></script>
    <![endif]-->
    <link href="/css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="/css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <!--[if IE 6]>
    <script type="text/javascript" src="/lib/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>用户授权列表</title>
</head>
<body class="refreshEle">

<div class="pd-20" style="position:relative">
    <form action="/authorization/getToBeAuthorizedUserPage">
        <div class="text-c">
            <div class="row cl ">
                <div class="formControls col-4">
                    <input type="hidden" name="roleId" value="${roleId}">
                    <input type="hidden" name="queryType" value="${queryType}">
                    登录名: <input type="text" class="input-text" style="width: 250px" name="userName" value="${user.userName}">
                </div>
                <div class="formControls col-4">
                    邮箱： <input type="text" class="input-text" style="width: 250px" name="email" value="${user.email}">
                </div>
                <div class="formControls col-4">
                    手机： <input type="text" class="input-text" style="width: 250px" name="mobilePhone" value="${user.mobilePhone}">
                </div>
            </div>
            <div class="row cl">
                <div class="cl pd-5">
                    <button type="submit"
                            class="btn btn-success radius" id="search" name="">
                        <i class="Hui-iconfont">&#xe665;</i> 搜用户
                    </button>
                    <button type="button"
                            class="btn btn-success radius" id="reset" name=""
                            onclick="javascript:$('input:text').val('');$('form').submit()">
                        <i class="Hui-iconfont">&#xe66b;</i>重置
                    </button>
                </div>
            </div>
        </div>
    </form>

    <table class="table table-border table-bordered table-bg" >
        <thead>

        <tr class="text-c">
            <th width=idth="25"><input type="checkbox" name="" value=""></th>
            <th width="40">ID</th>
            <th width="80">用户名</th>
            <th width="80">部门</th>
            <th width="90">手机</th>
            <th width="150">邮箱</th>
            <th width="40">性别</th>
            <th width="80">生日</th>
            <th width="">区域</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="u">
            <tr class="text-c">
                <td><input type="checkbox" value="${u.userId}" id="userId"></td>
                <td>${u.userId}</td>
                <td>${u.userName}</td>
                <td>${u.orgName}</td>
                <td>${u.mobilePhone}</td>
                <td>${u.email}</td>
                <td>${u.userSex eq 1?'男':'女'}</td>
                <td><fmt:formatDate value="${u.userBirthday}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                <td>${u.provinceName}${u.cityName}${u.contryName}</td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
    <jsp:include page="/common/page.jsp"></jsp:include>
    <div style="position:relative;left:850px;top:290px">
		<span class="l">
			<a href="javascript:;" onclick="authorizeUser()" class="btn btn-primary radius">
				授权
			</a>
		</span>
    </div>
</div>
<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/H-ui.js"></script>
<script type="text/javascript" src="/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/js/oa_utils.js"></script>
<script type="text/javascript">

    /*
        参数解释：
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    /*用户-增加*/
    function userAdd(title, url, w, h) {
        layer_show(title, url, w, h);
    }

    /*用户-编辑*/
    function userUpdate(title, url, w, h) {
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

    /*用户-删除*/
    function userDel(id) {
        layer.confirm('用户删除须谨慎，确认要删除吗？', function (index) {
            $.ajax({
                url: "userController/delUser/" + id,
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
        $("#userId:checked").each(function (i, e) {
            ids.push(e.value);
        });
        $.ajax({
            url: "userController/batchDel/",
            type: "post",
            data: {ids: ids, _method: "delete"},
            success: function (data) {
                resultMsg(data, false);
            }
        })

    }
    function resultMsg(data, isCloseFrame) {
        if (data.success) {
            layer.msg(data.message, {icon: 1, time: 1000}, function () {
                let queryType="${queryType}";
                if(queryType=="1"){
                    console.log("enter")
                    parent.$(".refreshEle:first").load("authorization/getAuthorizedUserListByRoleId/${roleId}?queryType=" + queryType);
                }else if(queryType=="0"){
                    parent.$(".refreshEle:first").load("authorization/getAuthorizedMenuListByRoleId/${roleId}?queryType="+queryType);

                }
                if (isCloseFrame) {
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }
            });
        } else {
            layer.msg(data.message, {icon: 2, time: 1000});
        }
    }
    function getQueryParams(){
        return $("form").serialize();
    }
    function authorizeUser(){
        let ids = [];
        $("#userId:checked").each(function (i, e) {
            ids.push(e.value);
        });
        $.ajax({
            url: "authorization/authorizeUser/",
            type: "post",
            data: {userIds: ids, roleId:"${roleId}"},
            success: function (data) {
                resultMsg(data, true);
            }
        })
    }
</script>
</body>
</html>