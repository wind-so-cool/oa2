<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<base href="<%=request.getContextPath() + "/"%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
	<link rel="stylesheet" href="/lib/layer/ui/css/layui.css" media="all">
	<script src="/lib/layer/ui/layui.js"></script>
	<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script>
<body>

	<!-- 这个div用来展示分页导航条 -->
	<div id="test1"></div>


	<script>
	
	//通过标签获取到body和表单的dom对象，再获取到id属性，传入函数的参数当中
/*	var bodyId = $("body").attr("id")
	var formId = $("form").attr("id")
	var tableId = $("table").attr("id")*/

		// 初始化分页导航条
		layui.use('laypage', function() {
			var laypage = layui.laypage;

			//执行一个laypage实例
			laypage.render({
				elem : 'test1', //注意，这里的 test1 是 ID，不用加 # 号
				count : "${page.total}", // 总条数
				limit:"${page.pageSize}", // 每页显示的条数
				curr:"${page.pageNum}", // 当前页
				layout: ['prev', 'page', 'next', 'limit','count'],
				jump: function(obj, first){
				    // console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
				    // console.log(obj.limit); //得到每页显示的条数

				    //首次不执行
				    if(!first){
				    	// 查询下一页的数据
				    	//location.href="${url}currentPage="+obj.curr;
						if($(".refreshEle").length>0){
							$(".refreshEle:last").load("${url}currentPage="+obj.curr,getQueryParams());
						}else{
							$("body").load("${url}currentPage="+obj.curr,getQueryParams());
						}

						/*
						if($(".dataTable")){

							$(".dataTable:last").load("${url}currentPage="+obj.curr,getQueryParams());
						}else{
							$("body").load("${url}currentPage="+obj.curr,getQueryParams());
						}*/
						/*if(bodyId == null||bodyId == ''){
							bodyId = tableId
						}
						$("#"+bodyId).load("${url}currentPage="+obj.curr,getQueryParam(formId))*/
				    }
				  }
			});
		});
	
	
	// 获取模块的查询参数
	/*function getQueryParam(formId){
		var param = formSerialize(formId);
	 	return param
	}
	function formSerialize(formId){
		return $("#"+formId).serialize();
	}*/


	function getQueryParams(){

	}
	</script>
</body>
</html>