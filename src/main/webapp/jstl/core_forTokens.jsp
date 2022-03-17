<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>core_forTokens</title>
</head>
<body>
<h3>forTokens</h3>
<c:forTokens var="i" items="개나리,진달래-장미*해바라기,국화" delims=",-*">
	<li>${i }</li>
</c:forTokens>
</body>
</html>