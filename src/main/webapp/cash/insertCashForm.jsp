<%@ page import="java.util.ArrayList"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	// dateList.jsp -> 수입/지출 입력(String cashDate) ->
	String cashDate = request.getParameter("cashDate");
	// insertCashForm.jsp -> kind 선택(String kind)
	String kind = request.getParameter("kind");
	
	System.out.println("insertCashForm#cashDate: " + cashDate);
	System.out.println("insertCashForm#kind: " + kind);
	
	
	ArrayList<Category> list = null;
	
	if (kind != null) { // insertCashForm.jsp에서 kind선택 후 재요청
		// DB : 선택된 kind의 title 목록
		CategoryDao categoryDao = new CategoryDao();
		list = categoryDao.selectCategoryListByKind(kind);
	}
%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내역추가</title>
		<style>
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: #f7f9fc;
			margin: 0;
			padding: 20px;
			display: flex;
			flex-direction: column;
			align-items: center;
		}
	
		h1 {
			font-size: 20px;
			color: #333;
			margin: 15px 0 10px;
		}

		form {
			background-color: #fff;
			width: 90%;
			max-width: 500px;
			margin-bottom: 20px;
			padding: 20px;
			border-radius: 10px;
			box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		}

		label {
			font-size: 14px;
			margin-bottom: 5px;
			display: block;
		}

		select, input[type="text"], input[type="date"] {
			width: 100%;
			padding: 8px;
			margin-bottom: 12px;
			border: 1px solid #ccc;
			border-radius: 5px;
			font-size: 14px;
			box-sizing: border-box;
		}
		
		input[type="color"] {
			width: 100%;
			height: 20px;
			padding: 0;
			border: 1px solid #ccc;
			border-radius: 10px;
			cursor: pointer;
			box-shadow: inset 0 0 4px rgba(0, 0, 0, 0.1);
		}

		button {
			background-color: #4CAF50;
			color: white;
			padding: 10px 15px;
			border: none;
			border-radius: 5px;
			cursor: pointer;
			font-size: 14px;
			width: 100%;
		}

		button:hover {
			background-color: #45a049;
		}

		hr {
			width: 100%;
			max-width: 500px;
			margin: 20px auto;
			border: none;
			border-top: 1px solid #ddd;
		}
		</style>
	</head>
	<body>
		<h1>수입/지출 선택</h1>
		<form action="/cashbook/cash/insertCashForm.jsp" method="post">
			<input type="hidden" name="cashDate" value="<%=cashDate%>">
			
			<label for="kind">수입/지출</label>
			<select name="kind">
				<option value="">:::선택:::</option>
				<option value="수입" <%if (kind != null && kind.equals("수입")){%> selected <%}%>>수입</option>
				<option value="지출" <%if (kind != null && kind.equals("지출")){%> selected <%}%>>지출</option>
			</select>
			
			<button type="submit">수입/지출 선택</button>
		</form>
		
		<hr>
		
		<h1>내역 추가</h1>
		<form action="/cashbook/cash/insertCashAction.jsp" method="post">
			<label for="cashDate">날짜</label>
			<input type="date" name="cashDate" id="cashDate" value="<%=cashDate%>" readonly><br>
			
			<label for="categoryNo">카테고리</label>
			<select name="categoryNo" id="categoryNo">
			<%
				if (list != null) {
					for (Category c : list) {	
			%>
				<option value="<%=c.getCateoryNo()%>"><%=c.getTitle()%></option>
			
			<%
					}
				}
			%>
			</select>
			
			<label for="amount">금액</label>
			<input type="text" name="amount" id="amount">
			
			<label for="memo">메모</label>
			<input type="text" name="memo" id="memo">

			<label for="color">색상</label>
			<input type="color" name="color" id="color">
			
			<button type="submit">추가</button>
		</form>
	</body>
</html>