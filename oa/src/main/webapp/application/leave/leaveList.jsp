<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fm" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=request.getContextPath() %>/">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <LINK rel="Bookmark" href="/favicon.ico">
    <LINK rel="Shortcut Icon" href="/favicon.ico"/>
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <title>请假列表</title>
</head>
<body id="user_list_body">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 流程管理 <span class="c-gray en">&gt;</span> 请假管理 <span
        class="c-gray en">&gt;</span> 请假列表<a class="btn btn-success radius r mr-20"
                                             style="line-height:1.6em;margin-top:3px"
                                             href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="cl pd-5 bg-1 bk-gray mt-20">
		<span class="l">
			<a href="javascript:;" onclick="leave_add('添加请假申请','leave/toAddLeave','800','550')"
               class="btn btn-primary radius">
				<i class="Hui-iconfont">&#xe600;</i> 添加请假申请
			</a>
		</span>
    </div>
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="10">请假申请列表</th>
        </tr>
        <tr class="text-c">
            <th width="40">ID</th>
            <th width="80">请假人</th>
            <th width="80">请假天数</th>
            <th width="90">请假理由</th>
            <th width="150">请假备注</th>
            <th width="40">申请时间</th>
            <th width="80">请假状态</th>
            <th width="100">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="leave">
            <tr class="text-c">
                <td>${leave.id}</td>
                <td>${leave.userName}</td>
                <td>${leave.days}</td>
                <td>${leave.reason}</td>
                <td>${leave.ps}</td>
                <td><fm:formatDate value="${leave.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>
                    <c:if test="${leave.state == 0}">
                        初始录入
                    </c:if>
                    <c:if test="${leave.state == 1}">
                        待提交
                    </c:if>
                    <c:if test="${leave.state == 2}">
                        讲师审批中
                    </c:if>
                    <c:if test="${leave.state == 3}">
                        班主任审批中
                    </c:if>
                    <c:if test="${leave.state == 4}">
                        审批通过
                    </c:if>
                </td>
                <td class="f-14">

                    <c:if test="${leave.state == 0}">
                        <a title="启动请假流程" href="workFlow/startProcess?leaveId=${leave.id}"
                           style="text-decoration: none"><i class="Hui-iconfont">&#xe601;</i></a>
                    </c:if>

                    <a title="详情" class="ml-5" href="javascript:;"
                       onclick="admin_role_edit('请假详情','workFlow/findHistoryInfo?leaveId=${leave.id}','1','600','500')"
                       style="text-decoration: none">
                        <i class="Hui-iconfont">&#xe683;</i>
                    </a>

                    <a title="删除" href="javascript:;" onclick="admin_role_del(this,${leave.id})" class="ml-5"
                       style="text-decoration: none">
                        <i class="Hui-iconfont">&#xe6e2;</i>
                    </a>
                </td>
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
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    /*管理员-增加*/
    function leave_add(title, url, w, h) {
        layer_show(title, url, w, h);
    }
</script>
</body>
</html>