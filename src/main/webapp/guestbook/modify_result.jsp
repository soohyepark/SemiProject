<%@page import="guestbook.GuestBookDao"%>
<%@page import="guestbook.GuestBookVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String doc = request.getParameter("doc");
int num = Integer.parseInt(request.getParameter("num"));
GuestBookVo vo = new GuestBookVo();
vo.setDoc(doc);
vo.setNum(num);
GuestBookDao dao = new GuestBookDao();
boolean b = dao.update(vo);

if(b){
	out.print("방명록이 수정되었습니다.");
}else{
	out.print("수정중 오류 발생");
}

%>
</body>
</html>