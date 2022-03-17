<%@page import="java.text.DecimalFormat"%>
<%@page import="productMybatis.Page"%>
<%@page import="productMybatis.ProductVo"%>
<%@page import="java.util.List"%>
<%@page import="productMybatis.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list(생산 목록 조회)</title>
<link rel='stylesheet' type='text/css' href='./css/product.css'>
<script src='./js/productMybatis.js'></script>
</head>
<body>
<%
String findStr = (request.getParameter("findStr")==null) ? "":request.getParameter("findStr");
String nowPage = (request.getParameter("nowPage")==null) ? "1":request.getParameter("nowPage");

ProductDao dao = new ProductDao();
List<ProductVo> list = dao.select(findStr, nowPage);
Page p = dao.getPage();

String here="";
%>
<div id='product_list'>
	<h2>생산 목록 조회</h2>
	<div id='findZone'>
		<form name='frm_product' method='post'>
			<input type='button' name='btnInsert' value='생산입력'/>
			<input type='search' name='findStr' size='25' value='<%=findStr%>'/>
			<input type='button' name='btnSearch' value='검색'/>
			<input type='hidden' name='nowPage' value='<%=nowPage%>'/>
			<input type='hidden' name='serial'/>
		</form>
	</div>
	<div id='items'>
		<div id='title'>
				<span class='serial'>serial</span>
				<span class='mdate'>생산일자</span>
				<span class='code'>제품코드</span>
				<span class='codeName'>제품명</span>
				<span class='price'>단가</span>
				<span class='ea'>수량</span>
				<span class='amt'>금액</span>
		</div>
		
		<div id='rows'>
			<% 
			DecimalFormat df = new DecimalFormat("#,###,###.#");
			for(ProductVo v : list){
			%>
				<div id='item' onclick="Product.view(<%=v.getSerial()%>)">
					<span class='serial'><%=v.getSerial() %></span>
					<span class='mdate'><%=v.getMdate() %></span>
					<span class='code'><%=v.getCode() %></span>
					<span class='codeName'><%=v.getCodeName() %></span>
					<span class='price'><%=df.format(v.getPrice()) %></span>
					<span class='ea'><%=df.format(v.getEa()) %></span>
					<span class='amt'><%=df.format(v.getAmt()) %></span>
				</div>
			<% } %>
		</div>
			
		<div id='page'>
			<% if(p.getStartPage()>1){ %>
				<input type='button' value='맨첨' id='btnFirst' onclick='Product.page(1)'>
				<input type='button' value='이전' id='btnPrev' onclick='Product.page(<%=p.getStartPage()-1%>)'>
			<%} %>
			
			<%for(int i=p.getStartPage() ; i<=p.getEndPage() ;i++){ 
				if(nowPage.equals(i+"")){
					here="here";
				}else{
					here="";
				}
			
			%>
				<input type='button' class='<%=here %>' value='<%=i %>' onclick='Product.page(<%=i %>)'>
			<%} %>
			
			<%if(p.getEndPage()<p.getTotPage()){%>
				<input type='button' value='다음' id='btnNext' onclick='Product.page(<%=p.getEndPage()+1%>)'>
				<input type='button' value='맨끝' id='btnLast' onclick='Product.page(<%=p.getTotPage()%>)'>
			<%} %>
		</div>
	</div>
</div>
<script>Product();</script>
</body>
</html>