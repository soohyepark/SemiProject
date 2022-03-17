<%@page import="product.ProductVo"%>
<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산정보 입력 결과 화면</title>
<link rel='stylesheet' type='text/css' href='./css/product.css'>
<script src='./js/product.js'></script>
</head>
<body>
<%
String msg = "데이터가 저장됨.";
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");

ProductDao dao = new ProductDao();
ProductVo vo = new ProductVo();
vo.setCode(request.getParameter("code"));
vo.setMdate(request.getParameter("mdate"));
vo.setEa(Integer.parseInt(request.getParameter("ea")));

boolean b = dao.insert(vo);
if(b){
	msg = "데이터가 저장됨.";
}else{
	msg = "저장중 오류 발생.";
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