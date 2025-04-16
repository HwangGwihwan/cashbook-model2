<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	System.out.println("deleteCategory#categoryNo: " + categoryNo);
	
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.deleteCategory(categoryNo);
	
	response.sendRedirect("/cashbook/category/categoryList.jsp");
%>