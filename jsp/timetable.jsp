<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random"%>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>
<link rel="stylesheet" href="css/table.css">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<!-- / College Timetable -->

<%
Statement stmt = null;
CallableStatement cstmt = null;
String sql = null;
int nYear=0;
int nSem=0;
class Course {
   String c_name;
   String t_where;
   String p_name;
   String color;
   public Course(String c_name, String t_where, String p_name) {
      this.c_name = c_name;
      this.t_where = t_where;
      this.p_name = p_name;
      this.color = color_select();
   }
   String color_select() {
      Random random = new Random();
      String result = null;
      result = "color" + (random.nextInt(5) + 1);
      return result;
   }
}//endclass
Course[][] cour = new Course[8][5];
if (session_id == null) { %>
<script>
	alert("로그인이 필요합니다.");
	location.href = "login.jsp";
</script>
<% }//endif
else {
stmt = myConn.createStatement();

String yearsql = "{?=call Date2EnrollYear(SYSDATE)}";
cstmt=myConn.prepareCall(yearsql);
cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
cstmt.execute();
nYear = cstmt.getInt(1);


String smsql = "{?=call Date2EnrollSemester(SYSDATE)}";
cstmt=myConn.prepareCall(smsql);
cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
cstmt.execute();
nSem = cstmt.getInt(1);

if (session_identity == "student") {
   sql = "select c.c_name, t.t_room, t.t_day, t.t_hour, p.p_name"
   + " from course c, enroll e, teach t, professor p"
   + " where e.C_ID=c.C_ID and e.C_NO=c.C_NO and e.s_id = " + session_id
   + " and e.e_sem = " + nSem + " and e.e_year = " + nYear
   + " and t.C_ID = e.c_id and t.C_NO = e.c_no and p.p_id = t.p_id";
} else {
   sql = "select c.c_name, t.t_room, t.t_day, t.t_hour"
   + " from course c, teach t"
   + " where t.t_sem = " + nSem + " and t.t_year = "+ nYear
   + " and t.C_ID = c.c_id and t.C_NO = c.c_no and t.p_id = " + session_id;
   
}
ResultSet rs = stmt.executeQuery(sql);
   while (rs.next()) {
   String c_name = rs.getString(1);
   String t_where = rs.getString(2);
   int t_day = rs.getInt(3);
   int t_time = rs.getInt(4) - 1;
   String p_name = "";
   if (session_identity == "student") {
   p_name = rs.getString(5);
   }
   if (t_day == 1)
   cour[t_time][0] = cour[t_time][2] = new Course(c_name, t_where, p_name);
   else if (t_day == 2)
   cour[t_time][1] = cour[t_time][3] = new Course(c_name, t_where, p_name);
   else
   cour[t_time][4] = cour[t_time + 1][4] = new Course(c_name, t_where, p_name);
   %>
<%
   }//endwhile
%>
<div id="containerwrap">
	<div id="container">
		<div class="section_title">
			<h1>
				<span>시 간 표</span>
			</h1>
		</div>

		<div class='tab'>
			<center>
				<table border='0' cellpadding='0' cellspacing='0'>
					<tr class='days'>
						<th></th>
						<th>월요일</th>
						<th>화요일</th>
						<th>수요일</th>
						<th>목요일</th>
						<th>금요일</th>
					</tr>
					<% for (int i = 0; i < 8; i++) {%>
					<tr>
						<td class='time'><%=i + 1 %></td>
						<%
      for (int j = 0; j < 5; j++) {
      if (cour[i][j] != null) {
      %>
						<td class='mouseon <%=cour[i][j].color %>'
							data-tooltip='<%= cour[i][j].p_name %>'><%=cour[i][j].c_name %><br />
							<%=cour[i][j].t_where %></td>
						<% } else {%>
						<td></td>
						<%
      }//endelse
      }//endfor
      %>
					</tr>
					<%}//endfor %>
				</table>
			</center>
		</div>
		<!--  tab -->
		<% } %>
	</div>
</div>
