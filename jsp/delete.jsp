<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>
<%
String c_id = request.getParameter("c_id");
int c_no = Integer.parseInt(request.getParameter("c_no"));
Statement stmt = null;
String mySQL = null;
stmt = myConn.createStatement();
mySQL = "delete from enroll where c_id='" + c_id + "' and c_no ='" + c_no + "' and s_id=" + session_id + "";
int re = stmt.executeUpdate(mySQL);
if (re != 0) {
%>
<script>
	alert("삭제되었습니다..");
	location.href = "select.jsp";
</script>
<% } else { %>
<script>
	alert("오류..");
	location.href = "select.jsp";
</script>
<%
}
stmt.close();
myConn.close();
%>