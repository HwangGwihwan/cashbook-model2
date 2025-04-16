<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	String cashDate = request.getParameter("cashDate");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	
	System.out.println("insertCashAction#cashDate: " + cashDate);
	System.out.println("insertCashAction#categoryNo: " + categoryNo);
	System.out.println("insertCashAction#amount: " + amount);
	System.out.println("insertCashAction#memo: " + memo);
	System.out.println("insertCashAction#color: " + color);
	
	Cash cash = new Cash();
	cash.setCategoryNo(categoryNo);
	cash.setCash_date(cashDate);
	cash.setAmount(amount);
	cash.setMemo(memo);
	cash.setColor(color);
	
	CashDao cashDao = new CashDao();
	cashDao.insertCash(cash);
	
	response.sendRedirect("/cashbook/dateList.jsp?date=" + cashDate);
%>
