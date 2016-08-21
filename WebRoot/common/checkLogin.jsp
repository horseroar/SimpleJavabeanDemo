<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!--//进行权限的检查校验-->
<%
	if(session.getAttribute("user")==null){
		request.getRequestDispatcher("/login.jsp").forward(request,response);
	}
%>