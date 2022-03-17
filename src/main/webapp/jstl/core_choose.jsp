<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>core_choose</title>
</head>
<body>
<%
String age = request.getParameter("age");
%>
<form name='frm' method='post'>
	<label>이름</label>
	<input type='text' name='irum' value='${param.irum }'/>
	<br/>
	<label>나이</label>
	<input type='text' name='age' value='<%=age%>'/>
	<br/>
	<input type='submit'/>
</form>
<%
	if(request.getMethod().equals("GET")) return;
%>
<c:choose>
	<c:when test="${param.irum eq 'park' }">
		<li>당신의 이름은 ${param.irum }입니다.</li>
	</c:when>
	<c:when test="${param.age ge 20 }">
		<li>당신의 나이는 20세 이상입니다.</li>
	</c:when>
	<c:otherwise>
		<li>당신은 park도 아니고 20세 이상도 아닙니다.</li>
	</c:otherwise>
</c:choose>


</body>
</html>