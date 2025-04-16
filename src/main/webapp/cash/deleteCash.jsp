<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");
	
	System.out.println("deleteCash#cashNo: " + cashNo);
	System.out.println("deleteCash#cashDate: " + cashDate);
	
	CashDao cashDao = new CashDao();
	cashDao.deleteCashOne(cashNo);
	
	response.sendRedirect("/cashbook/dateList.jsp?date=" + cashDate);
%>