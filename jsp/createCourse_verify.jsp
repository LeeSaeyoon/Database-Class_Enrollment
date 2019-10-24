<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="top.jsp" %>
<%@ include file="dbconfig.jsp" %>
<%

String c_id = request.getParameter("course-Id");
String c_name = request.getParameter("course-Name");
int c_no = Integer.parseInt(request.getParameter("course-No"));
int c_credit = Integer.parseInt(request.getParameter("course-Credit"));
int t_hour = Integer.parseInt(request.getParameter("course-Hour"));
int t_maxppl = Integer.parseInt(request.getParameter("course-MaxPPL"));
int t_day = Integer.parseInt(request.getParameter("course-Day"));
String t_room = request.getParameter("course-Room");
String result = null;
CallableStatement stmt = null;
try {
stmt = myConn.prepareCall("call InsertCourse(?,?,?,?,?,?,?,?,?,?)");

stmt.setInt(1, session_id);
stmt.setString(2, c_id);
stmt.setInt(3, c_no);
stmt.setString(4, c_name);
stmt.setInt(5, c_credit);
stmt.setInt(6, t_maxppl);
stmt.setInt(7, t_day);
stmt.setInt(8, t_hour);
stmt.setString(9, t_room);
stmt.registerOutParameter(10, oracle.jdbc.OracleTypes.VARCHAR);
stmt.execute();
result = stmt.getString(10);
%>
<script>
alert("<%= result %>");
history.back();
</script>
<%
} catch (SQLException ex) {
System.err.println("SQLException: " + ex.getMessage());
} finally {
if (stmt != null)
try {
myConn.commit();
stmt.close();
myConn.close();
} catch (SQLException ex) {
}
}
%>