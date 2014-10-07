<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.news.zk.ConnectNews"%>
<%
	request.setCharacterEncoding("utf-8");
request.setAttribute("newstype","xsdt");
%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%! 	
	String s = ""; 
	String r = "";
	String id = "";
	String singlefile = "";
	String title = "";
	String date = "";
	String attachment = "";
	String a = "";
	String author = "";
	String avoid = "";
	String newstype = "";
%>
<%
	//  为删除附件使用 
	id = request.getParameter("id");
	newstype = request.getParameter("newstype");
	//拿到删除附件按钮对应的文件名 singlefile
	r = request.getParameter("singlefile");
    
	        File file = new File("e:\\upload\\" +r);     
	        if(file.isFile() && file.exists()){     
	            file.delete();     
	        }   
  
	    	Connection c = db.getConn();
			Statement st = db.getSt(c);
			c.setAutoCommit(false);
	String sqlone ="select * from shownews where id ="+id;
	ResultSet rs = st.executeQuery(sqlone);
	rs.next();
	attachment = rs.getString("attachment");
	//System.out.println(new String(r.getBytes("gbk"),"UTF-8"));
	//System.out.println(r);
	//当该条数据的附件不为空，则将删除的附件名用replace变成空，因为是要要拿到附件名我想到得是用form来传输
	//跟一位前辈研究了一下午 他也没什么办法 所以自己想就暂时这样
	if(attachment!=null&&attachment!=""){
		a = attachment.replaceFirst("<form method=post action=../deleteattachment.jsp\\?id="+id+"\\&newstype="
				+newstype+
				"><input type=hidden name=singlefile value="+r+">"+r+"<input type=submit value=删除附件></form>"," ");
		
	
		//数据库处理  更新附件名字段
		st.executeUpdate("UPDATE shownews SET attachment = '"
				+a+ "' where id = " + id);
		c.commit();
		c.setAutoCommit(true);
		st.close();
		c.close();
		out.println(attachment);
		out.println(a);
		//删除后跳回编辑界面
		response.sendRedirect("ueditor/includeattachment.jsp?id="+id+"&newstype="
				+newstype);
	} 
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>