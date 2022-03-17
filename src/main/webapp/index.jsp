<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 메인 페이지</title>
<link rel='stylesheet' type='text/css' href='css/index.css'>
</head>
<body>
<%
/*한글깨질때 request.setCharacterEncoding("utf-8");*/

String sub="./guestbook/register.jsp";//기본페이지
if(request.getParameter("sub") != null){
		sub = request.getParameter("sub");
}
%>
<div id='index'>
	<!-- 로그인 -->
	<%@include file='login.jsp' %>
	<!-- header -->
	<%@include file='header.jsp' %>
	
	<section>
		<jsp:include page="<%=sub %>" />
	</section>
	
	<!-- footer -->
	<%@include file='footer.jsp' %>


</div>
</body>
</html>