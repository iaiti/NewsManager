<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.news.zk.ConnectNews"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<%!	
	String s = "";
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	boolean land=false;
	int rand = 0;
	int rid = 0;
	String usertype = "";
	//表示声明，相当于全局变量，不能跨客户端
%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	//本项目的主页 显示大体的框架
	String whetherland = (String)session.getAttribute("userland");
	String what = (String)session.getAttribute("usertype");
	if(whetherland!=null&&whetherland.equals("true")){
		land=true;
	}
	if(what==null||what.equals("")){
		usertype = "";
	}else{
		usertype = what;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>

<div align="right">
<%
	if(usertype.equals("admin")){
%>
	<a href="manageuser.jsp">用户管理</a>
	<a href="createuser.jsp">创建用户</a>
	<a href="editpw.jsp">修改管理员名字和密码</a>
<% 
	}
%>
</div>
<div align="left">
<%
	if(usertype.equals("admin")){
%>
		您好，后台管理员！
<% 
	}if(usertype!=""&&usertype!="admin"){
%>
		您好，<%= usertype %>人员！
<% 		
	}
%>
</div>
<div align="right">
<%
	if(land==true){
%>
		<a href="exit.jsp"> 退出</a>
<% 
	}else {
%>
		<a href="userland.jsp"> 登录</a>
<% 
	}
%>
</div>

<h1 align="center">学校新闻</h1>
<div align="center" ><font size="5">
	<table width="700" >
		<tr>
			<td><a href="xyxw.jsp">学院新闻</a></td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td><a href="xytz.jsp">学院通知</a></td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td><a href="xsdt.jsp">学生动态</a></td>
		</tr>
		<tr>
		</tr>
	</table>
</div>
</body>
</html>
<% 
// 防止刷新的时候s再叠加一次
	s = ""; 
	land = false;
%>

