<%@page import="java.io.File"%>
<%@page import="member.Page"%>
<%@page import="member.MemberVo"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<link rel='stylesheet' type='text/css' href='./css/member.css'>
<script src='./js/member.js'></script>
</head>
<body>
<%
String findStr = "";
String nowPage = "1";

if(request.getParameter("findStr")!=null){
	findStr = request.getParameter("findStr");
}
if(request.getParameter("nowPage")!=null){
	nowPage = request.getParameter("nowPage");
}

MemberDao dao = new MemberDao();
List<MemberVo> list = dao.select(nowPage,findStr);
Page p = dao.getPage();

request.setAttribute("nowPage", nowPage);
request.setAttribute("findStr", findStr);
request.setAttribute("list", list);
request.setAttribute("p", p);

%>
<div id="member">
	<h2>회원관리</h2>
	<hr/>
	<form name="frm_member" method="post">
		<div class='findZone'>
			<input type='button' value='입력' name='btnInsert'/>
			<input type='text' size='30' name='findStr' value='${param.findStr }'/>
			<input type='button' value='검색' name='btnFind'/>
			<input type='text' name='nowPage' value='${nowPage }'/>
			<input type='text' name='mid'/>
		</div>
	</form>
	<div id='rows'>
		
		<c:forEach var="v" items="${list }">	
			<div class='item' onclick="member.view('${v.mid}')">
			<%
				MemberVo vo = (MemberVo)pageContext.getAttribute("v");
				File file = new File(MemberDao.uploadPath + vo.getPhoto());
				if(!file.exists() || file.isDirectory()){
					file=null;
				}
				request.setAttribute("file", file);
			%>
			<c:choose>
				<c:when test="${empty file }">
					<img src="http://placehold.it/100x125" />			
				</c:when>
				<c:otherwise>
					<img src='./upload/${v.photo }' width='100' height='125'/>	
				</c:otherwise>
			</c:choose>
			
				<div>
				<span class='item_title'>아이디</span>
				<span class='item_value'>${v.mid }</span>
				<br/>
				<span class='item_title'>성명</span>
				<span class='item_value'>${v.irum }</span>
				<br/>
				<span class='item_title'>연락처</span>
				<span class='item_value'>${v.phone }</span>
				<br/>
				<span class='item_title'>주소</span>
				<span class='item_address item_value'>${v.address } ${v.address2 }</span>
				<br/>
				</div>
			</div>
		</c:forEach>
	</div>
	<div class='btnZone'>
		
		<c:if test="${p.nowPage>1 }">
			<input type='button' value='  &lt  ' onclick="member.move(${p.nowPage-1})"/>
		</c:if>
		
		<c:if test="${p.totPage>p.nowPage }">
			<input type='button' value='  &gt  ' onclick="member.move(${p.nowPage+1})"/>
		</c:if>	
	</div>

</div>
<script>member()</script>
</body>
</html>