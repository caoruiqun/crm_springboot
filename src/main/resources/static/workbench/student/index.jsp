<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
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

	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>


	<script type="text/javascript">

	$(function(){

		pageList(1,2);

		$("#searchBtn").click(function () {

			$("#hidden-name").val($.trim($("#search-name").val()));
			$("#hidden-address").val($.trim($("#search-address").val()));
			$("#hidden-phone").val($.trim($("#search-phone").val()));
			$("#hidden-birthday").val($.trim($("#search-birthday").val()));

			pageList(1,2);

		})




	});

	function pageList(pageNo,pageSize) {


		$("#search-name").val($.trim($("#hidden-name").val()));
		$("#search-address").val($.trim($("#hidden-address").val()));
		$("#search-phone").val($.trim($("#hidden-phone").val()));
		$("#search-birthday").val($.trim($("#hidden-birthday").val()));

		$.ajax({

			url : "workbench/activity/pageList.do",
			data : {

				"pageNo" : pageNo,
				"pageSize" : pageSize,
				"name" : $.trim($("#search-name").val()),
				"address" : $.trim($("#search-owner").val()),
				"phone" : $.trim($("#search-startDate").val()),
				"birthday" : $.trim($("#search-endDate").val())

			},
			type : "get",
			dataType : "json",
			success : function (data) {

				//var html = "";
				//每一个n就是每一条学生对象
				/*$.each(data.dataList,function (i,n) {

					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" >'+n.name+'</a></td>';
					html += '<td>'+n.address+'</td>';
					html += '<td>'+n.phone+'</td>';
					html += '<td>'+n.birthday+'</td>';
					html += '</tr>';

				})

				$("#studentBody").html(html);*/

				//处理总页数
				//var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;


				//以上数据处理完毕后，处理分页相关组件
				/*$("#studentPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});*/



			}

		})

	}
	
</script>
</head>
<body>

	<input type="hidden" id="hidden-name">
	<input type="hidden" id="hidden-owner">
	<input type="hidden" id="hidden-startDate">
	<input type="hidden" id="hidden-endDate">


	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>学生信息列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">学生姓名</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">地址</div>
				      <input class="form-control" type="text" id="search-address">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">电话</div>
					  <input class="form-control" type="text" id="search-phone" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">生日</div>
					  <input class="form-control" type="text" id="search-birthday">
				    </div>
				  </div>

					<!--

						注意：！！！！！！！！！

							type="button"  ！！！！！！！！

					-->
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>

			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>学生姓名</td>
                            <td>地址</td>
							<td>电话</td>
							<td>生日</td>
						</tr>
					</thead>
					<tbody id="studentBody">
						<tr class="active">
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;">张三</a></td>
                            <td>大族企业湾</td>
							<td>1333123123</td>
							<td>1996-10-20</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;">李四</a></td>
                            <td>马驹桥</td>
                            <td>136123121312</td>
                            <td>1999-11-20</td>
                        </tr>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">

				<div id="studentPage"></div>

			</div>
			
		</div>
		
	</div>
</body>
</html>