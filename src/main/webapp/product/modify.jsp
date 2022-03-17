<%@page import="product.ProductVo"%>
<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify(생산 정보 수정)</title>
<link rel='stylesheet' type='text/css' href='./css/product.css'>
<script src='./js/product.js'></script>
</head>
<body>
<%
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");
String serial = request.getParameter("serial");

ProductDao dao = new ProductDao();
ProductVo vo = dao.view(serial);
%>
<div id='product'>
	<h2>제품 생산 정보 수정</h2>
	<form name='frm_product' method='post'>
		<label>제품코드</label>
		<input type='text' name='code' size='12' value='<%=vo.getCode()%>'/>
		<input type='button' value='검색' name='btnFind'/>
		<br/>
		<label>제품명</label>
		<input type='text' name='codeName' size='30' readOnly value='<%=vo.getCodeName()%>'/>
		<br/>
		<label>단가</label>
		<input type='text' name='price' readOnly value='<%=vo.getPrice()%>'/>
		<hr/>
		<label>생산일자</label>
		<input type='date' name='mdate' value='<%=vo.getMdate()%>'/>
		<br/>
		<label>수량</label>
		<input type='text' name='ea' size='5' value='<%=vo.getEa()%>'/>
		<hr/>
		<div id='btnZone'>
		<input type='button' value='수정' name='btnUpdate'/>
		<input type='button' value='목록' name='btnList'/>	
		</div>
		<input type='hidden' name='findStr' value='<%=findStr%>'/>
		<input type='hidden' name='nowPage' value='<%=nowPage%>'/>
		<input type='hidden' name='serial' value='<%=serial%>'/>
		
	</form>
</div>
<script>Product();</script>
</body>
</html>