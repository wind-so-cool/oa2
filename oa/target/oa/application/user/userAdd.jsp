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
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <!-- 引入树插件的样式文件 -->
    <link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">

    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>添加用户</title>
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-user-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>用户名：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="userName" name="userName"
                       datatype="*2-16" nullmsg="用户名不能为空">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>密码：</label>
            <div class="formControls col-5">
                <input type="password" placeholder="密码" autocomplete="off" value="" name="userPassword"
                       id="userPassword" class="input-text" datatype="*6-20" nullmsg="密码不能为空">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>确认密码：</label>
            <div class="formControls col-5">
                <input type="password" placeholder="确认密码" autocomplete="off" value="" class="input-text"
                       recheck="userPassword" datatype="*6-20" errormsg="您两次输入的账号密码不一致！" nullmsg="确认密码不能为空">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>组织：</label>
            <div class="formControls col-5">
                <input type="text" placeholder="组织" autocomplete="off" value="" id="orgParentName" name="orgName"
                       datatype="*" readonly class="input-text" nullmsg="组织不能为空">
                <input type="hidden" class="input-text" value="" placeholder="" id="orgParentId" name="orgId">
                <button id="btn-star" type="button" class="btn btn-default"
                        onclick="getParentOrg('orgController/getOrgList')">选择组织
                </button>
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>生日：</label>
            <div class="formControls col-5">
                <input type="text" readonly datatype="*" name="userBirthday" placeholder="生日" nullmsg="生日不能为空"
                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'userBirthday\')||\'%y-%M-%d\'}'})"
                       id="userBirthday" class="input-text Wdate">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>性别：</label>
            <div class="formControls col-5 skin-minimal">
                <div class="radio-box">
                    <input type="radio" id="sex-1" value="1" name="userSex" datatype="*" nullmsg="请选择性别！">
                    <label for="sex-1">男</label>
                </div>
                <div class="radio-box">
                    <input type="radio" id="sex-2" value="0" name="userSex" datatype="*" nullmsg="请选择性别！">
                    <label for="sex-2">女</label>
                </div>
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>手机：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="mobilePhone" name="mobilePhone"
                       datatype="m" nullmsg="手机不能为空">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>邮箱：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" placeholder="@" name="email" id="email" datatype="e"
                       nullmsg="请输入邮箱！">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">区域：</label>
            <div class="formControls">
                <span class="select-box" style="width:130px;">
                    <input type="hidden" id="provinceName" name="provinceName">
                    <select class="select" name="provinceId" id="provinceId" size="1">

                    </select>
				</span>
                <span class="select-box" style="width:130px;">
                     <input type="hidden" id="cityName" name="cityName">
                    <select class="select" name="cityId" id="cityId" size="1">

                    </select>
				</span>
                <span class="select-box" style="width:130px;">
                     <input type="hidden" id="contryName" name="contryName">
                    <select class="select" name="countryId" id="countryId" size="1">

                    </select>
				</span>
            </div>
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

        $("#form-user-add").Validform({
            tiptype: 2,
            callback: function (form) {
                submitForm(form,"userController/addUser");
                return false;
            }
        });
        CascadeArea("","","","provinceId","cityId","countryId")
    });
</script>
</body>
</html>