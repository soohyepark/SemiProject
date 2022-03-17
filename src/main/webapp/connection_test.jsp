<%@page import="java.sql.Connection"%>
<%@page import="bean.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>connection_test</title>
</head>
<body>
<%
DBConn db = new DBConn();
Connection conn = db.getConn();
if(conn != null){
	out.print("connection....good");
}else{
	out.print("connection....fail");
}


%>
</body>
</html>