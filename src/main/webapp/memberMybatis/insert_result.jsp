<%@page import="memberMybatis.MemberVo"%>
<%@page import="memberMybatis.MemberDao"%>
<%@page import="memberMybatis.FileUpload"%>
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
//FileUpload 서블릿에서 처리된 결과가 attribute에 담겨 전달됨.
String findStr = (String)request.getAttribute("findStr");
String nowPage = (String)request.getAttribute("nowPage");
MemberDao dao = new MemberDao();
String msg = dao.insert((MemberVo)request.getAttribute("vo"));

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