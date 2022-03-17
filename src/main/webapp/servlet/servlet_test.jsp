<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>servlet_test</title>
</head>
<body>
	<form method='post' action='my.gugudan'>
		<label>단</label>
		<input type='text' name='dan' value='9'/>
		<input type='submit'/>
		<br/>
		<output>${msg }</output>
	</form>

</body>
</html>