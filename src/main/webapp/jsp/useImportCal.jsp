<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>use import cal</title>
</head>
<body>
<%
	Calendar cal = Calendar.getInstance();
	int y = cal.get(Calendar.YEAR);
	
	out.print(y+"/");
	out.print(cal.get(Calendar.MONTH)+1);
	
	out.print("<hr/>");
%>
오늘 날짜는
<%=y %>년
<%=cal.get(Calendar.MONTH)+1 %>월
<%=cal.get(Calendar.DAY_OF_MONTH) %>일
[
<%=cal.get(Calendar.HOUR) %> :
<%=cal.get(Calendar.MINUTE) %> :
<%=cal.get(Calendar.SECOND) %>
]
</body>
</html>