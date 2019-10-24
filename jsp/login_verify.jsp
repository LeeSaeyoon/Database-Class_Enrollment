<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconfig.jsp"%>
<link rel="style" type="text/css" href="style.css" />
<link rel="style" type="text/css" href="colorbox.css" />
<link rel="style" type="text/css" href="layout.css" />
<link rel="style" type="text/css" href="table.css" />
<%
   int userID = Integer.parseInt(request.getParameter("userid"));
   String userPW = request.getParameter("userpw");
   Statement stmt = null;
   stmt = myConn.createStatement();
   String mySQL = null;
   String p_mySQL = null;
   mySQL = "select s_id,s_name from students where s_id=" + userID + " and s_pw='" + userPW + "'";
   ResultSet rs = stmt.executeQuery(mySQL);

   if (rs != null && rs.next()) {
      String name = rs.getString("s_name");
      int id = rs.getInt("s_id");
      session.setAttribute("id", id);
      session.setAttribute("user", name);
      session.setAttribute("identity", "student");
      response.sendRedirect("main.jsp");
   } else {
      p_mySQL = "select p_id,p_name from professor where p_id=" + userID + " and p_pw='" + userPW + "'";
      ResultSet p_rs = stmt.executeQuery(p_mySQL);
      if (p_rs.next()) {
         String name = p_rs.getString("p_name");
         int id = p_rs.getInt("p_id");
         session.setAttribute("id", id);
         session.setAttribute("user", name);
         session.setAttribute("identity", "professor");
         response.sendRedirect("main.jsp");
      } else {
%>
<script language=javascript>
	alert("회원정보가 일치하지 않습니다.");
	location.href = "login.jsp";
</script>
<%
   }
   }
   stmt.close();
   myConn.close();
%>