<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.news.zk.ConnectNews"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	//这个是普通用户看新闻的标题作者时间用的
	//拿到数据库的内容 进行打印
	String id  = request.getParameter("id");
	Connection c = db.getConn();
	Statement st = db.getSt(c);
	ResultSet rs = st.executeQuery("select * from shownews where id = "+id);
	String s = "";
	if(rs.next()){
		s +=("<tr><td><div align=center ><font size=6>"+rs.getString("title")+
				"</div></td></tr><tr><td><div align=right ><font size=3>作者&nbsp"+
				rs.getString("author")+
				"&nbsp</div></td></tr><tr><td><div align=right ><font size=3>发布时间&nbsp"+
				rs.getDate("newstime")+"<br>"+rs.getTime("newstime")+
				"</div></td></tr><tr><td><div align=left ><font size=6>"+
			rs.getString("content")+"</td></tr>") ;
	}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="xsdt.jsp">返回</a>
<a href="mainindex.jsp">返回首页</a>
<table align=center >
	<%= s %>
</table>
</body>
</html>