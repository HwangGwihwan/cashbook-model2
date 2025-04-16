<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	
	System.out.println("insertCategoryAction#kind: " + kind);
	System.out.println("insertCategoryAction#title: " + title);
	
	Category c = new Category();
	c.setKind(kind);
	c.setTitle(title);
	
	CategoryDao categoryDao = new CategoryDao();
	int check = categoryDao.checkCategory(c);
	
	if (check == 0) { // 중복 없음
		categoryDao.insertCategory(c);
	}
	// 중복 있을 경우에는 삽입x

	response.sendRedirect("/cashbook/category/categoryList.jsp");
%>