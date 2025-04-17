<%@ page import="dto.Cash"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int cashNo = (int)request.getAttribute("cashNo");
	Cash cash = (Cash)request.getAttribute("cash");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내역 수정</title>
		<style>
			body {
				font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
				background-color: #f5f6fa;
				color: #333;
				display: flex;
				justify-content: center;
				align-items: center;
				height: 100vh;
				margin: 0;
			}
	
			.container {
				background-color: #ffffff;
				padding: 40px 50px;
				border-radius: 12px;
				box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
				width: 400px;
			}
	
			h1 {
				text-align: center;
				margin-bottom: 30px;
				color: #2f3640;
				font-size: 1.8em;
			}
	
			label {
				display: block;
				margin-bottom: 8px;
				font-weight: bold;
			}
	
			input[type="text"],
			input[type="date"] {
				width: 100%;
				padding: 10px 12px;
				margin-bottom: 20px;
				border: 1px solid #ccc;
				border-radius: 6px;
				font-size: 1em;
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
			
			.button-group {
				display: flex;
				justify-content: space-between;
				gap: 10px;
				margin-top: 10px;
			}
	
			button,
			.cancel-button {
				width: 100%;
				padding: 12px;
				border: none;
				border-radius: 6px;
				font-size: 1em;
				cursor: pointer;
				text-align: center;
			}
	
			button {
				background-color: #28a745;
				color: white;
			}
	
			button:hover {
				background-color: #218838;
			}
	
			.cancel-button {
				background-color: #e0e0e0;
				color: #333;
				text-decoration: none;
				line-height: 38px;
			}
	
			.cancel-button:hover {
				background-color: #ccc;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<h1>내역 수정</h1>
			<form action="<%=request.getContextPath()%>/updateCash" method="post">
				<input type="hidden" name="cashNo" value="<%=cashNo%>">
				<label>날짜</label>
				<input type="date" name="cashDate" value="<%=cash.getCash_date()%>" readonly>
			
				<label>수입/지출</label>
				<input type="text" name="kind" value="<%=cash.getCategory().getKind()%>" readonly>
			
				<label>카테고리</label>
				<input type="text" name="category" value="<%=cash.getCategory().getTitle()%>" readonly>
			
				<label>금액</label>
				<input type="text" name="amount" value="<%=cash.getAmount()%>">
			
				<label>메모</label>
				<input type="text" name="memo" value="<%=cash.getMemo()%>">
				
				<label>색상</label>
				<input type="color" name="color" value="<%=cash.getColor()%>">
				
				<div class="button-group">
					<button type="submit">수정</button>
					<a href="<%=request.getContextPath()%>/cashOne?cashNo=<%=cashNo%>" class="cancel-button">취소</a>
				</div>
			</form>
		</div>
	</body>
</html>