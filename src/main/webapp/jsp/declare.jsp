<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP의 선언문</title>
</head>
<body>
<h3>선언문</h3>
<%!
	int s = 0;
	public void sum(int x, int y){
		int s = x+y;
		this.s = s;
	}
%> 
</body>
</html>