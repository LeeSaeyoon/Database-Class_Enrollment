<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>
<head>

<title>수업 조회</title>
<style>
tr:hover {
	background-color: #FFB2D9;
}

a:hover {
	color: #f62217;
}
</style>
</head>
<%
   if (session_id == null)
      response.sendRedirect("login.jsp");
%>
<div id="containerwrap">
	<div id="container">
		<div class="section_title">
			<h1>
				<span>수업 시간표</span>
			</h1>
		</div>
		<center>
			<table width="80%" align="center" border>
				<br />
				<tr bgcolor="#F361A6">
					<th>과목번호</th>
					<th>분반</th>
					<th>과목명</th>
					<th>학점</th>
					<th>요일</th>
					<th>교시</th>
					<th>장소</th>
					<th>수업 삭제</th>
				</tr>
				<%
               CallableStatement stmt = null;
               ResultSet myResultSet = null;
               String mySQL = "{call ProfessorEnrollTimeTable(?,?,?,?)}";
               stmt = myConn.prepareCall(mySQL);
               stmt.setInt(1, session_id);
               stmt.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR);
               stmt.registerOutParameter(3, oracle.jdbc.OracleTypes.NUMBER);
               stmt.registerOutParameter(4, oracle.jdbc.OracleTypes.NUMBER);
               stmt.execute();
               myResultSet = (ResultSet) stmt.getObject(2);
               int total_course = stmt.getInt(3);
               int total_unit = stmt.getInt(4);
               if (myResultSet != null) {
                  while (myResultSet.next()) {
                     String c_id = myResultSet.getString("c_id");
                     int c_no = myResultSet.getInt("c_no");
                     String c_name = myResultSet.getString("c_name");
                     int c_credit = myResultSet.getInt("c_credit");
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
                     int t_hour = myResultSet.getInt("t_hour");
                     String t_room = myResultSet.getString("t_room");
            %>
				<tr>
					<td align="center"><%=c_id%></td>
					<td align="center"><%=c_no%></td>
					<td align="center"><%=c_name%></td>
					<td align="center"><%=c_credit%></td>
					<td align="center"><%=dayString%></td>
					<td align="center"><%=t_hour%></td>
					<td align="center"><%=t_room%></td>
					<td align="center"><a
						href="delete_course.jsp?c_id=<%=c_id%>&c_no=<%=c_no%>">삭제</a></td>
				</tr>
				<%
               }
               }
               stmt.close();
               myConn.close();
            %>
			</table>
			<h3 align="center" style="margin-top: 5em">
				총
				<%=total_course%>
				과목,
				<%=total_unit%>
				학점 수업입니다.
			</h3>
		</center>
	</div>
</div>
