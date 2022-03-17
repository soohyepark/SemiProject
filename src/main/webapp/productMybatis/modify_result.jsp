<%@page import="productMybatis.ProductVo"%>
<%@page import="productMybatis.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산정보 수정 결과 화면</title>
<link rel='stylesheet' type='text/css' href='./css/product.css'>
<script src='./js/productMybatis.js'></script>
</head>
<body>
<jsp:useBean id="vo" class="productMybatis.ProductVo"/>
<jsp:setProperty property="*" name="vo"/>
<%
String msg = "";
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");

ProductDao dao = new ProductDao();
boolean b = dao.update(vo);
if(b){
	msg="데이터가 정상적으로 수정됨.";
}else{
	msg="자료 수정중 오류 발생.";
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