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
		<title>编辑信息</title>
	</head>

	<script>
		function checkForm(){
			var username=document.getElementById("username").value;
			var password=document.getElementById("password").value;
			if(username.replace(/(^s*)|(s*$)/g, "")==""){
			  alert("用户名不能为空!");
			  return false;
			}
			return true;
		}
	</script>
	</script>

	<jsp:useBean id="userBean" class="cn.javabean.demo.model.User"></jsp:useBean>
	<!-- 将表单及url传输来的参数注入到javabean中 -->
	<jsp:setProperty name="userBean" property="*" />
	<%
		//如果是更新动作，对对象进行更新
		String actionStr = request.getParameter("action");
		if (actionStr == null || actionStr.trim().equals("")) {
			userBean.findUserById(); //不带参数，默认为查看
		}
		if (actionStr != null && actionStr.trim().equals("update")) {
			String result = userBean.update();//带更新参数，更新当前获取的javabean
			//显示消息内容，跳回列表页
	%>
	<script>
				alert("<%=result%>");
				window.location.href="${pageContext.request.contextPath}/list.jsp";
			</script>
	<%
		}
	%>
	<body>
		<form id="editForm" name="editForm" method="post" action="?action=update"
			onsubmit="return checkForm()">
			<!-- 存储url传来的id -->
			<input name="id" type="hidden" value="${param.id}" />

			<table width="456" border="0">
				<tr>
					<td width="121">
						用户名
					</td>
					<td width="325">
						<label for="username"></label>
						<input type="text" name="username" id="username"
							value="<%=userBean.getUsername()%>" />
					</td>
				</tr>
				<tr>
					<td>
						密码
					</td>
					<td>
						<label for="password"></label>
						<input type="text" name="password" id="password"
							value="<%=userBean.getPassword()%>" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" name="button" id="button" value="确认修改" />
						<input type="reset" name="button2" id="button2" value="重置" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>