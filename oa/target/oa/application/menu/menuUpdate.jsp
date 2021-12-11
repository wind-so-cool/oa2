<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <!-- 引入树插件的样式文件 -->
    <link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">

    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>编辑菜单</title>
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-menu-update">
        <input name="menuId" value="${menu.menuId}" type="hidden"/>

    <div class="row cl">
    <label class="form-label col-3"><span class="c-red">*</span>菜单名称：</label>
    <div class="formControls col-5">
    <input type="text" class="input-text" value="${menu.menuName}" placeholder="" id="menuName" name="menuName" datatype="*"
    nullmsg="菜单名称不能为空" >
    </div>
    <div class="col-4"> </div>
    </div>

    <div class="row cl">
    <label class="form-label col-3"><span class="c-red">*</span>父菜单名称：</label>
    <div class="formControls col-5">
    <input type="text" class="input-text" value="${menu.menuParentName}" placeholder="" id="menuParentName" name="menuParentName"
    readonly datatype="*"
    nullmsg="父菜单名称不能为空">
    <input type="hidden" class="input-text" value="${menu.menuParentId}" placeholder="" id="menuParentId" name="menuParentId">
    <button id="btn-star" type="button" class="btn btn-default"
    onclick="getParent1('menuController/getMenuList','父菜单名称','menuParentId','menuParentName')">选择菜单</button>
    </div>
    <!-- 表单验证错误信息的 -->
    <div class="col-4"> </div>
    </div>

    <div class="row cl">
    <label class="form-label col-3">类型：</label>
    <div class="formControls col-5"> <span class="select-box" style="width:150px;">
    <select class="select" name="menuType" size="1">
    <option value="1" ${menu.menuType==1?"selected":""}>目录</option>
    <option value="2" ${menu.menuType==2?"selected":""}>菜单</option>
    <option value="3" ${menu.menuType==3?"selected":""}>按钮</option>
    </select>
    </span> </div>
    </div>

    <div class="row cl">
    <label class="form-label col-3"><span class="c-red"></span>菜单路径：</label>
    <div class="formControls col-5">
    <input type="text" class="input-text" value="${menu.menuPath}" placeholder="" id="menuPath" name="menuPath" >
    </div>
    <div class="col-4"> </div>
    </div>

    <div class="row cl">
    <label class="form-label col-3"><span class="c-red"></span>权限码：</label>
    <div class="formControls col-5">
    <input type="text" class="input-text" value="${menu.permissionCode}" placeholder="" id="permissionCode" name="permissionCode" >
    </div>
    <div class="col-4"> </div>
    </div>

    <div class="row cl">
    <label class="form-label col-3">描述：</label>
    <div class="formControls col-5">
    <textarea name="descContent" cols="" rows="" class="textarea" placeholder="说点什么...100个字符以内" dragonfly="true"
    onKeyUp="textarealength(this,100)">${menu.descContent}</textarea>
    <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
    </div>
    <div class="col-4"> </div>
    </div>

    <div class="row cl">
    <label class="form-label col-3">是否发布：</label>
    <div class="formControls col-5"> <span class="select-box" style="width:150px;">
    <select class="select" name="isPublish" size="1">
    <option value="0" ${menu.isPublish==0?"selected":""}>未发布</option>
    <option value="1" ${menu.isPublish==1?"selected":""}>已发布</option>
    </select>
    </span> </div>
    </div>

    <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="js/oa_utils.js"></script>
<script type="text/javascript" src="js/getArea.js"></script>
<script type="text/javascript" src="/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    $(function () {
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-menu-update").Validform({
            tiptype: 2,
            callback: function (form) {
                submitForm(form,"menuController/updateMenu");
                return false;
            }
        });

    });
</script>
</body>
</html>