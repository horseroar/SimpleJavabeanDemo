<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入jstl标签库 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--//该页面主要对公共消息进行展示，并跳转至指定的url-->
<script>
	alert("${msg}");
	<c:if test="${url!=null}">
		window.location.href="${pageContext.request.contextPath}${url}"
	</c:if>
	<c:if test="${url==null}">
		window.history.go(-1);
	</c:if>
</script>