<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>登录页面</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>

	<script>
		function checkForm(){
			var username=document.getElementById("username").value;
			var password=document.getElementById("password").value;
			if(username.replace(/(^s*)|(s*$)/g, "")==""){
			  alert("用户名不能为空!");
			  return false;
			}
			if(password==""){
				alert("密码不能为空!");
				return false;
			}
			return true;
		}
	</script>

	<!-- //本页的判断登录代码 -->
	<jsp:useBean id="userLoginCheck" class="cn.javabean.demo.model.User"></jsp:useBean>
	<!-- 将request域中与User同名的属性设置进User对象中 -->
	<jsp:setProperty name="userLoginCheck" property="*" />
	<%
		String actionStr = request.getParameter("action");
		if (actionStr != null && actionStr.equals("login")) {
			//参数属性设置(可在setProperty中设置)
			//userLoginCheck.setUsername(request.getParameter("username"));
			//userLoginCheck.setPassword(request.getParameter("password"));
			//校验登录
			if (userLoginCheck.login()) {
				session.setAttribute("user", userLoginCheck);
				response.sendRedirect(basePath + "index.jsp");
			} else {
				response.sendRedirect(basePath + "login.jsp");
			}
		} else if (actionStr != null && actionStr.equals("logout")) {
			//退出登录
			session.removeAttribute("user");
			response.sendRedirect(basePath + "login.jsp");
		}
	%>

	<body>
	用户登录<br><br><br>
		<form id="loginForm" name="loginForm" method="post" action="?action=login"
			onsubmit="return checkForm()">
			<table width="456" border="0">
				<tr>
					<td width="121">
						用户名
					</td>
					<td width="325">
						<label for="username"></label>
						<input type="text" name="username" id="username" />
					</td>
				</tr>
				<tr>
					<td>
						密码
					</td>
					<td>
						<label for="password"></label>
						<input type="password" name="password" id="password" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" name="button" id="button" value="提交" />
						<input type="reset" name="button2" id="button2" value="重置" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
