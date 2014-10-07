<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.news.zk.*"%>
<%@ page import="java.security.*"%>

<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<jsp:useBean scope="page" id="md" class="com.news.zk.MD"/>
<%
	request.setCharacterEncoding("utf-8");
%>
<!-- 上句解决了传进来的中文乱码问题！ -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	// 此处 用到session  会在当前页面存一段时间 一旦tomcat重启 密码用户名需重新输入
	//这里对比数据库user.sql 的数据   正确将进入后天管理界面
	String action = request.getParameter("action");
	if (action!=""&&action != null && action.equals("post")) {
		String user = request.getParameter("user");
		//算法加密
		String pw = "";
		//注意 md5的方法应该定义为public 不然private的话 javabean拿不到
		pw = md.toMd5(request.getParameter("password"));
		//session设定一对键值 登录对了为true
		session.setAttribute("correct", "false");
		session.setAttribute("everland", null);
		Connection c = db.getConn();
		Statement st = db.getSt(c);
		ResultSet rs = st.executeQuery("select * from users");
		while(rs.next()){
			//登录名空或错误为false
			if (user == null || !user.equals(rs.getString("name")) || pw == null
					|| !pw.equals(rs.getString("pw"))) {
				session.setAttribute("userland", "false");
%>
		<script language="javascript">
				alert("用户名或登录密码错误！请重试");
		</script>
<% 			
			} else {
				session.setAttribute("userland","true");
				if(rs.getString("usertype").equals("学院办公室")){
						session.setAttribute("usertype", "学院办公室");
				} if(rs.getString("usertype").equals("学生工作办公室")){
						session.setAttribute("usertype", "学生工作办公室");
				} if(rs.getString("usertype").equals("党建工作办公室")){
						session.setAttribute("usertype", "党建工作办公室");
				} if(rs.getString("usertype").equals("书记办公室")){
						session.setAttribute("usertype", "书记办公室");
				} if(rs.getString("usertype").equals("院长办公室")){
						session.setAttribute("usertype", "院长办公室");
				} if(rs.getString("usertype").equals("administrator")){
						session.setAttribute("usertype", "admin");
				}
				response.sendRedirect("mainindex.jsp");	
				return;
			}
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body onload="document.getElementById('user').focus()">
	<a>用户名admin 密码 admin    </a><a href="mainindex.jsp">点击返回主页</a>
	<form action="userland.jsp" method="post">
	<input type="hidden" name="action" value="post"> </input>
		<table>
			<tr>
				<td>用户名</td>
				<td><input type="text" size="30" id="user" name="user" /></td>
			</tr>
			<tr>
				<td>密码</td>
				<td><input type="password" size="30" name="password" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="提交" /></td>
			</tr>
		</table>
	
</form>
</body>
</html>