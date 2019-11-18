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

		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});


		//为创建按钮绑定事件，打开添加操作的模态窗口
		$("#addBtn").click(function () {

			/*

				对于模态窗口的操作：

					操作的模态窗口的jquery对象，调用modal方法，为该方法传递参数 show:开启模态窗口   hide：关闭模态窗口


			 */

			//alert(123);
			//$("#createActivityModal").modal("show");

			/*

				发出请求到后台，取得用户信息列表
				将用户信息列表铺在添加操作的模态窗口的所有者的下拉框中
				打开模态窗口

			 */

			$.ajax({

				url : "workbench/activity/getUserList.do",
				type : "get",
				dataType : "json",
				success : function (data) {

					/*

						data
							[{用户1},{用户2},{用户3}]

					 */

					var html = "<option></option>";

					//每一个n，就是每一个用户对象
					$.each(data,function (i,n) {

						html += "<option value='"+n.id+"'>"+n.name+"</option>";

					})

					$("#create-owner").html(html);


					//将当前登录的用户，设置为所有者下拉框默认的选项
					//取得当前登录的用户的id
					//js中使用el表达式取值，el表达式必须要套用在字符串引号中
					var id = "${user.id}";
					$("#create-owner").val(id);


					//下拉框处理完毕后，将添加操作的模态窗口打开
					$("#createActivityModal").modal("show");

				}

			})



		})


		//为保存按钮绑定一个事件，执行市场活动的添加操作
		$("#saveBtn").click(function () {

			$.ajax({

				url : "workbench/activity/save.do",
				data : {

					"owner" : $.trim($("#create-owner").val()),
					"name" : $.trim($("#create-name").val()),
					"startDate" : $.trim($("#create-startDate").val()),
					"endDate" : $.trim($("#create-endDate").val()),
					"cost" : $.trim($("#create-cost").val()),
					"description" : $.trim($("#create-description").val())


				},
				type : "post",
				dataType : "json",
				success : function (data) {

					/*

						data
							{"success":true/false}

					 */

					//如果添加成功
					if(data.success){

						//刷新市场活动信息列表（已操作）
						//pageList(1,2);
						//如下述代码，pageList方法中的两个参数是分页组件为我们提供的参数，我们直接拿来使用即可
						/*

							$("#activityPage").bs_pagination('getOption', 'currentPage'):维持原有的页码
							$("#activityPage").bs_pagination('getOption', 'rowsPerPage'):维持每页展现的记录数

						*/
						/*pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
								,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));*/

						pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));


						//清空添加操作的模态窗口中原有填写好的数据
						//操作方式：取得表单，清空表单
						//提交表单
						//$("#activitySaveForm").submit();

						//jquery虽然为我们提供了subimt()方法用来提交表单，但是并没有为我们提供reset()方法让我们可以重置表单
						//虽然jquery对象没有为我们提供这个方法，但是原生js的dom对象为我们提供了reset()方法
						/*

							复习：dom对象和jquery对象的互相的转换问题

							jquery对象如何转换为dom对象
								jquery对象[下标]

							dom对象如何转换为jquery对象
								$(dom对象)

						 */
						$("#activitySaveForm")[0].reset();

						//关闭添加操作的模态窗口
						$("#createActivityModal").modal("hide");

					//如果添加失败
					}else{

						alert("添加市场活动失败");

					}

				}

			})

		})

		//在页面加载完毕后，刷新市场活动信息列表
		//默认展现第一页，每页展现两条记录
		pageList(1,3);

		//为查询按钮绑定时间，执行条件查询操作
		$("#searchBtn").click(function () {

			//将搜索框中的值保存到隐藏域中
			$("#hidden-name").val($.trim($("#search-name").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-startDate").val($.trim($("#search-startDate").val()));
			$("#hidden-endDate").val($.trim($("#search-endDate").val()));

			pageList(1,2);

		})


		//为全选的复选框绑定事件，执行 全选/反选
		$("#qx").click(function () {

			//如果全选的复选框挑√了
			if($("#qx").prop("checked")){

				$("input[name=xz]").prop("checked",true);

			//如果全选的复选框将√灭掉了
			}else{

				$("input[name=xz]").prop("checked",false);

			}

		})

		//这种用法是不行的
		//因为所有name=xz的input元素，都是我们通过js字符串动态拼接出来的
		//动态拼接生成的元素，不能像之前那样，以直接触发事件的方式来为元素绑定事件
		/*$("input[name=xz]").click(function () {

			alert(123);

		})*/

		/*

			动态 生成的元素 我们需要使用到以 on的方式来进行绑定

			语法：
				$(需要绑定的元素的有效的外层元素).on(绑定事件的方式,需要绑定的元素,回调函数)

		 */

		$("#activityBody").on("click",$("input[name=xz]"),function () {

			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);

		})

		/*
		*
		* 对于删除的说明：
		*
		* 	逻辑删：假删除 为该记录更改一下它的标记位，使用的是update语句来删
		*
		*   物理删：真删除，我们今天做的删除，数据库表中就没有这些记录的存在了 使用delete语句来删
		*
		*   select * from tbl where flag='a'
		*
		*   update flag=a  b
		*
		*
		* */

		//为删除按钮绑定事件，执行市场活动的删除操作
		$("#deleteBtn").click(function () {

			var $xz = $("input[name=xz]:checked");

			if($xz.length==0){

				alert("请选择需要删除的记录");


			//肯定是挑√，有可能挑了多个√
			}else{

				if(confirm("确定删除所选记录吗？")){

					//参数：id=xxx&id=xxx&id=xxx

					var param = "";

					for(var i=0;i<$xz.length;i++){

						param += "id="+$($xz[i]).val();

						//如果不是最后一条记录
						if(i<$xz.length-1){

							param += "&";

						}

					}

					$.ajax({

						url : "workbench/activity/delete.do",
						data : param,
						type : "post",
						dataType : "json",
						success : function (data) {

							/*

                                data
                                    {"success":true/false}

                             */

							if(data.success){

								//删除成功后，需要刷新市场活动信息列表
								pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

							}else{

								alert("删除市场活动失败");

							}

						}

					})

				}




			}

		})


		//为修改按钮绑定事件，打开修改操作的模态窗口
		$("#editBtn").click(function () {

			var $xz = $("input[name=xz]:checked");

			if($xz.length==0){

				alert("请选择需要修改的记录");

			}else if($xz.length>1){

				alert("只能选择一条记录执行修改操作");

			//肯定是挑√了，而且确定只挑了一个√
			}else{

				//对于$xz，虽然是复选框的jquery对象，但是我们现在在else里面是能够确定只有一个dom元素存在的
				//所以虽然是复选框，我们仍然是可以直接通过val方法取得里面唯一的一个元素的value值
				var id = $xz.val();

				//alert("需要修改记录的id为："+id);

				//id取得后，发出ajax请求到后台，让后台为我们提供修改操作模态窗口的基础数据
				$.ajax({

					url : "workbench/activity/getUserListAndActivity.do",
					data : {

						"id" : id

					},
					type : "get",
					dataType : "json",
					success : function (data) {

						/*

							data
								{"uList":[{用户1},{2},{3}],"a":{市场活动}}

						 */

						//使用用户信息列表铺所有者下拉框
						var html = "<option></option>";

						$.each(data.uList,function (i,n) {

							html += "<option value='"+n.id+"'>"+n.name+"</option>";

						})

						$("#edit-owner").html(html);

						//为修改操作的模态窗口铺该记录的原始数据
						$("#edit-id").val(data.a.id);
						$("#edit-name").val(data.a.name);
						$("#edit-owner").val(data.a.owner);
						$("#edit-startDate").val(data.a.startDate);
						$("#edit-endDate").val(data.a.endDate);
						$("#edit-cost").val(data.a.cost);
						$("#edit-description").val(data.a.description);


						//数据处理完毕后，最后将修改操作的模态窗口打开
						$("#editActivityModal").modal("show");

					}

				})

			}

		})

		//为更新按钮绑定事件，执行修改操作
		$("#updateBtn").click(function () {

			$.ajax({

				url : "workbench/activity/update.do",
				data : {

					"id" : $.trim($("#edit-id").val()),
					"owner" : $.trim($("#edit-owner").val()),
					"name" : $.trim($("#edit-name").val()),
					"startDate" : $.trim($("#edit-startDate").val()),
					"endDate" : $.trim($("#edit-endDate").val()),
					"cost" : $.trim($("#edit-cost").val()),
					"description" : $.trim($("#edit-description").val())


				},
				type : "post",
				dataType : "json",
				success : function (data) {


					//如果修改成功
					if(data.success){

						//刷新市场活动信息列表
						pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
								,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

						//关闭添加操作的模态窗口
						$("#editActivityModal").modal("hide");

					//如果修改失败
					}else{

						alert("修改市场活动失败");

					}

				}

			})

		})

	});

	/*

		分析参数：

			与分页操作相关的参数：
			pageNo:当前页的页码（第几页）
			pageSize:每页展现多少条记录
			这两个参数是所有与分页相关操作的基本参数，通过这两个参数，能够取得或是计算出其他的分页相关的数据
			不论是任何数据库，我们在前端操作的都是这两个基本参数

			将来为后台传递的参数，除了与分页相关的两个参数pageNo和pageSize之外，还需要
			与条件查询相关的参数
			name：市场活动名称
			owner：所有者
			startDate：开始日期
			endDate：结束日期


		分析该方法的调用时机：
			都什么情况下我们需要刷新市场活动信息列表？
			（1）点击左边的菜单项"市场活动"，该页面加载完毕后，需要刷新市场活动信息列表
			（2）点击页面中的"查询"按钮，，需要刷新市场活动信息列表
			（3）在市场活动进行完添加，修改，删除操作之后，需要刷新市场活动信息列表
			（4）点击分页组件的时候，需要刷新市场活动信息列表

			以上6种情况，就相当于是刷新市场活动信息列表的6个入口，以上6种情况统一使用pageList方法来操作


		对于分页
			真分页：我们今天做的
			假分页：所有记录都查询出来，通过前端分页组件的操作，仅仅只是显示所有记录的一部分

	 */

	//刷新市场活动信息列表
	function pageList(pageNo,pageSize) {

		//将全选的√灭掉
		$("#qx").prop("checked",false);

		//将隐藏域中的值取出，重新赋予到搜索框中
		$("#search-name").val($.trim($("#hidden-name").val()));
		$("#search-owner").val($.trim($("#hidden-owner").val()));
		$("#search-startDate").val($.trim($("#hidden-startDate").val()));
		$("#search-endDate").val($.trim($("#hidden-endDate").val()));

		$.ajax({

			url : "workbench/activity/pageList.do",
			data : {

				"pageNo" : pageNo,
				"pageSize" : pageSize,
				"name" : $.trim($("#search-name").val()),
				"owner" : $.trim($("#search-owner").val()),
				"startDate" : $.trim($("#search-startDate").val()),
				"endDate" : $.trim($("#search-endDate").val())

			},
			type : "get",
			dataType : "json",
			success : function (data) {

				/*

					data

						需要市场活动信息列表的数据：
							[{市场活动1},{市场活动2},{市场活动3}...]

						需要查询记录的总条数：这个数据是我们将来要集成的分页插件需要的
							100

						综合以上分析，data应该有两组数据：市场活动信息列表+总条数

						{"total":100,"dataList":[{市场活动1},{市场活动2},{市场活动3}...]}


				 */

				//alert(data);//object Object

				var html = "";
				//每一个n就是每一条市场活动
				$.each(data.dataList,function (i,n) {

					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.do?id='+n.id+'\';">'+n.name+'</a></td>';
					html += '<td>'+n.owner+'</td>';
					html += '<td>'+n.startDate+'</td>';
					html += '<td>'+n.endDate+'</td>';
					html += '</tr>';

				})

				$("#activityBody").html(html);

				//处理总页数
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;


				//以上数据处理完毕后，处理分页相关组件
				$("#activityPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 4, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});



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

	<!--

		模态窗口（模态框）：指的是在页面中有一些隐藏的div，是以前端ui框架的支持进行一个动态的展现过程

		模态窗口的操作，友好的支持ajax

		从打开模态窗口，到提交模态窗口中的表单，都可以使用ajax来提交请求

	-->


	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" role="form">

						<input type="hidden" id="edit-id"/>

						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">



								</select>
							</div>
							<label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startDate">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endDate">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<!--

									关于textarea文本域：
									需要注意的是：
									（1）标签对之间没有空格，没有换行
									（2）与之前的input和select不一样，以前不论是操作input还是select操作的都是value值（表单元素的值）
										虽然textarea没有value属性值，虽然textarea看起来是一对标签对，
										但是textarea仍然是属于表单元素范畴，仍然是使用val()方法来操作值

								-->
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动123</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="activitySaveForm" role="form">


						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">



								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startDate">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<!--

						data-dismiss="modal"
							关闭当前模态窗口

					-->
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	

	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="search-startDate" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="search-endDate">
				    </div>
				  </div>

					<!--

						注意：！！！！！！！！！

							type="button"  ！！！！！！！！

					-->
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">

					<!--

						data-toggle="modal":
							触发该按钮，将要开启一个模态窗口

						data-target="#createActivityModal"：
							打开模态窗口的目标，是以寻找页面元素中的id的形式进行的

						如果我们现在想要在打开模态窗口之前，做些操作，例如弹出一个alert(123)，能做到吗？
						现在是做不到的
						因为我们的按钮是以固定的属性和属性值写死在按钮元素中的

						所以，页面中的元素（尤其指按钮）的行为，不应该是由固定的属性和属性值来决定的，
						我们应该为元素（按钮）起好名字，以绑定事件的形式，以js代码来控制元素（按钮）的行为

					-->
					<button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>名称123</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityBody">
						<%--<tr class="active">
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/activity/detail.jsp';">发传单</a></td>
                            <td>zhangsan</td>
							<td>2020-10-10</td>
							<td>2020-10-20</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">发传单</a></td>
                            <td>zhangsan</td>
                            <td>2020-10-10</td>
                            <td>2020-10-20</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">

				<div id="activityPage"></div>

			</div>
			
		</div>
		
	</div>
</body>
</html>