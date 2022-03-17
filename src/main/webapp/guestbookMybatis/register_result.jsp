<%@page import="guestbookMybatis.GuestBookVo"%>
<%@page import="guestbookMybatis.GuestBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register_result.jsp</title>
<script src='./js/guestbookMybatis.js'></script>
</head>
<body>
<h1>방명록 저장 결과</h1>
<%
GuestBookDao dao = new GuestBookDao();
GuestBookVo vo = new GuestBookVo();

String mid = request.getParameter("mid");
String mdate = request.getParameter("mdate");
String doc = request.getParameter("doc");
String pwd = request.getParameter("pwd");

vo.setMid(mid);
vo.setMdate(mdate);
vo.setDoc(doc);
vo.setPwd(pwd);

boolean b = dao.insert(vo);
if(b){
	out.print("정상입력");
	out.print("<script>");
	out.print(" location.href='index.jsp?sub=./guestbookMybatis/list.jsp'");
	out.print("</script>");
}else{
	out.print("입력중 오류 발생");
}
%>

<ul>
	<li>아이디 : <%=mid %></li>
	<li>작성일 : <%=mdate %></li>
	<li>내용 : <%=doc %></li>
	<li>암호 : <%=pwd %></li>
</ul>
<input type='button' id='btnlist' value='목록'>

<script>
	guestbook();
</script>
</body>
</html>