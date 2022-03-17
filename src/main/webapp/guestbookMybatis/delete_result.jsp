<%@page import="guestbookMybatis.GuestBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String delValue = request.getParameter("delValue");
GuestBookDao dao = new GuestBookDao();
boolean b = dao.delete(delValue);

if(b){
	out.print("정상적으로 삭제됨");
	out.print("<script>");
	out.print(" location.href='index.jsp?sub=./guestbookMybatis/list.jsp'");
	out.print("</script>");
	
}else{
	out.print("삭제중 오류발생");
}

%>
</body>
</html>