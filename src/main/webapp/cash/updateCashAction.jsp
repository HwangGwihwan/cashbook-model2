<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	
	System.out.println("updateCashAction#cashNo: " + cashNo);
	System.out.println("updateCashAction#amount: " + amount);
	System.out.println("updateCashAction#memo: " + memo);
	System.out.println("updateCashAction#color: " + color);

	Cash cash = new Cash();
	cash.setCashNo(cashNo);
	cash.setAmount(amount);
	cash.setMemo(memo);
	cash.setColor(color);
	
	CashDao cashDao = new CashDao();
	cashDao.updateCashOne(cash);
	
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo=" + cashNo);
%>
