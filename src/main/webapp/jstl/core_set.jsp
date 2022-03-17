<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>core_set</title>
</head>
<body>
<c:set var="mid">hong</c:set>
<c:set var="irum" value="홍길동"/>

<ul>
	<li>MID : ${mid }</li>
	<li>IRUM : ${irum }</li>
</ul>
<c:remove var="irum"/>
<ul>
	<li>MID : ${mid }</li>
	<li>IRUM : ${irum }</li>
</ul>
<%
String phone="010-1111-1111";
request.setAttribute("phone", phone);

%>
<li>phone : ${requestScope.phone }</li>
<li>phone : ${phone }</li>
</body>
</html>