<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<head>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="layout.css">
<title>수강신청</title>
<style>
a:hover {
	color: #ffffff;
}

tr:hover {
	background-color: #f1cbff;
}
</style>
</head>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>
<%
if (session_id == null) {
%>
<script>
	alert("로그인 후 사용하세요.");
	location.href = "login.jsp";
</script>
<%
} else {
%>
<%
CallableStatement cstmt = null;
CallableStatement cstmt2 = null;
cstmt = myConn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
cstmt.execute();
int sem = cstmt.getInt(1);
cstmt2 = myConn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
cstmt2.execute();
int year = cstmt2.getInt(1);
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL = "";
stmt = myConn.createStatement();
mySQL = "select c.c_id,c.c_no,c.c_name,c.c_credit,t.t_room, t.t_hour, t.t_day from course c, teach t where t.c_id = c.c_id and t.c_no = c.c_no and c.c_id not in (select c_id from enroll where s_id="+ session_id + " and e_year ="+year+" and e_sem = "+sem+") and t_year =" + year + " and t_sem = " + sem;
%>
<div id="container2">
	<div id="container">
		<div class="section_title">
			<h1>
				<span><%=year%> 년 <%=sem%> 학기 수강신청</span>
			</h1>
		</div>
		<table id="insert_table" width="75%" align="center" border>
			<br />
			<tr style="background-color: #c9c9ff">
				<th>과목번호</th>
				<th>과목이름</th>
				<th>분반</th>
				<th>학점</th>
				<th>요일</th>
				<th>교시</th>
				<th>장소</th>
				<th>수강신청</th>
			</tr>
			<%
myResultSet = stmt.executeQuery(mySQL);
if (myResultSet != null) {
while (myResultSet.next()) {
String c_id = myResultSet.getString("c_id");
String c_no = myResultSet.getString("c_no");
String c_name = myResultSet.getString("c_name");
int c_credit = myResultSet.getInt("c_credit");
int t_hour = myResultSet.getInt("t_hour");
String t_room = myResultSet.getString("t_room");
int t_day = myResultSet.getInt("t_day");
String dayString="";
if(t_day==1){
	 dayString="월,수";
}
else if(t_day==2){
	 dayString="화,목";
}
else{
	 dayString="금";
}
%>
			<tr>
				<td align="center"><%=c_id%></td>
				<td align="center"><%=c_name%></td>
				<td align="center"><%=c_no%></td>

				<td align="center"><%=c_credit%></td>
				<td align="center"><%=dayString%></td>
				<td align="center"><%=t_hour%></td>
				<td align="center"><%=t_room%></td>
				<td align="center"><a
					href="insert_verify.jsp?c_id=<%=c_id%>&c_no=<%=c_no%>">신청</a></td>
			</tr>
			<%
}
}
cstmt.close();
cstmt2.close();
stmt.close();
myConn.close();
}
%>
		</table>
	</div>
</div>
