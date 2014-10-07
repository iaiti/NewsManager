<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	newstype = request.getParameter("newstype");
	//这个是我弄了最久的  编辑器只需编辑新闻的正文内容 再将其和html格式的代码一同存入数据库
	//用的是ueditor 可自定义功能 不错
	Connection c = db.getConn();
	Statement st = db.getSt(c);
	c.setAutoCommit(false);
	String sqlone = "select * from shownews where id =" + id;
	ResultSet rs = st.executeQuery(sqlone);
	rs.next();
	attachment =rs.getString("attachment");
	//attachment = new String(rs.getString("attachment").getBytes("gb2312"),"gbk");
	//System.out.println(attachment);
	
	
	au = rs.getString("author");
	//拿到数据库存储的内容 作者标题 附件名
	if (attachment != null && attachment != "") {
		a = "附件" + attachment;
		a = a.replaceAll("null;", "");
	} else {
		a = "附件为空";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=a %><br/>
<script language="javascript"  type="text/javascript">
    function getconfirm()
    {
    
      window.opener.location.href='index.jsp?id=<%=id%>&newstype=<%=newstype%>'
         window.close();
     
    }
    </script>
    <script language="javascript"  type="text/javascript">
    function getconfirm2()
    {
    
      window.opener.location.href='publish.jsp?id=<%=id%>&newstype=<%=newstype%>&type=publish'
         window.close();
     
    }
    </script>
    <% if(request.getParameter("type")=="publish"){
    %>	
    	
	   <input type=button value="完成添加关闭窗口" onclick="getconfirm()">
    <% 	
    } else{
    %>	
    	<input type=button value="完成添加关闭窗口" onclick="getconfirm2()">
    <% 	
    }%>

<script type="text/javascript" charset="utf-8" src="../js/button.js"></script>
<form action="../upfile.jsp?id=<%= id %>&newstype=<%= newstype %>" method="post" name="form1"
	onSubmit="return check_file()" enctype="multipart/form-data">
	<input type="button" value="点击添加附件" onclick="addFile('dvTitles','file')">
	<input type="submit" name="Submit" value="上传下面附件">
<p>
<div id="dvTitles"></div>
</form>
</body>
</html>