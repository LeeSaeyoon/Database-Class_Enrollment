<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<head>
<style>
#gg {
	color: #F361A6;
}

#add_course {
	color: #FFB2D9;
}
}
</style>
<link rel="stylesheet" href="colorbox.css">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="layout.css">
<link rel="stylesheet" href="professor.css">
<title>수업 생성</title>
</head>
<%@ include file="top.jsp"%>
<%
   if (session_id == null)
      response.sendRedirect("login.jsp");
   else {
%>
<div id="containerwrap">
	<div id="container">
		<div class="section_title">
			<h1>
				<span id="gg">수업 생성</span>
			</h1>
		</div>
		<center>
			<form method="post" action="createCourse_verify.jsp">
				<table id="gener_course_table" width="75%" align="center" border>
					<tr>
						<td colspan="2">
							<div align="center">
								<h2 id="add_course">강의 추가</h2>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">강의 번호</div>
						</td>
						<td>
							<div align="center">
								<input type="text" name="course-Id">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">강의 분반 번호</div>
						</td>
						<td>
							<div align="center">
								<input type="text" name="course-No">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">강의 명</div>
						</td>
						<td>
							<div align="center">
								<input type="text" name="course-Name">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">학점</div>
						</td>
						<td>
							<div align="center">
								<input type="text" name="course-Credit">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">최대 수강 인원</div>
						</td>
						<td>
							<div align="center">
								<input type="text" name="course-MaxPPL">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">수업 요일</div>
						</td>
						<td>
							<div align="center">
								<select name="course-Day">
									<option value="">요일 선택</option>
									<option value="1">월,수</option>
									<option value="2">화,목</option>
									<option value="3">금</option>
								</select>
							</div>
					</tr>
					<tr>
						<td>
							<div align="center">수업 시간</div>
						</td>
						<td>
							<div align="center">
								<select name="course-Hour">
									<option value="">시간 선택</option>
									<option value="1">1교시 9:00-10:30</option>
									<option value="2">2교시 10:30-12:00</option>
									<option value="3">3교시 12:00-13:30</option>
									<option value="4">4교시 13:30-15:00</option>
									<option value="5">5교시 15:00-16:30</option>
									<option value="6">6교시 16:30-18:00</option>
									<option value="7">7교시 18:00-19:30</option>
									<option value="8">8교시 19:30-21:00</option>
								</select>
							</div>
						</td>
					<tr>
						<td>
							<div align="center">수업 장소</div>
						</td>
						<td>
							<div align="center">
								<input type="text" name="course-Room">
							</div>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<div align="center">
								<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="추가"> <INPUT
									TYPE="RESET" VALUE="취소">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</center>
	</div>
</div>
<%
   }
%>
