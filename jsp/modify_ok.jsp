<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<title>수정</title>
</head>
<body>
	<%@ include file="dbconfig.jsp"%>
	<%
String password = "";
Statement stmt = null;
int idx = Integer.parseInt(request.getParameter("idx"));
String title = request.getParameter("title");
String memo = request.getParameter("memo");
String passw = request.getParameter("password");
stmt = myConn.createStatement();
String sql = "SELECT b_pwd FROM board WHERE b_no=" + idx;
ResultSet rs = stmt.executeQuery(sql);
if(rs.next()) {
password = rs.getString(1);
}
if(password.equals(passw)) {
sql = "UPDATE board SET b_title='" + title+ "' ,b_content='"+ memo +"' WHERE b_no=" + idx;
stmt.executeUpdate(sql);
%>
	<script language=javascript>
self.window.alert("글이 수정되었습니다.");
location.href = "view.jsp?idx=<%=idx%>
		";
	</script>
	<%
rs.close();
stmt.close();
myConn.close();
} else {
%>
	<script language=javascript>
		self.window.alert("비밀번호를 틀렸습니다.");
		location.href = "javascript:history.back()";
	</script>
	<%
}
%>