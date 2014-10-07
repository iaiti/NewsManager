<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="java.sql.*"%>
<%!int id = 0;%>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	request.setCharacterEncoding("utf-8");
%>
<!-- button.js是单击添加附件时会有新的input 也能删除 这个请教了畅哥
	return返回true时会submit提交 false将停留本页面
 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>delete</title>
</head>
<body>
	<script language='javascript' src="button.js"></script>
	<form action="pupfile.jsp?id=<%= id %>" method="post" name="form1"
		onSubmit="return check_file()" enctype="multipart/form-data"><input
		type="button" value="点击添加附件" onclick="addFile('dvTitles','file')">
		<input type="submit" name="Submit" value="上传下面附件">
		<p>
		<div id="dvTitles"></div>
	</form>
</body>
</html>
