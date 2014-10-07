<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="com.news.zk.ConnectNews"%>
<%@ page import="java.security.*"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<jsp:useBean scope="page" id="md" class="com.news.zk.MD"/>
<%! 
	String name = "";
	String pwd = "";
	String usertype ="";
	String rs = "";
%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8"); 
%>

<%
	 name = request.getParameter("user");
	 pwd = md.toMd5(request.getParameter("pwd"));
	 usertype = request.getParameter("usertype");
	 Connection c = db.getConn();
	 Statement st = db.getSt(c);
	 st.executeUpdate("delete from users where usertype = 'administrator' ");
	 st.executeUpdate("insert into users values(null,'"+name+"','"+pwd+"','administrator')");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	用户名:<%= name %><br>
	密码自己记住！<br>
	管理员已创建<br>
	<%= rs %>
	<a href="mainindex.jsp">返回主页</a>
</body>
</html>