<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pw = request.getParameter("pw");
	System.out.println("loginAction#pw: " + pw);
	
	AdminDao adminDao = new AdminDao();
	if (adminDao.login(pw)) { // 로그인 성공
		System.out.println("로그인 성공");
		session.setAttribute("login", "ok");
		response.sendRedirect("/cashbook/category/categoryList.jsp");
	} else { // 로그인 실패
		System.out.println("로그인 실패");
		response.sendRedirect("/cashbook/login/loginForm.jsp");
	}
%>