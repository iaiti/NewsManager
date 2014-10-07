<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="java.sql.*"%>
<%@ page import="com.news.zk.*"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<%
	request.setCharacterEncoding("utf-8");
%>
<%!
	String s = "";
	String r = "";
	String id = "";
	String attachment = "";
	String a = "";
	String at = "";
	String saveFile = "";
	String fileName = "";
	String usertype = "";
	String t = "";
	String newstype = "";
%>
<%
	id = request.getParameter("id");
	String action = request.getParameter("action");
	newstype = request.getParameter("newstype");
	String what = (String)session.getAttribute("usertype");
	if(what==null||what.equals("")){
		usertype = "";
	} else{
		usertype = what;
	}
	Connection c = db.getConn();
	Statement st = db.getSt(c);
	c.setAutoCommit(false);
	ResultSet rs = st.executeQuery("select * from shownews where id="
			+ id);
	rs.next();
	attachment = rs.getString("attachment");
	if (attachment != null && attachment != "") {
		at = "附件" + attachment;
		at = at.replaceAll("null;", "");
		at = at.replaceAll("<input type=submit value=删除附件>","");
	}if(at.equals("附件 ")) {
		at = "未添加附件";
	}
	if (action != null && action.equals("post")) {
		String t = request.getParameter("title");
		String cs = request.getParameter("content");
		String a = request.getParameter("author");

		//这个是我弄了最久的  编辑器只需编辑新闻的正文内容 再将其和html格式的代码一同存入数据库
		st.executeUpdate("UPDATE shownews SET title = '" + t
				+ "',author = '" + a + "', content='" + cs+"',publishertype='"+usertype
				+ "'where id = " + id);
		//要判断 jsp是否传入值 一旦更改的话 request就能拿到整个编辑内容 再update一下
		c.commit();
		c.setAutoCommit(true);
		response.sendRedirect("../"+newstype+".jsp");
		//response.sendRedirect("../mainindex.jsp");
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript" charset="utf-8" src="editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="editor_all.js"></script>
<style type="text/css">
.clear {
	clear: both;
}
</style>
</head>
<script  type="text/javascript" charset="utf-8" src="../js/checkvoid.js"></script>

<!--  拿到焦点 不用每次都去移动鼠标 -->
<body onload="document.getElementById('title').focus()">

<!-- <script type="text/javascript">
function CloseWin(){
if(confirm("您确定要放弃编辑本页面的内容？")){
       window.open("../xsdt.jsp","_self");
       return false;
}
return false;
}
</script> -->




<form action="../<%= newstype%>.jsp" method="post" name="turnform" >
	<input id="dle" name="dle" type = "hidden"  value="<%= id %>">
	<input name="back" id="back" type="submit" value="返回">
</form>
<script type="text/javascript">
		function op(){
			window.open("includeattachment.jsp?id=<%=id%>&newstype=<%=newstype%>&type=publish");
		}
	</script>
	<%=at%><br>
	<input type=button value="添加删除附件" onclick="op()">

<script  type="text/javascript" charset="utf-8" src="../js/checkvoid.js"></script>
<form name="form2" action="publish.jsp?id=<%= id %>" 
	method="post" onsubmit="return check()">
	<input type="hidden" name="action" value="post">
	<input type="hidden" name="newstype" value="<%= newstype %>">
	<table width="700">
		<tr>
			<td>标题</td>
		</tr>
		<tr>
			<td><input type="text" name="title" size="80"></td>
		</tr>
		<tr>
			<td>作者</td>
		</tr>
		<tr>
			<td><input type="text" name="author" size="80"></td>
		</tr>
	</table>
	
	<table>
		<tr>
			<td>正文：</td>
		</tr>
	
		<tr>
			<td><script id="editor" type="text/plain" name="content">&nbsp</script>
			</td>
		</tr>
	</table>
	
	<table>
		<tr>
			<td align="right">&nbsp;</td>
			<td><input name="submit" type="submit" value="确定提交">
		</tr>
	</table>
</form>


<script type="text/javascript" charset="utf-8" src="../js/neweditor.js"></script>
</body>
</html>
<% newstype = "";%>