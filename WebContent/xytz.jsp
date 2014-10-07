<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.news.zk.ConnectNews"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<%
request.setCharacterEncoding("utf-8");
request.setAttribute("newstype","xstz");
%>
<%!	
	String s = "";
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	boolean land=false;
	int rand = 0;
	String rid ="";
	String usertype = "";
	String message = "";
	//表示声明，相当于全局变量，不能跨客户端
%>
<%
	String form1 = request.getParameter("action");
	String dle = request.getParameter("dle");
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

	con = db.getConn();
	st = db.getSt(con);
	if(dle!=""||dle!=null){
		st.executeUpdate("delete from shownews where id="+dle);
	}
	if( form1!=""&&form1 != null && form1.equals("true")) {
		 Calendar rightNow = Calendar.getInstance();
	        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmss");
	        //Random r = new Random();
	       // for(int i = 0;i<4;i++){
			//	rid =rid+ r.nextInt(50);
			//}
	        String sysDatetime = fmt.format(rightNow.getTime()); 
			rid = sysDatetime;
		
		//发表时用随机数生成的一个 id 往里面插入空数据先 目的就是为了产生一条新纪录 供新闻发表用 前辈学来的
		
		st.executeUpdate("insert into shownews values("+rid+",'','',now(),'',null,'学院通知','"+usertype+"')");
		response.sendRedirect("ueditor/publish.jsp?id="+rid+"&newstype=xytz");
	}
	if(usertype.equals("admin")||usertype==""){
		rs = st.executeQuery("select * from shownews where newtype ='学院通知' order  by newstime desc");
	}else{
		rs = st.executeQuery("select * from shownews  where publishertype='"+usertype+"' and  newtype ='学院通知' ");
	}


	 rs.last();        //指针移到最后一行 
	 if(rs.getRow()== 0){
		 if(usertype.equals("admin")){
			 message = "您好，学院通知没有发布任何新闻";
		 }else{
			 message = "您好，"+usertype+"还没有发布任何新闻";
		 }
		 
	  }
	 rs.beforeFirst(); //复位结果集
	while(rs.next()){
		
		if(land){
			s +=("<tr><td>"+"<a href='newscontent.jsp?id="+rs.getString("id")+
					"'>"+rs.getString("title")+"</td><td><a>"+rs.getString("publishertype")+
					"</td><td>"+"<a href='delete.jsp?id="+
					rs.getString("id")+"'>&nbsp删除&nbsp&nbsp</td><td>"+"<form action='ueditor/index.jsp?id="+
					rs.getString("id")+"' method=post ><input name=newstype type=hidden value=xytz>"+
					"<input name=submit type=submit value=编辑></form></td></tr>");
		} else if(!land||usertype==""){
			s +=("<tr><td>"+"<a href='newscontent.jsp?id="+rs.getString("id")+
					"'>"+rs.getString("title")+"</td><td>"+"<a>"+rs.getString("publishertype")+
					"</td></tr>");
		}
	}
	//st.executeUpdate("insert into shownews values(null,'大师不妙','你的士大夫撒旦法',now(),'sdf',null,'学院通知','学院办公室')");
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
	<a href="mainindex.jsp">返回</a>
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
	<h1 align="center">学院通知</h1>
	
	
	<div align="left">
	<%
		if(land&&usertype!="admin"){
	%>
		<form name="form1" method="post" action="xytz.jsp" >
	   <input type="hidden" name="action"  value = "true"> 
	<input name=submit type=submit value=发表新闻>
	   </form>
	<% 
		}
	%>
	<table border=1r>
		<%= s %>
		<%= message %>
	</table>
	</div>
</body>
</html>
<% 
// 防止刷新的时候s再叠加一次
	s = ""; 
	message="";
	land = false;
%>
