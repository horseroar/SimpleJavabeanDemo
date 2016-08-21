<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.javabean.demo.model.*"%>
<%@ page import="cn.javabean.demo.util.JdbcUtil.PageInfo"%>
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
		<title>列表</title>
	</head>
	<body>
		<a href="${pageContext.request.contextPath }/index.jsp">返回首页</a>
		<br>
		<br>
		<br>
		<table width="100%" border="0">
			<tr>
				<td width="30%">
					用户名
				</td>
				<td width="30%">
					密码
				</td>
				<td width="30%">
					操作
				</td>
			</tr>
			<!-- 循环提取显示用户数据 -->
			<jsp:useBean id="userBean" class="cn.javabean.demo.model.User"></jsp:useBean>
			<%
				String pageStr=request.getParameter("page");
			    int currentPage=1;
				if(pageStr!=null&&pageStr.matches("^\\d+$")){
					currentPage=Integer.valueOf(pageStr);
				}
				Map resultMap= userBean.findAll(currentPage);
				PageInfo pageInfo=(PageInfo)resultMap.get("pageInfo");
				List<User> userList=(List<User>)resultMap.get("userList");
				for (User user : userList) {
			%>
			<tr>
				<td>
					<%=user.getUsername()%>
				</td>
				<td>
					<%=user.getPassword()%>
				</td>
				<td>
					<a href="${pageContext.request.contextPath }/edit.jsp?id=<%=user.getId()%>">修改</a>
					<a href="${pageContext.request.contextPath }/del.jsp?id=<%=user.getId()%>">删除</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<br>
		<br>
		<br>
			<!-- 分页部分 -->
			当前第<%=pageInfo.getCurrentPage() %>页/共<%=pageInfo.getPageCount() %>页
		<a href="${pageContext.request.contextPath }/list.jsp?page=1">第一页</a>
		<!-- 上一页 -->
		<%
				if(currentPage!=1){
			%>
		<a
			href="${pageContext.request.contextPath }/list.jsp?page=<%=currentPage-1 %>">上一页</a>
		<%
				}else{
			%>
		上一页
		<%} %>
		<!-- 下一页 -->
		<%
				if(currentPage!=pageInfo.getPageCount()){
			%>
		<a
			href="${pageContext.request.contextPath }/list.jsp?page=<%=currentPage+1 %>">下一页</a>
		<%
				}else{
			%>
		下一页
		<%} %>
		<a
			href="${pageContext.request.contextPath }/list.jsp?page=<%=pageInfo.getPageCount() %>">最后一页</a>
	</body>
</html>