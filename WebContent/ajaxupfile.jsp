<%@ page language="java" contentType="text/html
; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.news.zk.ConnectNews"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>    

<%!
	String s = "";
	String r = "";
	String id = "";
	String title = "";
	String date = "";
	String attachment = "";
	String a = "";
	String author = "";
	String tit = "";
	String au = "";
	String newstype="";
%>
<%
	response.setCharacterEncoding("utf-8");
	//这个是我弄了最久的  编辑器只需编辑新闻的正文内容 再将其和html格式的代码一同存入数据库
	//用的是ueditor 可自定义功能 不错
	Connection c = db.getConn();
	Statement st = db.getSt(c);
	c.setAutoCommit(false);
	String sqlone = "select * from shownews where id =20130425074050";
	ResultSet rs = st.executeQuery(sqlone);
	rs.next();
	attachment =rs.getString("attachment");
	//attachment = new String(rs.getString("attachment").getBytes("gb2312"),"gbk");
	//System.out.println(attachment);
	
	
	//拿到数据库存储的内容 作者标题 附件名
	if (attachment != null && attachment != "") {
		a = "附件" + attachment;
		a = a.replaceAll("null;", "");
	} else {
		a = "附件为空";
	}
//System.out.println(a);



StringBuffer bf = new StringBuffer();
if(a.trim().equals("附件")){
	a = "附件为空";
}
bf.insert(0,a);



response.getWriter().write(bf.toString());
	
	response.setContentType("text/html");
	//xml 和 html 明显很大的不同  xml很特别嘞
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
%>
