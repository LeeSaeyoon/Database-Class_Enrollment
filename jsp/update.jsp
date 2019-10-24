<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<head>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/layout.css" />
</head>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>

<div id="containerwrap">
   <div id="container">
      <div id="content" class="login">
         <div class="login_box" align="center">
            <form method="post" action="update_verify.jsp">
               <fieldset class="formLogin">
                  <div>
                     <br> <br>
                     <h2>정보 수정</h2>
                     <br> <br>
                     <table class="inputTable">
                        <%
                           if (session_id == null) {
                        %>
                        <script>
                           alert("로그인이 필요합니다.");
                           location.href = "login.jsp";
                        </script>
                        <%
                           } else {
                              String chk_pwd = (String) request.getParameter("userpw");
                              Statement stmt = null;
                              ResultSet rs = null;
                              String mySQL = null;
                              String cell_name = null;
                              String cell_addr = null;
                              String cell_email = null;
                              String cell_pwd = null;

                              if (session_identity == "student") {
                                 mySQL = "select s_name,s_addr,s_email, s_pw from students where s_id=" + session_id
                                       + "and s_pw ='" + chk_pwd + "'";
                              } else if (session_identity == "professor") {
                                 mySQL = "select p_name,p_email, p_pw from professor where p_id=" + session_id + "and p_pw='"
                                       + chk_pwd + "'";
                              }

                              stmt = myConn.createStatement();
                              rs = stmt.executeQuery(mySQL);

                              if (rs != null) {
                                 if (rs.next()) {
                                    if (session_identity == "student") {
                                       cell_name = "s_name";
                                       cell_addr = "s_addr";
                                       cell_email = "s_email";
                                       cell_pwd = "s_pw";
                                    } else {
                                       cell_name = "p_name";
                                       cell_email = "p_email";
                                       cell_pwd = "p_pw";
                                    }

                                    String addr = null;
                                    String name = rs.getString(cell_name);

                                    if (session_identity == "student") {
                                       addr = rs.getString(cell_addr);
                                    }

                                    String email = rs.getString(cell_email);
                                    String passwd = rs.getString(cell_pwd);
                        %>
                        <tbody>
                           <tr>
                              <%
                                 int id = session_id;
                              %>
                              <td>아이디</td>
                              <td class="blank03"></td>
                              <td class="input"><%=id%> <input type="hidden"
                                 id="userid" name="userid" title="아이디" value="<%=id%>"
                                 class="formText formText_ID" /></td>
                           </tr>
                           <tr>
                              <td colspan="2" class="blank02"></td>
                           </tr>
                           <tr>
                              <td>이름</td>
                              <td class="blank03"></td>
                              <td class="input"><%=name %><input type="hidden" id="username"
                                 name="username" title="이름" value="<%=name%>"
                                 class="formText formText_Name" /></td>
                           </tr>
                           <tr>
                              <td colspan="2" class="blank02"></td>
                           </tr>
                           <tr>
                              <td>비밀번호</td>
                              <td class="blank03"></td>
                              <td class="input"><input type="password" id="userpw"
                                 name="userpw" title="비밀번호"
                                 class="formText formText_Pass_Update" value="<%=passwd%>"
                                 onkeypress="if(event.keyCode=='13'){userLogin();}" /></td>
                           </tr>
                           <tr>
                              <td colspan="2" class="blank02"></td>
                           </tr>
                           
                           <%
                              if (session_identity == "student") {
                           %>
                           <tr>
                              <td>주소</td>
                              <td class="blank03"></td>
                              <td class="input"><input type="text" id="useraddr"
                                 name="useraddr" title="주소" value="<%=addr%>"
                                 class="formText formText_Email" /></td>
                           </tr>
                           <%
                              }
                           %>
                           <tr>
                              <td colspan="2" class="blank02"></td>
                           </tr>
                           <tr>
                              <td>이메일</td>
                              <td class="blank03"></td>
                              <td class="input"><input type="text" id="useremail"
                                 name="useremail" title="이메일" value="<%=email%>"
                                 class="formText formText_Email" /></td>
                           </tr>
                           <tr>
                              <td colspan="2" class="blank02"></td>
                           </tr>
                           <tr>
                              <td colspan="2" class="blank02"></td>
                           </tr>
                           <tr>
                              <td colspan="2" class="blank02"></td>
                           </tr>
                           <tr align="center">
                              <td colspan="3"><input type="submit" value="확인"
                                 class="btnRed03"></td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </fieldset>
               <br> <br> <br> <br> <br> <br> <br>
               <br>
               <%
                  } else {
               %>
               <script>
                  alert("잘못된 비밀번호 입니다.");
                  history.back();
               </script>
               <%
                  }
                     }
                     stmt.close();
                     myConn.close();
                  }
               %>
            </form>
         </div>
      </div>
   </div>
</div>