<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";

//	Map<String,String> pMap = (Map<String, String>) application.getAttribute("pMap");
//
//	Set<String> set = pMap.keySet();

%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<script src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>

	<script>

		//页面加载完毕后，将pMap转换为json

		<%--var json = {--%>

		<%--	<%--%>

		<%--		for(String key:set){--%>

		<%--			String value = pMap.get(key);--%>

		<%--	%>--%>

		<%--			"<%=key%>" : <%=value%>,--%>

		<%--	<%--%>

		<%--		}--%>


		<%--	%>--%>

		<%--};--%>


		$(function () {

			$("#create-customerName").typeahead({
				source: function (query, process) {
					$.get(
							"workbench/transaction/getCustomerName.do",
							{ "name" : query },
							function (data) {
								//alert(data);
								//我们提供好了data（客户名称列表之后），执行process方法将数据描绘为显示的列表

								/*

									data
										[{客户名称1},{2},{3}]

								 */

								process(data);
							},
							"json"
					);
				},
				delay: 1000
			});


			$(".time1").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});

			$(".time2").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "top-left"
			});

			//为阶段下拉框绑定选中事件，通过选中的阶段，动态的填写可能性
			$("#create-stage").change(function () {

				//取得阶段
				var stage = $("#create-stage").val();

				$.ajax({

					url : "workbench/transaction/ss.do",
					data : {

						// "stage" : stage

					},
					type : "get",
					dataType : "json",
					success : function (data) {
						var possibility = data[stage];
						// $("#create-possibility").val(data);
						$("#create-possibility").val(possibility);

					}

				})




				/*

					以上我们有了阶段key
					我们还需要阶段和可能性之间的对应关系，我们也有pMap
					对应关系我们虽然有，但是是java中的对应关系Map pMap
					在js中pMap用不了
					所以我们需要将java中的pMap转换为js中的键值对关系json
					pMap------->{"01资质审查":"10","02需求分析":"25"......}

					最后我们通过阶段以及对应关系取得可能性

				 */

				/*

					我们之前一直在使用json.key的形式来取得value值
					但是今天取不到，因为stage是我们通过下拉框选择的一个可变的变量
					如果是这样的选中方式，我们就不能以json.key的形式来取得value值
					我们要以另一种json[key]的形式来取得value值

				 */
				/*var possibility = json[stage]
				//alert("可能性："+possibility);
				$("#create-possibility").val(possibility);*/

			})




//为交易表单中"小放大镜"图标 绑定事件，打开搜索市场活动的模态窗口
			$("#openSearchActivityBtn").click(function () {

				$("#searchActivityModal").modal("show");

			})



			//为搜索市场活动的模态窗口中的搜索框绑定事件，目的是当敲了回车键，搜索市场活动信息列表
			$("#aname").keydown(function (event) {

				if(event.keyCode==13){

					//alert("搜索并展现市场活动信息列表");

					$.ajax({

						url : "workbench/transaction/getActivityListByName.do",
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








			//为交易表单中"小放大镜"图标 绑定事件，打开搜索市场活动的模态窗口
			$("#openSearchContactsBtn").click(function () {

				$("#searchContactsModal").modal("show");

			})


			//为搜索联系人的模态窗口中的搜索框绑定事件，目的是当敲了回车键，搜索市场活动信息列表
			$("#cname").keydown(function (event) {

				if(event.keyCode==13){

					//alert("搜索并展现联系人信息列表");

					$.ajax({

						url : "workbench/transaction/getContactsListByName.do",
						data : {

							"cname" : $.trim($("#cname").val())

						},
						type : "get",
						dataType : "json",
						success : function (data) {

							/*

                                data
                                    [{联系人1},{2},{3}]

                             */

							var html = "";

							$.each(data,function (i,n) {

								html += '<tr>';
								html += '<td><input type="radio" value="'+n.id+'" name="xzb"/></td>';
								html += '<td id="'+n.id+'">'+n.fullname+'</td>';
								html += '<td>'+n.email+'</td>';
								html += '<td>'+n.mphone+'</td>';
								html += '</tr>';

							})

							$("#contactsSearchBody").html(html);

						}

					})


					//联系人列表展现完毕后，强制终止该方法，避免触发模态窗口回车键的默认行为
					return false;

				}

			})


			//为搜索联系人模态窗口中的，提交按钮，绑定事件，提交联系人信息
			$("#submitBtn2").click(function () {

				//取得选中的单选框中的id值
				var $xzb = $("input[name=xzb]:checked");
				var id = $xzb.val();

				//找到选中的td，取得td标签对中的内容,就是选中的联系人的名称
				var fullName = $("#"+id).html();

				$("#contactsName").val(fullName);
				$("#contactsId").val(id);

				//清空搜索联系人模态窗口中的信息列表
				$("#contactsSearchBody").empty();

				//关闭模态窗口
				$("#searchContactsModal").modal("hide");

			})




			//为保存按钮绑定事件，执行添加交易的操作
			$("#saveBtn").click(function () {

				$("#tranForm").submit();

			})



		})

	</script>

</head>
<body>

	<!-- 查找市场活动 -->	
	<div class="modal fade" id="searchActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找市场活动</h4>
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
					<table id="activityTable3" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
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

	<!-- 查找联系人 -->	
	<div class="modal fade" id="searchContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找联系人</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" id="cname" style="width: 300px;" placeholder="请输入联系人名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>邮箱</td>
								<td>手机</td>
							</tr>
						</thead>
						<tbody id="contactsSearchBody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>李四</td>
								<td>lisi@enroll.com</td>
								<td>12345678901</td>
							</tr>
							<tr>
								<td><input type="radio" name="activity"/></td>
								<td>李四</td>
								<td>lisi@enroll.com</td>
								<td>12345678901</td>
							</tr>--%>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="submitBtn2">提交</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div style="position:  relative; left: 30px;">
		<h3>创建交易</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
			<button type="button" class="btn btn-default">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form action="workbench/transaction/save.do" method="post" id="tranForm" class="form-horizontal" role="form" style="position: relative; top: -30px;">
		<div class="form-group">
			<label for="create-transactionOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-transactionOwner" name="owner">
				  <option></option>
					<c:forEach items="${uList}" var="u">
						<option value="${u.id}" ${u.id eq user.id ? "selected" : ""}>${u.name}</option>
					</c:forEach>
				</select>
			</div>
			<label for="create-amountOfMoney" class="col-sm-2 control-label">金额</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-amountOfMoney" name="money">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-transactionName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-transactionName" name="name">
			</div>
			<label for="create-expectedClosingDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control time1" id="create-expectedClosingDate" name="expectedDate">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-accountName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-customerName" name="customerId" autocomplete="off" placeholder="支持自动补全，输入客户不存在则新建">
			</div>
			<label for="create-transactionStage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
			  <select class="form-control" id="create-stage" name="stage">
			  	<option></option>
			  	<c:forEach items="${stageList}" var="s">
					<option value="${s.value}">${s.text}</option>
				</c:forEach>
			  </select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-transactionType" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-transactionType" name="type">
				  <option></option>
					<c:forEach items="${transactionTypeList}" var="t">
						<option value="${t.value}">${t.text}</option>
					</c:forEach>
				</select>
			</div>
			<label for="create-possibility" class="col-sm-2 control-label">可能性</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-possibility">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-clueSource" name="source">
				  <option></option>
					<c:forEach items="${sourceList}" var="s">
						<option value="${s.value}">${s.text}</option>
					</c:forEach>
				</select>
			</div>
<%--			<label for="create-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findMarketActivity"><span class="glyphicon glyphicon-search"></span></a></label>--%>
			<label for="create-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="openSearchActivityBtn" ><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="activityName" placeholder="点击曹锐群搜索" readonly>
				<input type="hidden" id="activityId" name="activityId" />
			</div>
		</div>
		
		<div class="form-group">
<%--			<label for="create-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findContacts"><span class="glyphicon glyphicon-search"></span></a></label>--%>
			<label for="create-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" id="openSearchContactsBtn" ><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="contactsName" placeholder="点击小美人搜索" readonly>
				<input type="hidden" id="contactsId" name="contactsId"/>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-describe" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-contactSummary" name="contactSummary"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control time2" id="create-nextContactTime" name="nextContactTime">
			</div>
		</div>
		
	</form>
</body>
</html>