<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<head>
<title>내 강의 조회</title>
<style>
tr:hover {
	background-color: #f1cbff;
}

a:hover {
	color: #ffffff;
}
</style>
</head>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>
<%
if (session_id == null) {
%>
<script>
	alert("로그인이 필요합니다.");
	location.href = "login.jsp";
</script>
<%
} else {
%>
<div id="containerwrap">
	<div id="container">
		<div class="section_title">
			<h1>
				<span>신청한 강의 목록</span>
			</h1>
		</div>
		<table id="insert_table" width="75%" align="center" border>
			<br />
			<tr style="background: #c9c9ff">
				<th>과목번호</th>
				<th>과목이름</th>
				<th>분반번호</th>
				<th>학점</th>
				<th>요일</th>
				<th>교시</th>
				<th>장소</th>
				<th>수강신청</th>
			</tr>
			<%
CallableStatement stmt = null;
ResultSet myResultSet = null;
String mySQL = "{call StudentEnrollTimetable(?,?,?,?)}";
stmt = myConn.prepareCall(mySQL);
stmt.setInt(1, session_id);
stmt.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR);
stmt.registerOutParameter(3, oracle.jdbc.OracleTypes.NUMBER);
stmt.registerOutParameter(4, oracle.jdbc.OracleTypes.NUMBER);
stmt.execute();
myResultSet = (ResultSet) stmt.getObject(2);
int sumCourse = stmt.getInt(3);
int sumUnit = stmt.getInt(4);
while (myResultSet.next()) {
String c_id = myResultSet.getString("c_id");
int c_no = myResultSet.getInt("c_no");
String c_name = myResultSet.getString("c_name");
int c_credit = myResultSet.getInt("c_credit");
int t_hour = myResultSet.getInt("t_hour");
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
String t_room = myResultSet.getString("t_room");
%>
			<tr>
				<td align="center"><%=c_id%></td>
				<td align="center"><%=c_name%></td>
				<td align="center"><%=c_no%></td>

				<td align="center"><%=c_credit%></td>
				<td align="center"><%=dayString%></td>
				<td align="center"><%=t_hour%></td>
				<td align="center"><%=t_room%>
				<td align="center"><a
					href="delete.jsp?c_id=<%=c_id%>&c_no=<%=c_no%>">삭제</a></td>
			</tr>
			<%
}
%>
		</table>
		<h3 align="center" style="margin: 3em;">
			신청 학점 수:
			<%=sumUnit%>
			과목 수:
			<%=sumCourse%>


		</h3>
	</div>
</div>
<%
stmt.close();
myConn.close();
}
%>
