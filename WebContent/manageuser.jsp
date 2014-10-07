<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.news.zk.*"%>
<%@ page import="java.sql.*"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<%!	
	String s = "";
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	boolean land=false;
	//表示声明，相当于全局变量，不能跨客户端
%>
<%
	//本项目的主页 显示大体的框架
	//拿到数据库的连接 执行语句  这里也可用javabean直接写个封装类 出了点错 时间要紧 所以先略过
	String form1 = request.getParameter("action");
	String whetherland = (String)session.getAttribute("userland");
	if(whetherland!=null&&whetherland.equals("true")){
		land=true;
	}
	con = db.getConn();
	st = db.getSt(con);
	
	rs = st.executeQuery("select * from users where usertype != 'administrator' ");
	while(rs.next()){
		if(land){
			s +=("<tr><td>"+"<a>用户名:&nbsp"+rs.getString("name")+"</td><td>"+"<a >所属部门:&nbsp"+rs.getString("usertype")+
					"</td><td>"+"<a href='deleteuser.jsp?id="+
					rs.getInt("id")+"'>&nbsp删除&nbsp&nbsp</td></tr>");
		}

	}
		//判断后台管理员是否登录 将全部数据累加  最后在首页显示内容
	rs.close();
	st.close();
	con.close();
	//关闭连接防止异常
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border=1r>
	<%= s %>
</table>
<a href="mainindex.jsp">返回</a>
</body>
</html>
<% s="";%>