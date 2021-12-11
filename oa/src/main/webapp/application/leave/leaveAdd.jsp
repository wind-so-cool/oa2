<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=request.getContextPath() %>/">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />

<!-- 引入树插件的样式文件 -->
<link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">

<title>添加请假申请</title>
</head>
<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-leave-add">
		<div class="row cl">
			<label class="form-label col-3"><span class="c-red">*</span>请假天数：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" value="" placeholder="" id="days" name="days" datatype="*" nullmsg="天数不能为空">
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-3">请假理由：</label>
			<div class="formControls col-5">
				<textarea name="reason" cols="" rows="" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)"></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-3">请假备注：</label>
			<div class="formControls col-5">
				<textarea name="ps" cols="" rows="" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)"></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
			</div>
			<div class="col-4"> </div>
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
<script type="text/javascript" src="js/getArea.js"></script> 
<script type="text/javascript" src="js/oa_utils.js"></script> 
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/1807_OA/lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	
	$("#form-leave-add").Validform({
		tiptype:2,
		callback:function(form){ // 表单全部验证成功后才会进入回调函数
			submitForm(form,"leave/addLeave");
			return false;
		}
	});
	
});
</script>
</body>
</html>