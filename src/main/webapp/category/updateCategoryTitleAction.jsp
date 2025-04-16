<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	
	System.out.println("updateCategoryAction#categoryNo: " + categoryNo);
	System.out.println("updateCategoryAction#kind: " + kind);
	System.out.println("udpateCategoryAction#title: " + title);
	
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.updateCategoryTitle(categoryNo, title);
	
	response.sendRedirect("/cashbook/category/categoryList.jsp");
%>