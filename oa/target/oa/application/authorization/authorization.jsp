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
    <link rel="stylesheet" href="/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">

    <!--[if IE 6]>
    <script type="text/javascript" src="/lib/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>授权管理</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 权限管理 <span class="c-gray en">&gt;</span> 授权管理 <span
        class="c-gray en">&gt;</span> 授权管理 <a class="btn btn-success radius r mr-20"
                                              style="line-height:1.6em;margin-top:3px"
                                              href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
        <div class="text-c">
            <div class="row cl ">
                <div class="formControls col-3">
                    角色: <span class="select-box" style="width:150px;">
                    <select class="select" id="query_role_id" size="1">
                        <option value="">请选择</option>
                        <c:forEach var="role" items="${roleList}">
                            <option value="${role.roleId}">${role.roleName}</option>

                        </c:forEach>
                    </select>
                    </span>
                </div>
                <div class="formControls col-3">
                    类型： <span class="select-box" style="width:150px;">
                            <select class="select"  id="query_type" size="1">
                                <option value="">请选择</option>
                                <option value="1">人员</option>
                                <option value="0">菜单</option>
                            </select>
                            </span>
                </div>

            </div>
            <div class="row cl">
                <div class="cl pd-5">
                    <button type="button" onclick="queryAuthorization()"
                            class="btn btn-success radius" id="search" name="">
                        <i class="Hui-iconfont">&#xe665;</i> 搜索
                    </button>
                    <button type="button"
                            class="btn btn-success radius" id="reset" name=""
                            onclick="javascript:$('input').val('');$('form').submit()">
                        <i class="Hui-iconfont">&#xe66b;</i>重置
                    </button>
                </div>
            </div>
        </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l">
        <a href="javascript:;" onclick="toAuthorizeUser('授权人员','authorization/getToBeAuthorizedUserPage?roleId='+$('#query_role_id').val()+'&queryType='+$('#query_type').val(),'1000','650')"
           class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 授权人员 </a>
    <a href="javascript:;" onclick="toAuthorizeMenu()"
       class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 授权菜单 </a>
    </span>
    </div>
    <table class="table table-border table-bordered table-bg refreshEle">

    </table>

</div>
<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script>

<script type="text/javascript" src="/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/H-ui.js"></script>
<script type="text/javascript" src="/js/H-ui.admin.js"></script>
<%--<script type="text/javascript" src="/lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/lib/zTree/v3/js/jquery.ztree.excheck-3.5.js"></script>--%>
<script type="text/javascript" src="/js/oa_utils.js"></script>
<script type="text/javascript">
    function toAuthorizeUser(title, url, w, h) {
        let roleId=$("#query_role_id").val();
        if(!roleId){
            alert("请选择角色");
            return;
        }
        $("#query_type").val("1");
        queryAuthorization();
        layer_show(title, url, w, h);
    }
    function toAuthorizeMenu() {
        let roleId=$("#query_role_id").val();
        if(!roleId){
            alert("请选择角色");
            return;
        }
        $("#query_type").val("0");
        queryAuthorization();
        getParent2('authorization/getMenuList?roleId='+$("#query_role_id").val(),'授权菜单',$('#query_role_id').val())
    }

  function queryAuthorization(){
      let roleId=$("#query_role_id").val();
      if(!roleId){
          alert("请选择角色");
          return;
      }
      let queryType=$("#query_type").val();
      if(!queryType){
          alert("请选择类型");
          return;
      }
      if(queryType=="1"){//人员
          $(".refreshEle:first").load("authorization/getAuthorizedUserListByRoleId/"+roleId+"?queryType="+queryType);
      }else if(queryType=="0"){//菜单
          $(".refreshEle:first").load("authorization/getAuthorizedMenuListByRoleId/"+roleId+"?queryType="+queryType);
      }
  }
</script>
</body>
</html>