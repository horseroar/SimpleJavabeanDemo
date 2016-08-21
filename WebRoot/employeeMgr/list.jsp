<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.javabean.demo.model.*"%>
<%@ page import="cn.javabean.demo.util.JdbcUtil.PageInfo"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 包含的共页头部页面，用于作登录权限的判断 -->
<%@ include file="/common/checkLogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>列表</title>
		<!-- //引入jquery -->
		<script src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
		<!-- //页面启动时绑定全选和批量删除的事件 -->
		<script>
			$(function(){
				//绑定全选事件
				$("#checkAll").click(function(){
					//checkbox被选中后触发该事件
					var checkboxArr=$("input[name='checkEmp']");
				    //判断当前checkbox的选中状态
					    if($(this).is(':checked')){
					   		 $.each(checkboxArr,function(i,n){
								$(this).attr("checked","checked");
							});
					    }else{
					    	//取消全选
					    	$.each(checkboxArr,function(i,n){
								$(this).removeAttr("checked");
							});
					    }
				});
				//绑定批量删除,直接提交表单
				$("#batchDel").click(function(){
					if($("input:checked").size()==0){
						alert("您还没有选择任何选择，不能进行批量删除!");
						return;
					}
					$("#listForm").submit();
				});
			});
		</script>
	</head>
	<body>
		<a href="${pageContext.request.contextPath }/index.jsp">返回首页</a>
		<br>
		<br>
		<br>
		<br>
		<form id="listForm" name="listForm" method="post"
			action="${pageContext.request.contextPath }/servlet/EmployeeServlet?action=batchDel">
			<table width="100%" border="0">
				<tr>
					<td>
						<!-- //选择所有 -->
						<input type="checkbox" name="checkAll" id="checkAll" />
					</td>
					<td>
						员工姓名
					</td>
					<td>
						员工部门
					</td>
					<td>
						性别
					</td>
					<td>
						卡号
					</td>
					<td>
						操作
					</td>
				</tr>
				<!-- 使用JSTL对列表进行循环 -->
				<c:forEach var="emp" items="${empList}" varStatus="status">
					<tr>
						<td>
							<!-- 这里的checkbox需要与employee.empCode相关联,才能配合完成批量删除 -->
							<input type="checkbox" name="checkEmp" id="checkbox${status.index }"
								value="${emp.empCode }" />
						</td>
						<td>
							${emp.name }
						</td>
						<td>
							${emp.departMent }
						</td>
						<td>
							<!-- 处理性别的显示（1男 0女) -->
							<c:choose>
								<c:when test="${emp.sex==1}">男</c:when>
								<c:when test="${emp.sex==0}">女</c:when>
								<c:otherwise>人妖</c:otherwise>
							</c:choose>
						</td>
						<td>
							${emp.cardNo }
						</td>
						<td>
							<a
								href="${pageContext.request.contextPath }/servlet/EmployeeServlet?action=preEdit&empCode=${emp.empCode }">修改</a>
							<a
								href="${pageContext.request.contextPath }/servlet/EmployeeServlet?action=delete&empCode=${emp.empCode }">删除</a>
						</td>
					</tr>
				</c:forEach>
				<td colspan="5" align="left" height="100">
					<a id="batchDel" href="javascript:void(0);">批量删除</a>
				</td>
			</table>

		</form>


		<!-- 分页部分 -->
		当前第${pageInfo.currentPage }页/共${pageInfo.pageCount }页
		<!-- 第一页的处理 -->
		<c:choose>
			<c:when test="${pageInfo.currentPage!=1}">
				<a
					href="${pageContext.request.contextPath }/servlet/EmployeeServlet?action=list&page=1">第一页</a>
				<a
					href="${pageContext.request.contextPath }/servlet/EmployeeServlet?action=list&page=${pageInfo.currentPage-1 }">上一页</a>
			</c:when>
			<c:otherwise>
				第一页
				上一页
			</c:otherwise>
		</c:choose>
		<!-- //下一页、最后一页的处理 -->
		<c:choose>
			<c:when test="${pageInfo.currentPage!=pageInfo.pageCount}">
				<a
					href="${pageContext.request.contextPath }/servlet/EmployeeServlet?action=list&page=${pageInfo.currentPage+1 }">下一页</a>
				<a
					href="${pageContext.request.contextPath }/servlet/EmployeeServlet?action=list&page=${pageInfo.pageCount }">最后一页</a>
			</c:when>
			<c:otherwise>
			下一页
			最后一页
			</c:otherwise>
		</c:choose>
	</body>
</html>