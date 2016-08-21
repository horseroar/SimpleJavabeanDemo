<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.javabean.demo.model.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 包含的共页头部页面，用于作登录权限的判断 -->
<%@ include file="common/checkLogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>增加用户信息</title>
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

	<jsp:useBean id="userBean" class="cn.javabean.demo.model.User"></jsp:useBean>
	<jsp:setProperty name="userBean" property="*" />
	<%
		String actionStr = request.getParameter("action");
		if (actionStr != null && actionStr.equals("insert")) {
			String result = userBean.insert();
			if (!result.equals("添加用户成功!")) {
	%>
	<script>
				alert("<%=result%>");
				window.history.go(-1);
			</script>
	<%
		} else {
	%>
	<script>
				alert("<%=result%>");
				window.location.href="${pageContext.request.contextPath}/index.jsp";
			</script>
	<%
		}
		}
	%>

	<body>
		<form id="loginForm" name="loginForm" method="post" action="?action=insert"
			onsubmit="return checkForm()">
			新增用户信息  <a href="${pageContext.request.contextPath }/index.jsp">返回首页</a><br><br><br>
			<table width="456" border="0">
				<tr>
					<td width="121">
						用户名
					</td>
					<td width="325">
						<input type="text" name="username" id="username" />
					</td>
				</tr>
				<tr>
					<td>
						密码
					</td>
					<td>
						<label for="password"></label>
						<input type="text" name="password" id="password" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" name="button" id="button" value="添加用户" />
						<input type="reset" name="button2" id="button2" value="重置" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>