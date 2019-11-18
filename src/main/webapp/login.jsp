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
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script>

	$(function () {

		//如果顶层窗口不是当前窗口，则将顶层窗口设置为当前窗口
		if(window.top!=window){
			window.top.location=window.location;
		}


		/*

			需求：
				点击"登录"按钮能够执行验证登录操作
				在页面上敲回车也能够执行验证登录操作

		 */

		//页面加载完毕后，清空账号文本框
		$("#loginAct").val("");

		//页面加载完毕后，焦点设置在账号文本框上
		$("#loginAct").focus();

		//为登录按钮绑定事件，执行登录操作
		$("#submitBtn").click(function () {

			//执行登录操作
			login();

		})

		//为当前登录页窗口绑定事件，绑定敲键盘事件
		/*

			event参数:可以通过该参数来取得触发的键盘的码值

		 */
		$(window).keydown(function (event) {

			//如果敲的键盘的码值为13，说明是回车键
			if(event.keyCode==13){

				login();

			}

		})

	})

	/*
		自定义的function方法，一定要写在$(function{})的外面

	 */
	function login() {

		//取得文本框中填写的账号密码
		//去掉左右空格$.trim(内容)
		var loginAct = $.trim($("#loginAct").val());
		var loginPwd = $.trim($("#loginPwd").val());

		//验证账号密码是否都填写了
		if(loginAct=="" || loginPwd==""){

			$("#msg").html("账号密码不能为空");

			/*

				如果账号密码为空，就没有必要继续向下执行账号密码的验证了
				需要强制终止该方法

			 */
			return false;

		}

		//验证账号密码是否正确
		//ajax
		$.ajax({

			url : "settings/user/login.do",
			data : {

				"loginAct" : loginAct,
				"loginPwd" : loginPwd

			},
			type : "post",
			dataType : "json",
			success : function (data) {

				/*

					data
						{"success":true/false,"msg":?}

				 */

				if(data.success){

					//登录成功，跳转到工作台的欢迎页
					window.location.href = "workbench/index.jsp";

				}else{

					//登录失败
					//为用户提示失败信息
					$("#msg").html(data.msg);

				}

			}

		})


	}

</script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2016&nbsp;恩诺国际</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.jsp" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="用户名" id="loginAct">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" placeholder="密码" id="loginPwd">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						
							<span id="msg" style="color: #FF0000"></span>
						
					</div>
					<!--

						button按钮如果出现在了form表单当中，一定要加上type="button"
							否则按钮默认的行为就是提交form表单

					-->
					<button id="submitBtn" type="button" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录123</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>