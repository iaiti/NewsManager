package com.news.zk;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class ConnectUser  {

		public static Connection getConn(){
				Connection conn = null;
			try{
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/news?user=root&password=sql&useUnicode=true&characterEncoding=utf-8");
			} catch (ClassNotFoundException e){
				e.printStackTrace();
			} catch (SQLException e){
				e.printStackTrace();
			}
			
			return conn;
		}
		
		public static Statement getSt(Connection conn){
			Statement st = 	null;
			if(conn != null){
				try {
					st = conn.createStatement();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return st;
		}
		
		public static ResultSet getRs(Statement st,Connection conn){
			ResultSet rs = null;
			if(st != null){
				try {
					rs = st.executeQuery("select * from article");
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return rs;
		}
		
		public static void close(Connection conn){
			if(conn != null){
				try {
					conn.close();
					conn = null;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		public static void close(Statement st){
			if(st != null){
				try {
					st.close();
					st = null;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		public static void close(ResultSet rs){
			if(rs != null){
				try {
					rs.close();
					rs = null;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	


	
}
