<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
<div id='login'>
	<form name='frm_login' method='post' action="my.login">
		<c:choose>
			<c:when test="${empty sessionScope.vo.mid }">
				<label>아이디</label><input type='text' name='loginMid'/>
				<label>암호</label><input type='password' name='loginPwd'/>	
				<input type='submit' value='로그인'/>		
			</c:when>
			
			<c:otherwise>
				<output>${sessionScope.vo.irum }님 반갑습니다.</output>
				<input type='submit' value='로그아웃' id='btnLogout'/>
			</c:otherwise>
		</c:choose>
	</form>
</div>
</body>
</html>