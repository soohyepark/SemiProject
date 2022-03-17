<%@page import="product.PartsVo"%>
<%@page import="java.util.List"%>
<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품코드 조회</title>
<link rel='stylesheet' type='text/css' href='../css/product.css'>
<script src='../js/product.js'></script>
</head>
<body>
<%
ProductDao dao = new ProductDao();
String code = request.getParameter("code");
List<PartsVo> partsList = dao.selectParts(code);

%>
<div id='parts'>
	<h2>제품검색</h2>
	<form name='frm_parts' method='post'>
		<input type='search' placeholder='제품코드나 제품명을 입력하세요.' name='code' value='<%=code%>'>
		<input type='button' value='검색' name='btnFindParts'>
		<br/>
		<select name='parts' size='10'>
			<%for(PartsVo pVo : partsList){ 
				String s = String.format("%s[ %s ] %s", pVo.getCode(), pVo.getCodeName(), pVo.getPrice());
			%>
				<option><%=s%></option>
			<%} %>
		</select>
	</form>
</div>
<script>Parts()</script>
</body>
</html>