<%@ page contentType="text/html; charset=gbk"
	import="java.util.*,com.jspsmart.upload.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.news.zk.ConnectNews"%>
<jsp:useBean scope="page" id="db" class="com.news.zk.ConnectNews"/>
<%!
	String saveFile = "";
	String fileName = "";
	String fileName2 = "";
	String t = "";
	String att = "";
	String bf = "";
	String[] everyfile = new String[64];
	String usertype = "";
	String newstype = "";	
%>
<%
	//文件处理流是我自己不擅长的  通过网上查找 找到了本地的文件上传
	//这方面在补强当中 有空再研究smartload是怎么实现的 总用别人的不好
	//这当然也有上传服务器的 不过不一样 到时集成时再用
	newstype = request.getParameter("newstype");
	String id = request.getParameter("id");
	Connection c = db.getConn();
	Statement st = db.getSt(c);
	c.setAutoCommit(false);
	String what = (String)session.getAttribute("usertype");
	if(what==null||what.equals("")){
		usertype = "";
	}else{
		usertype = what;
	}
	//String sql = "UPDATE users SET source = "+fileName+" WHERE id = "+id+'"';
	//String sql2 = "select title from shownews WHERE id = "+id+'"';
	ResultSet rs = st.executeQuery("select * from shownews WHERE id = "
			+ id);
	rs.next();
	t = rs.getString("title");
	att = rs.getString("attachment");
	c.commit();
	String singlefile = "";
%>
<HTML>
<BODY>
<%
	// 初始化
	//final String upFileType="zip|rar|doc|txt|jpg|xls";       //上传文件类型
	final int MAXFILESIZE = 20480000; //上传文件大小限制
	String errMsg = null; //错误信息
	boolean err = false; //错误标志
	int fileSize = 0; //文件大小
	int count = 0;
	String button1 = "";
	String button2 = "";
	String p =   request.getParameter("puborin");;
	SmartUpload MySmartUpload = new SmartUpload();
	MySmartUpload.initialize(pageContext);
	String myFileName = "";
	// 上传文件
	MySmartUpload.upload();
	//判断将要上传文件的总容量是否超过上限
	count += MySmartUpload.getSize();
	if (count > MAXFILESIZE) {
		out.print("<script>alert('上传失败！文件大小:" + count / 1024
				+ "K超出了限定的范围(最大" + MAXFILESIZE / 1024
				+ "K)');this.history.go(-1);</script>");
		//response.sendRedirect("http://127.0.0.1:8080/javastudy/upload.htm");
	}

	// 循环取得上传所有文件
	else {
		for (int j = 0; j < MySmartUpload.getFiles().getCount(); j++) {
			com.jspsmart.upload.File myFile = MySmartUpload.getFiles()
					.getFile(j);
			if (!myFile.isMissing()) {
				
				singlefile = myFile.getFileName();
				//button1是为了给整个附件名围上form 到时可提交
				button1 = "<form method=post action=../deleteattachment.jsp?id="+id+"\\&newstype="
						+newstype+"><input type=hidden name=singlefile value="+singlefile+">";
				//button为附件名后添加删除按钮
				button2 = "<input type=submit value=删除附件></form>";
				everyfile[j] = button1+myFile.getFileName()+button2;
				myFileName += myFile.getFileName() ;//得到文件名
				fileName2 += everyfile[j] ;//得到文件名
				System.out.println(myFileName);
				//if(myFileName.length()>0){   //取得不带后缀的文件名
				//StringsubFileName=myFileName.substring(0,myFileName.lastIndexOf('.'));
				//}
				String fileType = myFile.getFileExt();//得到文件扩展名
				fileType = fileType.toLowerCase(); //将扩展名转换成小写
				//if (upFileType.indexOf(fileType)==-1){
				// err=true;
				//errMsg="文件"+myFileName+"上传失败！只允许上传以下格式的文件："+upFileType;
				// }
				//得到单个文件大小
				//fileSize+=myFile.getSize();
				//if (err==false&&fileSize>MAXFILESIZE){
				//   err=true;
				//  errMsg="上传失败！文件大小超出了限定的范围(最大"+MAXFILESIZE/1024+"K)";
				//}

				if (err == false) {
					//取得路径
					//String adss=getServletContext().getRealPath("/")+"JSP\\";
					//String trace=adss+myFileName;
					//保存文件
					//StringnewFileName="001."+fileType;  //可自动生成文件名以防止同名覆盖
					//myFile.saveAs(trace);
					myFile.saveAs("e:\\upload\\" +singlefile);
					if (att != "" && att != null) {
						String add = att;
						st.executeUpdate("UPDATE shownews SET attachment = '"+ add
										+ fileName2+ "' where id = " + id);
					} else {
						st.executeUpdate("UPDATE shownews SET attachment = '"
										+ fileName2+ "' where id = " + id);
					}

				} else {
					out.print("<script>alert('" + errMsg
							+ "');this.history.go(-1);</script>");
				}
			}
		}
		//out.print("<script>alert('上传文件成功!文件大小：" + myFileName + count
				// / 1024 + "K');this.history.go(-1);</script>");
		response.sendRedirect("ueditor/publish.jsp?id="+ id+"&newstype="+newstype);
		
		out.println(fileName2);
		c.commit();
		c.setAutoCommit(true);
		//这个是星期天晚上想到头晕的问题所在 部分数据可能还在内存中 添加多个时发现莫名奇妙的多了一大堆
		//东西 看到我头疼 文件名取完一次 把它设为空值 就不会与之前的那些重叠 坑爹
		fileName2="";
		st.close();
		rs.close();
		c.close();
	}
%>
</BODY>
</HTML>
