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
	if( form1!=""&&form1 != null && form1.equals("true")) {
		Random r = new Random();
		for(int i = 0;i<10;i++){
			rid =rid+ r.nextInt(5000);
		}
		//发表时用随机数生成的一个 id 往里面插入空数据先 目的就是为了产生一条新纪录 供新闻发表用 前辈学来的
		st.executeUpdate("insert into shownews values ("+rid+",null,null,now(),null,null,null,null)");
		response.sendRedirect("ueditor/publish.jsp?id="+rid);
	}
	rs = st.executeQuery("select * from shownews order by newstime desc ");
	while(rs.next()){
		//判断后台管理员是否登录 将全部数据累加  最后在首页显示内容
		if(land){
			s +=("<tr><td>"+"<a href='newscontent.jsp?id="+rs.getInt("id")+
					"'>"+rs.getString("title")+"</td><td>"+"<a href='delete.jsp?id="+
					rs.getInt("id")+"'>&nbsp删除&nbsp&nbsp</td><td>"+"<a href='ueditor/index.jsp?id="+
					rs.getInt("id")+"'>编辑&nbsp&nbsp</td></tr>");
			
		} else {
			s +=("<tr><td>"+"<a href='newscontent.jsp?id="+rs.getInt("id")+
					"'>"+rs.getString("title")+"</td></tr>");
		}
	}
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
<div align="right">
<a href="userland.jsp">  登录</a></div>
<h1 align="center">新闻栏目</h1>

<%
	if(land){
%>
	<form name="form1" method="post" action="newsindex.jsp" 
  >
   <input type="hidden" name="action"  value = "true"> 
   <input name="submit" type="submit"  value="&nbsp发表新闻" >
   </form>
<% 
	}
%>
<table border=1r>
	<%= s %>
</table>

</body>
</html>
<% 
// 防止刷新的时候s再叠加一次
	s = ""; 
%>
