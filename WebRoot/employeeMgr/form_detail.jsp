<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<tr>
	<td width="121">
		员工编号
	</td>
	<td width="325">
		<input type="text" name="empCode" id=" empCode" value="${employee.empCode }" />
		<span></span>
	</td>
</tr>
<tr>
	<td>
		员工姓名
	</td>
	<td>
		<label for="name"></label>
		<input type="text" name="name" id="name" value="${employee.name }" />
		<span></span>
	</td>
</tr>
<tr>
	<td>
		部门:
	</td>
	<td>
		<label for="departMent"></label>
		<select name="departMent" id="departMent">
			<!-- 使用jstl遍历出部分列表，并选中第一个 -->
			<c:forEach items="${departList}" var="dpt" varStatus="status">
				<c:choose>
					<c:when test="${dpt eq employee.departMent}">
						<option value="${dpt}" selected="selected">
							${dpt}
						</option>
					</c:when>
					<c:otherwise>
						<option value="${dpt}">
							${dpt}
						</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
	</td>
</tr>
<tr>
	<td width="121">
		性别
	</td>
	<td width="325">
		<c:if test="${employee.sex==1 }">
			<input name="sex" type="radio" id="radio" value="1" checked="checked" />男
					  	<input name="sex" type="radio" id="radio2" value="0" />女
					  </c:if>
		<c:if test="${employee.sex==0 }">
			<input name="sex" type="radio" id="radio" value="1" />男
					  	<input name="sex" type="radio" id="radio2" value="0" checked="checked" />女
					  </c:if>
		<c:if test="${empty employee}">
			<input name="sex" type="radio" id="radio" value="1" checked="checked" />男
					  	<input name="sex" type="radio" id="radio2" value="0" />女
					  </c:if>
	</td>
</tr>
<tr>
	<td width="121">
		员工卡号
	</td>
	<td width="325">
		<input type="text" name="cardNo" id="cardNo" value="${employee.cardNo }" />
		<span></span>
	</td>
</tr>
