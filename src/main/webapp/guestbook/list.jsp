<%@page import="guestbook.Page"%>
<%@page import="guestbook.GuestBookDao"%>
<%@page import="guestbook.GuestBookVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
<script src='./js/guestbook.js'></script>
<link rel='stylesheet' type='text/css' href='./css/guestbook.css'>
</head>
<body>
<%
String findStr = "";
String here = "";
if(request.getParameter("findStr") != null){
	findStr = request.getParameter("findStr");
}
String nowPage = (request.getParameter("nowPage")==null) ? "1":request.getParameter("nowPage");

GuestBookDao dao = new GuestBookDao();
List<GuestBookVo> list = dao.select(findStr,nowPage);
Page p = dao.getPage();

%>

	<div id='guestbook_list'>
		<h2>방명록 조회</h2>
		<hr/>
		<form  name='frm_guestbook' method="post" action="index.jsp?sub=./guestbook/list.jsp">
			<input type='button' name='btnInsert' value='방명록 작성'/>
			<input type='search' name='findStr' value="<%=findStr%>" placeholder='검색 문구 입력'/>
			<input type='submit' value='조회'/>
			<input type='hidden' name='nowPage' value='<%=nowPage%>'/>
		</form>
		<div class='items'><!-- B 영역 -->
		<% 
			for(int i=0 ; i<list.size() ; i++){ 
				GuestBookVo v = list.get(i);
		%>
			<div class='item'>
				<output><%=v.getMid() %></output> /
				<output><%=v.getMdate() %></output><br/>
				<textarea name='doc' rows="7" cols="40"><%=v.getDoc() %></textarea><br/>
				<label>
					<input type='checkbox' name='del' value='<%=v.getNum() %>' onclick="deleteFunc(<%= v.getNum()%>)"/>삭제
				</label>
				<input type='button' value='수정' onclick="modifyFunc('<%=v.getDoc() %>',<%= v.getNum()%>)"/>			
			</div>
		<% } %>
			
		</div><!-- B영역 끝 -->
		<div class='btns'><!-- C영역 -->
		<div id='page'>
			<% if(p.getStartPage()>1){ %>
			<input type='button' value='맨첨' onclick='guestbook.page(1)'>
			<input type='button' value='이전' onclick='guestbook.page(<%=p.getStartPage()-1%>)'>
			<%} %>
			<%for(int i=p.getStartPage() ; i<=p.getEndPage() ; i++){ %>
			<input type='button' value='<%=i %>' onclick='guestbook.page(<%=i %>)'>
			<%} %>
			<%if(p.getEndPage()<p.getTotPage()){%>
			<input type='button' value='다음' onclick='guestbook.page(<%=p.getEndPage()+1%>)'>
			<input type='button' value='맨끝' onclick='guestbook.page(<%=p.getTotPage()%>)'>
			<%} %>

			
			 
		</div>
		</div>
		<div class='btnDel'>
		<input type='button' value='체크항목 삭제' onclick="delChoice()"/>
		</div>
	
	
		<!-- 수정을 위한 히든 상자 -->
		<div id='modify_box'>
			<form method="post" name='frm_modify'>
				<textarea rows="10" cols="60" name='doc'></textarea>
				<br/>
				<input type='button' value='저장' id='btnModify'/>	
				<input type='button' value='취소' id='btnModifyCancel'/>	
				<input type='hidden' name='num'/>
			</form>	
		</div>
		
		<!-- 삭제을 위한 히든 상자 -->
		<div id='delete_box'>
			<form method="post">
				<span>암호</span>
				<input type='password' name='pwd'/>
				<br/>
				<input type='button' value='삭제' id='btnDelete'/>
				<input type='button' value='취소' id='btnDeleteCancel'/>
				<input type='hidden' name='num'/>
			</form>
		</div>
	</div>
	<script>guestbook();</script>
</body>
</html>