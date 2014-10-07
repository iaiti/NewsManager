<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="java.sql.*"%>
<%@ page import="com.news.zk.ConnectNews"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<%
	request.setCharacterEncoding("utf-8");
%>

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
	id = request.getParameter("id");
	response.setCharacterEncoding("utf-8");
	r = request.getParameter("content");
	newstype = request.getParameter("newstype");
	title = request.getParameter("title");
	author = request.getParameter("author");
	//这个是我弄了最久的  编辑器只需编辑新闻的正文内容 再将其和html格式的代码一同存入数据库
	//用的是ueditor 可自定义功能 不错
	Connection c = db.getConn();
	Statement st = db.getSt(c);
	c.setAutoCommit(false);
	String sqlone = "select * from shownews where id =" + id;
	ResultSet rs = st.executeQuery(sqlone);
	rs.next();
	s = rs.getString("content");
	tit = rs.getString("title");
	attachment =rs.getString("attachment");
	//attachment = new String(rs.getString("attachment").getBytes("gb2312"),"gbk");
	//System.out.println(attachment);
	
	//拿到数据库存储的内容 作者标题 附件名
	if (attachment != null && attachment != "") {
		a = "附件" + attachment;
		a = a.replaceAll("null;", "");
		a = a.replaceAll("<input type=submit value=删除附件>","");
	}if(a.equals("附件     ")) {
		a = "附件为空";
	}
	au = rs.getString("author");
	//拿到数据库存储的内容 作者标题 附件名
	//要判断 jsp是否传入值 一旦更改的话 request就能拿到整个编辑内容 再update一下
	if (r != "" && r != null) {
		s = r;
		tit = title;
		au = author;
		String sql = "update shownews set content ='" + s
				+ "',author = '" + au + "',title = '" + tit
				+ "'where id =" + id;
		st.executeUpdate(sql);
		c.commit();
		c.setAutoCommit(true);
		st.close();
		c.close();
		response.sendRedirect("../xsdt.jsp");
	}
%>

<html>
<head>
<title>完整demo</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript" charset="utf-8" src="editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="editor_all.js"></script>
<style type="text/css">
.clear {
	clear: both;
}
</style>
</head>
<body>
	<a href="../<%= newstype %>.jsp">返回&nbsp</a><br/>
	<script type="text/javascript">
		function op(){
			window.open("includeattachment.jsp?id=<%=id%>&newstype=<%=newstype%>");
		}
	</script>
	<%= a %><br>
	<input type=button value="添加删除附件" onclick="op()"><br>
	
	<a>正文:</a>

<script  type="text/javascript" charset="utf-8" src="../checkvoid.js"></script>
<form name="form2" method="post" action="index.jsp?id=<%= id %>">
<table width="700">
	<tr>
		<td>标题</td>
	</tr>
	<tr>
		<td><input type="text" name="title" size="80" value=<%= tit %>></td>
	</tr>
	<tr>
		<td>作者</td>
	</tr>
	<tr>
		<td><input type="text" name="author" size="80" value=<%= au %>></td>
	</tr>
</table>
<table width="600" border="0" cellpadding="2" cellspacing="3">
	<tr>
		<td>
		<div><script id="editor" type="text/plain" name="content"><%=s %>&nbsp</script></div>
		</td>
	</tr>
	<tr>
		<td><input name="submit" type="submit" value="确定提交">
	</tr>

</table>
</form>

<script type="text/javascript" charset="utf-8" src="../js/neweditor.js"></script>

</body>
</html>