<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>core_choose_2</title>
</head>
<body>
<!-- JSP에서 처리된 내용들을 request 영역의 속성에 저장한 후 처리 -->
<%
	int ea = 100;
	int price = 100;
	int amt = ea*price;
	
	request.setAttribute("ea", ea);
	request.setAttribute("price", price);
	request.setAttribute("amt", amt);
%>
<ul>
	<li>EA : ${ea }</li>
	<li>PRICE : ${price }</li>
	<li>AMOUNT : ${amt }</li>
	<li>사은품 : 
		<c:choose>
			<c:when test="${amt ge 10000 }">화장지</c:when>
			<c:when test="${amt ge 5000 }">자전거</c:when>
			<c:when test="${amt ge 1000 }">자동차</c:when>
		</c:choose>
	</li>	

</ul>
</body>
</html>