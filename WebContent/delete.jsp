<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="com.news.zk.ConnectNews"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<%!
	Statement st  = null;
	String delete = null;
	Connection c = null;
%>
<!-- request 写在下面！里面没用  主方法才行 -->
<%
		//拿到数据库的连接 执行语句 
	try{
		String id = request.getParameter("id");
		c = db.getConn();
		st = db.getSt(c);
		c.setAutoCommit(false);//删除该id对应的数据
		st.executeUpdate("delete from shownews where id =" + id);
	} catch (SQLException e) {
			e.printStackTrace();
	} finally {
		try {
			if (st != null){
				st.close();
				st = null;
			}
				//if(c != null){
				//c.close();
				//c = null;
				//}又是循环 这是主方法的c 不能关 还没跳出循环 反而是在最后的关
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
%>

<%
	//防止恶意删除者直接登录delete。jsp传入id和parentid后删除，所以验证有无session
	
	delete = (String) session.getAttribute("userland");
	if (delete != null && delete.equals("false")) {
		out.println("哈哈 你知道我的delete.jsp 又能怎样！hacker 别想进来恶意修改");
		return;
	}
	c.commit();
	c.setAutoCommit(true);
	c.close();
	response.sendRedirect("xsdt.jsp");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>delete</title>
</head>
<body>

</body>
</html>