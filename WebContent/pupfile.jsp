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
	//�ļ������������Լ����ó���  ͨ�����ϲ��� �ҵ��˱��ص��ļ��ϴ�
	//�ⷽ���ڲ�ǿ���� �п����о�smartload����ôʵ�ֵ� ���ñ��˵Ĳ���
	//�⵱ȻҲ���ϴ��������� ������һ�� ��ʱ����ʱ����
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
	// ��ʼ��
	//final String upFileType="zip|rar|doc|txt|jpg|xls";       //�ϴ��ļ�����
	final int MAXFILESIZE = 20480000; //�ϴ��ļ���С����
	String errMsg = null; //������Ϣ
	boolean err = false; //�����־
	int fileSize = 0; //�ļ���С
	int count = 0;
	String button1 = "";
	String button2 = "";
	String p =   request.getParameter("puborin");;
	SmartUpload MySmartUpload = new SmartUpload();
	MySmartUpload.initialize(pageContext);
	String myFileName = "";
	// �ϴ��ļ�
	MySmartUpload.upload();
	//�жϽ�Ҫ�ϴ��ļ����������Ƿ񳬹�����
	count += MySmartUpload.getSize();
	if (count > MAXFILESIZE) {
		out.print("<script>alert('�ϴ�ʧ�ܣ��ļ���С:" + count / 1024
				+ "K�������޶��ķ�Χ(���" + MAXFILESIZE / 1024
				+ "K)');this.history.go(-1);</script>");
		//response.sendRedirect("http://127.0.0.1:8080/javastudy/upload.htm");
	}

	// ѭ��ȡ���ϴ������ļ�
	else {
		for (int j = 0; j < MySmartUpload.getFiles().getCount(); j++) {
			com.jspsmart.upload.File myFile = MySmartUpload.getFiles()
					.getFile(j);
			if (!myFile.isMissing()) {
				
				singlefile = myFile.getFileName();
				//button1��Ϊ�˸�����������Χ��form ��ʱ���ύ
				button1 = "<form method=post action=../deleteattachment.jsp?id="+id+"\\&newstype="
						+newstype+"><input type=hidden name=singlefile value="+singlefile+">";
				//buttonΪ�����������ɾ����ť
				button2 = "<input type=submit value=ɾ������></form>";
				everyfile[j] = button1+myFile.getFileName()+button2;
				myFileName += myFile.getFileName() ;//�õ��ļ���
				fileName2 += everyfile[j] ;//�õ��ļ���
				System.out.println(myFileName);
				//if(myFileName.length()>0){   //ȡ�ò�����׺���ļ���
				//StringsubFileName=myFileName.substring(0,myFileName.lastIndexOf('.'));
				//}
				String fileType = myFile.getFileExt();//�õ��ļ���չ��
				fileType = fileType.toLowerCase(); //����չ��ת����Сд
				//if (upFileType.indexOf(fileType)==-1){
				// err=true;
				//errMsg="�ļ�"+myFileName+"�ϴ�ʧ�ܣ�ֻ�����ϴ����¸�ʽ���ļ���"+upFileType;
				// }
				//�õ������ļ���С
				//fileSize+=myFile.getSize();
				//if (err==false&&fileSize>MAXFILESIZE){
				//   err=true;
				//  errMsg="�ϴ�ʧ�ܣ��ļ���С�������޶��ķ�Χ(���"+MAXFILESIZE/1024+"K)";
				//}

				if (err == false) {
					//ȡ��·��
					//String adss=getServletContext().getRealPath("/")+"JSP\\";
					//String trace=adss+myFileName;
					//�����ļ�
					//StringnewFileName="001."+fileType;  //���Զ������ļ����Է�ֹͬ������
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
		//out.print("<script>alert('�ϴ��ļ��ɹ�!�ļ���С��" + myFileName + count
				// / 1024 + "K');this.history.go(-1);</script>");
		response.sendRedirect("ueditor/publish.jsp?id="+ id+"&newstype="+newstype);
		
		out.println(fileName2);
		c.commit();
		c.setAutoCommit(true);
		//����������������뵽ͷ�ε��������� �������ݿ��ܻ����ڴ��� ��Ӷ��ʱ����Ī������Ķ���һ���
		//���� ������ͷ�� �ļ���ȡ��һ�� ������Ϊ��ֵ �Ͳ�����֮ǰ����Щ�ص� �ӵ�
		fileName2="";
		st.close();
		rs.close();
		c.close();
	}
%>
</BODY>
</HTML>
