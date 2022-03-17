<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	<h1>Web Project</h1>
	<nav>
		<a href='index.jsp'>HOME</a>
		<a href='index.jsp?sub=guestbook/list.jsp'>방명록</a>
		<%-- <a href='index.jsp?sub=guestbookMybatis/list.jsp'>방명록II</a>
		<a href='index.jsp?sub=product/list.jsp'>생산관리</a>
		--%>
		<a href='index.jsp?sub=productMybatis/list.jsp'>생산관리</a>
		<%--
		<a href='index.jsp?sub=member/list.jsp'>회원관리</a>
		 --%>
		<a href='index.jsp?sub=memberMybatis/list.jsp'>회원관리</a>
		
		<a href='board.brd'>게시판</a>
	</nav>
</header>