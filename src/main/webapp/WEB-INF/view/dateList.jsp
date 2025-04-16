<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Cash"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ArrayList<Cash> cashList = (ArrayList<Cash>)request.getAttribute("cashList");
	int targetYear = (int)request.getAttribute("targetYear");
	int targetMonth = (int)request.getAttribute("targetMonth");
	String date = (String)request.getAttribute("date");
	int incomeSum = 0;
	int expenditureSum = 0;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>날짜별 수입/지출</title>
		<style>
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: #f9f9f9;
			margin: 0;
			padding: 0;
		}
		
		h1 {
			text-align: center;
			margin-top: 60px;
			color: #333;
		}
	
		.top-links {
			position: absolute;
			top: 20px;
			right: 300px;
			display: flex;
			gap: 10px;
		}
	
		.top-links a {
			text-decoration: none;
			color: #fff;
			background-color: #4CAF50;
			padding: 10px 15px;
			border-radius: 4px;
			transition: background-color 0.3s ease;
			font-size: 14px;
		}
	
		.top-links a:hover {
			background-color: #45a049;
		}
	
		table {
			width: 80%;
			margin: 30px auto;
			border-collapse: collapse;
			background-color: #fff;
			box-shadow: 0 4px 8px rgba(0,0,0,0.1);
		}
	
		th, td {
			border: 1px solid #ccc;
			padding: 12px 15px;
			text-align: center;
		}
	
		th {
			background-color: #f2f2f2;
			font-weight: bold;
		}
	
		td {
			color: #333;
		}
	
		tr:hover {
	            background-color: #ddd;
	    }
	       
		.summary-table {
			width: 40%;
			margin: 30px auto;
		}
		
		a {
			text-decoration: none; /* 밑줄 제거 */
			color: inherit; /* 상위 요소에서 상속받기 */
		}
		</style>
	</head>
	<body>
		<h1><%=date%> 내역</h1>
		<div class="top-links">
			<a href="<%=request.getContextPath()%>/insertCash?cashDate=<%=date%>">내역추가</a>
			<a href="<%=request.getContextPath()%>/monthList?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth - 1%>">달력으로</a>
		</div>

		<table>
			<tr>
				<th>수입/지출</th>
				<th>카테고리</th>
				<th>금액</th>
				<th>메모</th>
			</tr>
			<%
				for (Cash c : cashList) {
					if (c.getCategory().getKind().equals("수입")) { // 총 수입
						incomeSum += c.getAmount();
					} else if (c.getCategory().getKind().equals("지출")) { // 총 지출
						expenditureSum += c.getAmount();
					}
			%>
					<tr>
						<td>
							<a href="<%=request.getContextPath()%>/cashOne?cashNo=<%=c.getCashNo()%>"><%=c.getCategory().getKind()%></a>
							
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/cashOne?cashNo=<%=c.getCashNo()%>">
								<%=c.getCategory().getTitle()%>
								<% 
									if (c.getReceit().getFilename() != null) { // 영수증이 있다면
								%>
										📄
								<%
									}
								%>
							</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/cashOne?cashNo=<%=c.getCashNo()%>">
							<%
								DecimalFormat df = new DecimalFormat("###,###");
								String money = df.format(c.getAmount());
							%>
										<%=money%>원
							</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/cashOne?cashNo=<%=c.getCashNo()%>"><%=c.getMemo()%></a>
						</td>
					</tr>
			<%
				}
			%>
		</table>
		
		<table class="summary-table">
			<tr>
				<th>총 수입</th>
				<th>총 지출</th>
			</tr>
			<tr>
				<td>
				<%
					DecimalFormat df = new DecimalFormat("###,###");
					String incomeMoney = df.format(incomeSum);
				%>
							<%=incomeMoney%>원
				</td>
				<td>
				<%
					String expenditureMoney = df.format(expenditureSum);
				%>
							<%=expenditureMoney%>원
				</td>
			</tr>
		</table>
	</body>
</html>