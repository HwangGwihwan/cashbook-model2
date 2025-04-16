<%@ page import="model.*"%>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String filename = request.getParameter("filename");
	
	System.out.println("deleteReceit#cashNo: " + cashNo);
	System.out.println("deleteReceit#filename: " + filename);
	
	// db삭제
	ReceitDao receitDao = new ReceitDao();
	receitDao.deleteReceitOne(cashNo);
	
	// 파일 삭제
	String path = request.getServletContext().getRealPath("upload");
	File file = new File(path, filename); // new File 경로에 파일이 없으면 빈파일을 생성
	if (file.exists()) { // 빈파일이 아니라면
		file.delete();
	}
	
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo=" + cashNo);
%>
