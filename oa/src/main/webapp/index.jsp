
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="/favicon.ico" >
    <LINK rel="Shortcut Icon" href="/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="lib/html5.js"></script>
    <script type="text/javascript" src="lib/respond.min.js"></script>
    <script type="text/javascript" src="lib/PIE_IE678.js"></script>
    <![endif]-->
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="skin/default/skin.css" rel="stylesheet" type="text/css" id="skin" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>H-ui.admin v2.3</title>
    <meta name="keywords" content="H-ui.admin v2.3,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="H-ui.admin v2.3，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<header class="Hui-header cl"> <a class="Hui-logo l" title="H-ui.admin v2.3" href="/">H-ui.admin</a> <a class="Hui-logo-m l" href="/" title="H-ui.admin">H-ui</a> <span class="Hui-subtitle l">V2.3</span>
    <nav class="mainnav cl" id="Hui-nav">
        <ul>
            <li class="dropDown dropDown_click"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 新增 <i class="Hui-iconfont">&#xe6d5;</i></a>
                <ul class="dropDown-menu radius box-shadow">
                    <li><a href="javascript:;" onclick="article_add('添加资讯','article-add.html')"><i class="Hui-iconfont">&#xe616;</i> 资讯</a></li>
                    <li><a href="javascript:;" onclick="picture_add('添加资讯','picture-add.html')"><i class="Hui-iconfont">&#xe613;</i> 图片</a></li>
                    <li><a href="javascript:;" onclick="product_add('添加资讯','product-add.html')"><i class="Hui-iconfont">&#xe620;</i> 产品</a></li>
                    <li><a href="javascript:;" onclick="member_add('添加用户','member-add.html','','510')"><i class="Hui-iconfont">&#xe60d;</i> 用户</a></li>
                </ul>
            </li>
        </ul>
    </nav>
    <ul class="Hui-userbar">
        <li>超级管理员</li>
        <li class="dropDown dropDown_hover"><a href="#" class="dropDown_A"><shiro:principal property="userName"/> <i class="Hui-iconfont">&#xe6d5;</i></a>
            <ul class="dropDown-menu radius box-shadow">
                <li><a href="#">个人信息</a></li>
                <li><a href="#">切换账户</a></li>
                <li><a href="/logout">退出</a></li>
            </ul>
        </li>
        <li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li>
        <li id="Hui-skin" class="dropDown right dropDown_hover"><a href="javascript:;" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
            <ul class="dropDown-menu radius box-shadow">
                <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                <li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
            </ul>
        </li>
    </ul>
    <a aria-hidden="false" class="Hui-nav-toggle" href="#"></a> </header>
<aside class="Hui-aside">
    <input runat="server" id="divScrollValue" type="hidden" value="" />
    <div class="menu_dropdown bk_2">
       <%-- <dl id="menu-article">
            <dt><i class="Hui-iconfont">&#xe616;</i> 数据管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a _href="orgController/getOrgPage" href="javascript:void(0)">组织管理</a></li>
                    <li><a _href="userController/getUserPage" href="javascript:void(0)">用户管理</a></li>

                </ul>
            </dd>
        </dl>
        <dl>
            <dt><i class="Hui-iconfont">&#xe616;</i> 权限管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a _href="roleController/getRolePage" href="javascript:void(0)">角色管理</a></li>
                    <li><a _href="menuController/getMenuPage" href="javascript:void(0)">菜单管理</a></li>
                    <li><a _href="authorization/toAuthorizationPage" href="javascript:void(0)">授权管理</a></li>
                </ul>
            </dd>
        </dl>
        <dl>
            <dt><i class="Hui-iconfont">&#xe616;</i> 流程管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a _href="leave/getLeavePage" href="javascript:void(0)">请假管理</a></li>
                    <li><a _href="workFlow/toDeploymentAndProcessDefPage" href="javascript:void(0)">部署管理</a></li>
                    <li><a _href="workFlow/toTaskPage" href="javascript:void(0)">任务管理</a></li>

                </ul>
            </dd>
        </dl>--%>
           <c:forEach items="${menus}" var="menu">
               <dl id="menu-article">
                   <c:if test="${menu.menuType eq 1}">
                       <dt><i class="Hui-iconfont">&#xe616;</i> ${menu.menuName}<i
                               class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
                       </dt>
                   </c:if>
                   <dd>
                       <ul>
                           <c:forEach var="subMenu" items="${menus}">
                               <c:if test="${subMenu.menuParentId eq menu.menuId}">
                                   <li><a _href="${subMenu.menuPath}" href="javascript:void(0)">${subMenu.menuName}</a></li>
                               </c:if>
                           </c:forEach>
                       </ul>
                   </dd>
               </dl>
           </c:forEach>
    </div>
</aside>
<div class="dislpayArrow"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active"><span title="我的桌面" data-href="welcome.html">我的桌面</span><em></em></li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="welcome.html"></iframe>
        </div>
    </div>
</section>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript">
    /*资讯-添加*/
    function article_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*图片-添加*/
    function picture_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*产品-添加*/
    function product_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*用户-添加*/
    function member_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
</script>
<script type="text/javascript">
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?080836300300be57b7f34f4b3e97d911";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s)})();
    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F080836300300be57b7f34f4b3e97d911' type='text/javascript'%3E%3C/script%3E"));
</script>
</body>
</html>