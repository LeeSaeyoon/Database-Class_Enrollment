<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/layout.css" />
</head>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="top.jsp"%>

<div id="containerwrap">
   <div id="container">
      <br> <br> <br>
         <div id="content" class="login" align="center">
            <div class="login_box">
               <form method="post" action="login_verify.jsp" name="loginForm"
                  id="loginForm">
                  <fieldset class="formLogin">
                     <br />
                     
                        <div align="center">
                           <img src="image/sm_gray.png" width=70 height=70/>
                           <table class="inputTable">
                              <tbody>
                                 <tr align="center">
                                    <td class="input"><input type="text" id="userid"
                                       name="userid" title="아이디" placeholder="아이디"
                                       class="formText formText_ID" /></td>
                                 </tr>
                                 <tr>
                                    <td class="blank02"></td>
                                 </tr>
                                 <tr align="center">
                                    <td class="input"><input type="password" id="userpw"
                                       name="userpw" title="비밀번호" placeholder="비밀번호"
                                       class="formText formText_Pass"
                                       onkeypress="if(event.keyCode=='13'){userLogin();}" /></td>
                                 </tr>
                                 <br>
                                 <tr>
                                    <td class="blank02"></td>
                                 </tr>
                                 <tr align="center">
                                    <td class="btn"><input type="submit" value="로그인"
                                       class="btnRed01"></td>
                                 </tr>
                              </tbody>
                           </table>

                        </div>
                     
                  </fieldset>
               </form>
            </div>
         </div>
   </div>
</div>
</div>