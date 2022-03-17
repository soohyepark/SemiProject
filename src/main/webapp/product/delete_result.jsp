<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산정보 삭제 결과 화면</title>
<link rel='stylesheet' type='text/css' href='./css/product.css'>
<script src='./js/product.js'></script>
</head>
<body>
<%
String msg = "";
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");
String serial = request.getParameter("serial");

ProductDao dao = new ProductDao();
boolean b = dao.delete(serial);
if(b){
	msg = "데이터가 삭제됨.";
}else{
	msg = "삭제중 오류 발생.";
}

%>
<div id='product'>
	<div id='result_msg'>
		<%=msg %>
	</div>
	<div id='btnZone'>
		<form name='frm_product' method='post'>
			<input type='hidden' name='findStr' value='<%=findStr%>'/>
			<input type='hidden' name='nowPage' value='<%=nowPage%>'/>
			<input type='button' value='목록' name='btnList'/>
		</form>
	</div>
</div>
<script>Product();</script>
</body>
</html>