<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>core_param</title>
</head>
<body>
<h2>core param</h2>
<form name='frm' method='post'>
	<label>ID</label>
	<input type='text' name='mid' value='${param.mid }'/>
	<input type='submit'/>	
</form>
<ul>
	<li>MID : ${param.mid }</li>
</ul>

</body>
</html>