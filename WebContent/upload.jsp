<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!
String id = "";
%>
<%
	id = request.getParameter("id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript">
	function check(){
 		if(document.upform.zzz.file1.value.length  ==  0){
 			alert("空!");
 			return false;
 		}
 		return true;
	}
	
var  i  =   2 ; 
  function  testAdd() 
    { 
    
     	var tr = document.getElementById("xxx").insertRow( 1 );
		var td = document.createElement("td");
		var input = document.createElement("input");
		input.id = "file" + i;
		input.name = "file" + i;
		input.type = "file";
		td.appendChild(input);
		tr.appendChild(td);
		i++;
} 
</script>
</head>
<body>
     <button onclick="testAdd();">增加新附件</button>
<!-- 这里有个小技巧 onsubmit=“return function” 如果为false 不跳转 反之跳转-->
    <form name="form" action="doUpload.jsp?id=<%= id%>" method="POST"
     enctype="multipart/form-data" onsubmit="return check()"> 
     <table  id="xxx"> 
  <tr > 
    <td>  <input type ="file" name="file1" id="file1"/> </td> 
  </tr> 
  </table> 
  
              <input type="submit" value="附件上传" /><br/> 
              <input type="reset" value="重置" /><br/>    
      </form>

 
<a href="ueditor/index.jsp?id=<%=id%>">返回编辑</a><br/>
</body>
</html>