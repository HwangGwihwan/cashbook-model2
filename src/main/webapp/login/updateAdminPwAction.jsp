<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}

	String pw = request.getParameter("pw");
	String newpw1 = request.getParameter("newpw1");
	String newpw2 = request.getParameter("newpw2");
	
	System.out.println("updateAdminPwAction#pw: " + pw);
	System.out.println("updateAdminPwAction#newpw1: " + newpw1);
	System.out.println("updateAdminPwAction#newpw2: " + newpw2);
	
	if (!newpw1.equals(newpw2)) { // 바꾼 비밀번호 확인이 맞지 않음
		response.sendRedirect("/cashbook/login/updateAdminPwForm.jsp");
		return;
	}
	
	AdminDao adminDao = new AdminDao();
	int row = adminDao.updateAdminPw(pw, newpw1);
	
	if (row == 0) { // 비밀번호 변경 실패
		response.sendRedirect("/cashbook/login/updateAdminPwForm.jsp");
	} else { // 비밀번호 변경 성공
		response.sendRedirect("/cashbook/login/logout.jsp");
	}
%>