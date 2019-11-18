<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";

%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript">
	$(function(){

		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});

		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});

		//为交易表单中"小放大镜"图标 绑定事件，打开搜索市场活动的模态窗口
		$("#openSearchActivityBtn").click(function () {

			$("#searchActivityModal").modal("show");

		})

		//为搜索市场活动的模态窗口中的搜索框绑定事件，目的是当敲了回车键，搜索市场活动信息列表
		$("#aname").keydown(function (event) {

			if(event.keyCode==13){

				//alert("搜索并展现市场活动信息列表");

				$.ajax({

					url : "workbench/clue/getActivityListByName.do",
					data : {

						"aname" : $.trim($("#aname").val())

					},
					type : "get",
					dataType : "json",
					success : function (data) {

						/*

							data
								[{市场活动1},{2},{3}]

						 */

						var html = "";

						$.each(data,function (i,n) {

							html += '<tr>';
							html += '<td><input type="radio" value="'+n.id+'" name="xz"/></td>';
							html += '<td id="'+n.id+'">'+n.name+'</td>';
							html += '<td>'+n.startDate+'</td>';
							html += '<td>'+n.endDate+'</td>';
							html += '<td>'+n.owner+'</td>';
							html += '</tr>';

						})

						$("#activitySearchBody").html(html);

					}

				})


				//市场活动列表展现完毕后，强制终止该方法，避免触发模态窗口回车键的默认行为
				return false;

			}

		})


		//为搜索市场活动模态窗口中的，提交按钮，绑定事件，提交市场活动信息
		$("#submitBtn").click(function () {

			//取得选中的单选框中的id值
			var $xz = $("input[name=xz]:checked");
			var id = $xz.val();

			//找到选中的td，取得td标签对中的内容,就是选中的市场活动的名称
			var name = $("#"+id).html();

			$("#activityName").val(name);
			$("#activityId").val(id);

			//清空搜索市场活动模态窗口中的信息列表
			$("#activitySearchBody").empty();

			//关闭模态窗口
			$("#searchActivityModal").modal("hide");

		})

		//为转换按钮绑定事件，执行线索的转换操作
		/*

			分析：

				请求方式问题：
				我们发请求到后台，执行线索的转换操作
				使用传统请求，还是ajax请求呢？
				使用传统请求
				请求路径：workbench/clue/convert.do


				请求参数问题：
				应该为后台执行线索转换操作，提供哪些参数呢？
				必须参数：clueId
				非必须参数：交易表单所需参数，当需要创建交易时，这些参数需要传递到后台
							name,money,expectedDate,stage,activityId

				如何传递参数：
					如果不需要创建交易：
						workbench/clue/convert.do?clueId=xxx
					如果需要创建交易：
						workbench/clue/convert.do?clueId=xxx&name=xxx&money=xxx&............
						我们可以以提交表单的方式来发出传统请求，以提交表单参数的形式来为后台提供参数


				前端操作如何判断是否需要创建交易？
					根据"为客户创建交易"的复选框有没有挑√来判断
					如果没有挑√，说明不需要创建交易，仅仅只是执行线索的转换就可以了
					如果挑√了，说明需要创建交易，处理执行线索的转换外，还需要创建一笔交易

		 */
		$("#convertBtn").click(function () {

			if($("#isCreateTransaction").prop("checked")){

				//需要创建交易
				//这样传递参数麻烦
				//window.location.href = "workbench/clue/convert.do?clueId=${param.id}&name=xxx&money=xxx";
				//以提交表单的方式来发送请求，传递参数
				$("#tranForm").submit();

			}else{

				//不需要创建交易
				window.location.href = "workbench/clue/convert.do?clueId=${param.id}";

			}


		})

	});
</script>

</head>
<body>
	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" id="aname" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="activitySearchBody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>
							<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>--%>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
				</div>
			</div>
		</div>
	</div>

	<div id="title" class="page-header" style="position: relative; left: 20px;">

		<!--

			el表达式，除了xxxScope系列的隐含对象，其他所有的隐含对象一律不能省略掉
												一旦省略掉，默认就是从域对象中取值

		-->

		<h4>转换线索 <small>${param.fullname}${param.appellation}-${param.company}</small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		新建客户：${param.company}
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		新建联系人：${param.fullname}${param.appellation}
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >

		<%--


			提交表单：
				路径和参数的效果：
				workbench/clue/convert.do?money=xxx&name=xxx&expectedDate=xxx&stage=xxx&activityId=xxx&clueId=xxx

		--%>

		<form action="workbench/clue/convert.do" method="post" id="tranForm">

			<input type="hidden" name="flag" value="a"/>

			<input type="hidden" name="clueId" value="${param.id}"/>

			<div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input type="text" class="form-control" id="amountOfMoney" name="money">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称</label>
		    <input type="text" class="form-control" id="tradeName" name="name">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedClosingDate">预计成交日期</label>
		    <input type="text" class="form-control time" id="expectedClosingDate" name="expectedDate">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段</label>
		    <select id="stage"  class="form-control" name="stage">
		    	<option></option>
		    	<c:forEach items="${stageList}" var="s">
					<option value="${s.value}">${s.text}</option>
				</c:forEach>
		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="openSearchActivityBtn" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
		    <input type="text" class="form-control" id="activityName" placeholder="点击上面搜索" readonly>
			<input type="hidden" id="activityId" name="activityId"/>
		  </div>
		</form>
		
	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b>${param.owner}</b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input class="btn btn-primary" type="button" value="转换" id="convertBtn">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-default" type="button" value="取消">
	</div>
</body>
</html>