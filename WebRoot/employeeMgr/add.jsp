<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.javabean.demo.model.*"%>
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
		<title>增加用户信息</title>

		<!-- 引入jquery及相关的数据验证框架 -->
		<script src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js">
		</script>
		<script src="${pageContext.request.contextPath }/js/jquery.validate.js">
		</script>
		<script
			src="${pageContext.request.contextPath }/js/jquery.validate.messages_cn.js">
		</script>
		<script type="text/javascript">
        $(function() {
            $("#addForm").validate(
              {
                  /*自定义验证规则*/
                  rules: {
                      empCode: { required: true,digits:true},
                      name: { required: true},
                      cardNo: { required: true,minlength:9,maxlength:9,digits:true}
                  },
                  /*错误提示位置*/
                  errorPlacement: function(error, element) {
                      error.appendTo(element.siblings("span"));
                  }
              }
            );
        })
    </script>
	</head>
	<body>
		<form id="addForm" name="addForm" method="post"
			action="${ pageContext.request.contextPath }/servlet/EmployeeServlet?action=insert">
			新增员工信息
			<a href="${pageContext.request.contextPath }/index.jsp">返回首页</a>
			<br>
			<br>
			<br>
			<table width="600" border="0">
				<!-- //将表单的共公部分包含进来 -->
				<%@include file="form_detail.jsp"%>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" name="button" id="button" value="新增员工" />
						<input type="reset" name="button2" id="button2" value="重置" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>