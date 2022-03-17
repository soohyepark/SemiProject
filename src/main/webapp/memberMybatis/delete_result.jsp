<%@page import="memberMybatis.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/member.css'>
<script src='./js/memberMybatis.js'></script>
</head>
<body>
<%
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");
String mid = request.getParameter("mid");
String pwd = request.getParameter("pwd");
String delFile = request.getParameter("delFile");

MemberDao dao = new MemberDao();
String msg = dao.delete(mid, pwd, delFile);

request.setAttribute("nowPage", nowPage);
request.setAttribute("findStr", findStr);
request.setAttribute("msg", msg);

%>
<div id="member">
	<form name="frm_member" method="post">
		<output>${msg }</output>
	
		<div class='btnZone'>
			<input type='button' value='목록' name='btnList'/>	
		</div>
		<input type='hidden' name='nowPage' value='${nowPage }'/>
		<input type='hidden' name='findStr' value='${findStr }'/>	
	</form>
</div>
<script>member()</script>
</body>
</html>