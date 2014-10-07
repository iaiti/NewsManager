<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.news.zk.ConnectNews"%>
<%@ page import="java.sql.*"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews" />
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8"); 
%>
<%!
	String s = "";
	String r = "";
	int id = 0;
	String attachment = "";
	String a = "";
	String at = "";
	String saveFile = "";
	String fileName = "";
	String t = "";%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script  type="text/javascript" charset="utf-8" src="js/checkpw.js"></script>
	<form action="admincreated.jsp" name="form" method="post" onsubmit="return password()">
		<input type="hidden" name="action" value="post" > </input>
		<table width="750" align="center" border="2">
			<tr>
				<td>新用户名</td>
				<td><input type="text" size="30" id="user" name="user" /></td>
			</tr>
			<tr>
				<td>新密码</td>
				<td><input type="password" size="30" id="pwd" name="pwd" /></td>
			</tr>
			<tr>
				<td>新密码确认</td>
				<td><input type=password name="pwd2" id="pwd2" size="30" >
				</td>
			</tr>
		
			<tr>
				<td></td>
				<td><input type="submit" value="提交"> 
				<input type="reset" value="重置"> </td>
			</tr>
		</table>
	</form>
	<a href="mainindex.jsp">返回</a>
</body>
</html>