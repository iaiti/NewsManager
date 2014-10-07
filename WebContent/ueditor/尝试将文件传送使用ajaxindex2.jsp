<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="java.sql.*"%>
<%@ page import="com.news.zk.ConnectNews"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews" />
<%
	request.setCharacterEncoding("utf-8");
%>

<%!String s = "";
	String r = "";
	String id = "";
	String title = "";
	String date = "";
	String attachment = "";
	String a = "";
	String author = "";
	String tit = "";
	String au = "";
	String newstype = "";%>
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
	attachment = rs.getString("attachment");
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
	request.setAttribute("a", a);
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
<a href="../<%= newstype %>.jsp">返回&nbsp</a>
<br />

<script type="text/javascript">
			var req;
			function selec(){
				var url = "../ajaxupfile.jsp";
				//alert(url);
				 if(window.ActiveXObject) {
					req = new ActiveXObject("Microsoft.XMLHTTP");
				} else if(window.XMLHttpRequest){
					req = new XMLHttpRequest();
				}
				req.open("GET",url,true);
				req.onreadystatechange = callback;
				req.send(null);
			}
			
			function callback(){
				//alert(req.readyState);
				// 1 连上 2 loading 3 loaded 4
				if(req.readyState == 4){
				//alert(req.status)  
				//404错误  有得玩了
						//alert(req.responseText);
					//if(req.status==200){
					//alert("asdf");
						//var msg = req.responseXML.getElementsByTagName("category")[0];
						//拿到最根的节点
						//eval(req.responseText);
						//var msg = req.responseXML.getElementsByTagName("categories")[0];
						//alert(msg.childNodes.length);
						//逗号问题 一个中文 一个英文  真的看不出区别 怪不得调了那么久
						
						//同样的代码  在不同浏览器的 数组不一样  查了很久2013年4月17日1:06:03
						//ff的下界出问题  360连反应没有
						//alert(msg);
						//alert(msg.childNodes[0].childNodes[1].childNodes[0].nodeValue);
						parseXML();
					//}
				}
			}
			
			function parseXML(){
				//alert(xml);
				//msg = msg.replace(/(^\s*)|(\s*$)/g, "");   去除大堆的未知东西 转化成空格  
				//但是我这个没有这种问题  所以  直接判断isnull'  new String 是个好办法  佩服老师！
				//alert(msg);
				var a = req.responseText;
				document.getElementById("attachment").innerHTML= a;
				//alert(a);
				
			}
			
		</script>
		<!-- 调了很久的的东西  不知道select方法在button好像有冲突！ 果然  其他人也有类似的情况  
			应该是关键字问题
		 -->
		<input type="button" value="asdfdf" onclick="selec()" />
<span id="attachment"></span>
<br />
<a>正文:</a>

<script type="text/javascript" charset="utf-8" src="../checkvoid.js" ></script>
<form name="form2" method="post" action="index.jsp?id=<%= id %>" onClick="select()">
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

<script type="text/javascript" charset="utf-8" src="../js/button.js"></script>
<form action="../upfile.jsp?id=<%= id %>&newstype=<%= newstype %>"
	method="post" name="form1" onSubmit="return check_file()"
	enctype="multipart/form-data"><input type="button"
	value="点击添加附件" onclick="addFile('dvTitles','file')"> <input
	type="submit" name="Submit" value="上传下面附件" onclick="selecs()">
<p>
<div id="dvTitles"></div>
</form>
<script type="text/javascript" charset="utf-8" src="../js/neweditor.js"></script>

</body>
</html>