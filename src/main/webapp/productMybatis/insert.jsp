<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert(생산입력)</title>
<link rel='stylesheet' type='text/css' href='./css/product.css'>
<script src='./js/productMybatis.js'></script>
</head>
<body>
<%
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");
%>
<div id='product'>
	<h2>제품 생산 입력</h2>
	<form name='frm_product' method='post'>
		<label>제품코드</label>
		<input type='text' name='code' size='12'/>
		<input type='button' value='검색' name='btnFind'/>
		<br/>
		<label>제품명</label>
		<input type='text' name='codeName' size='30' readOnly/>
		<br/>
		<label>단가</label>
		<input type='text' name='price' readOnly/>
		<hr/>
		<label>생산일자</label>
		<input type='date' name='mdate'/>
		<br/>
		<label>수량</label>
		<input type='text' name='ea' size='5'/>
		<hr/>
		<div id='btnZone'>
			<input type='button' value='저장' name='btnSave'/>
			<input type='button' value='목록' name='btnList'/>
			<input type='hidden' name='findStr' value='<%=findStr%>'/>
			<input type='hidden' name='nowPage' value='<%=nowPage%>'/>		
		</div>
	</form>
</div>
<script>Product();</script>
</body>
</html>