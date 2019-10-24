<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<head>
<link rel="stylesheet" href="css/style.css"/>
<link rel="stylesheet" href="css/colorbox.css"/>
<link rel="stylesheet" href="css/layout.css"/>
<link rel="stylesheet" href="css/table.css"/>
</head>
<%@ include file="top.jsp" %>
<%@ include file="dbconfig.jsp" %>

<!DOCTYPE html>
<html>
   <head><title> 수강신청 사용자 정보 수정 </title></head>
      <body>
      
      <%
         String sMessage = null;
         try {
            PreparedStatement p_stmt = null; 
         
            String newPass = request.getParameter("userpw");
            String newName = request.getParameter("username");
            String newAddr = request.getParameter("useraddr");
            String newEmail = request.getParameter("useremail");            
            
               if (session_identity == "student") {
               String sql = "UPDATE students set s_pw=?,s_addr=?,s_email=? where s_id =?";
               p_stmt = myConn.prepareStatement(sql);
               p_stmt.setString(1, newPass);
               p_stmt.setString(2, newAddr);
               p_stmt.setString(3, newEmail);
               p_stmt.setInt(4, session_id);
               p_stmt.executeUpdate();
            } else if (session_identity == "professor") {
               String sql = "UPDATE professor set p_pw=?,p_email=? where p_id =?";
               p_stmt = myConn.prepareStatement(sql);
               p_stmt.setString(1, newPass);
               p_stmt.setString(2, newEmail);
               p_stmt.setInt(3, session_id);
               p_stmt.executeUpdate();
            }
         } catch (SQLException ex) {
            if (ex.getErrorCode() == 20002) 
               sMessage = "비밀번호는 반드시 4자리 이상으로 설정해야 합니다.";
            else if (ex.getErrorCode() == 20003) 
               sMessage = "비밀번호에 띄어쓰기가 포함될 수 없습니다.";
            else 
               sMessage = "잠시 후 다시 시도해주기 바랍니다.";
         %>
         <script>
            alert("<%= sMessage %> ");
            location.href = "update.jsp";
         </script>
         <%
         }
      %>
      <script>
         alert("사용자 정보를 수정하였습니다.");
         location.href = "main.jsp";
      </script>
   </body>
</html>