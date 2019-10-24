<%@ page contentType="text/html; charset=UTF-8"%>
<head>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/layout.css" />
</head>
<%@ page import="java.sql.*"%>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>

<div id="containerwrap">
	<div id="container">
		<div id="content" class="login">
		<br><br><br>
			<div class="login_box" align="center">
				<form method="post" action="update.jsp">
					<fieldset class="formLogin">
						<div>
							<h2>비밀번호를 입력하여 주십시오.</h2>
							<br>
							<table class="inputTable">
								<%
									if (session_id == null) {
								%>
								<script>
									alert("로그인 해주시기 바랍니다.");
									location.href = "login.jsp";
								</script>
								<%
									} else {
								%>
								<tbody align="center">
									<tr>
										<td class="input"><input type="password" id="userpw"
											name="userpw" title="비밀번호" class="formText formText_Pass"
											onkeypress="if(event.keyCode=='13'){userLogin();}" /></td>
									</tr>
									<tr>
										<td class="blank02"></td>
									</tr>
									<tr>
										<td class="btn"><input type="submit" value="확인"
											class="btnRed01"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
					<%
						}
					%>
				</form>
			</div>
		</div>
	</div>
	