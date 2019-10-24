<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8"); // 한글 처리 구문
	Connection myConn = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db01";
	String pwd = "db01";
	String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(jdbc_driver);
	myConn = DriverManager.getConnection(dburl, user, pwd);
%>