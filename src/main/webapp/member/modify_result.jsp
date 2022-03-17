<%@page import="member.MemberDao"%>
<%@page import="member.MemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/member.css'>
<script src='./js/member.js'></script>
</head>
<body>
<%
MemberVo vo = (MemberVo)request.getAttribute("vo");
MemberDao dao = new MemberDao();
String msg = dao.update(vo);
request.setAttribute("msg", msg);
%>

<div id="member">
	<form name="frm_member" method="post">
		<output>${msg }</output>
	
		<div class='btnZone'>
			<input type='button' value='목록' name='btnList'/>	
			<input type='hidden' name='nowPage' value='${nowPage }'/>
			<input type='hidden' name='findStr' value='${findStr }'/>
		</div>
	</form>
</div>
<script>member()</script>
</body>
</html>