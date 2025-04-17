<%@ page import="dto.Receit"%>
<%@ page import="dto.Cash"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int cashNo = (int)request.getAttribute("cashNo");
	Cash cash = (Cash)request.getAttribute("cash");
	Receit receit = (Receit)request.getAttribute("receit");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>상세 내역</title>
		<style>
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: #f8f9fa;
			color: #333;
			padding: 40px;
			text-align: center;
		}

		h1 {
			margin-bottom: 30px;
			font-size: 2em;
			color: #343a40;
		}

		table {
			margin: 0 auto;
			width: 60%;
			border-collapse: collapse;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			background-color: #fff;
			border-radius: 8px;
			overflow: hidden;
			margin-bottom: 24px;
		}

		th, td {
			padding: 16px 20px;
			border-bottom: 1px solid #dee2e6;
			text-align: left;
		}

		th {
			background-color: #e9ecef;
			font-weight: bold;
		}

		tr:last-child td {
			border-bottom: none;
		}

		.button-group {
			margin-top: 30px;
		}

		a {
			display: inline-block;
			margin: 0 10px;
			padding: 10px 16px;
			background-color: #28a745;
			color: white;
			border-radius: 6px;
			text-decoration: none;
			transition: background-color 0.3s ease;
		}

		a:hover {
			background-color: #218838;
		}

		.receit-section {
			margin-top: 10px;
			color: #6c757d; /* 흐린 회색 */
		}

		.receit-section img {
			margin-top: 10px;
			width: 300px;
			border-radius: 6px;
			box-shadow: 0 4px 10px rgba(0,0,0,0.1);
		}
	</style>
	</head>
	<body>
		<h1>상세 내역</h1>
		<table>
			<tr>
				<th>날짜</th>
				<td><%=cash.getCash_date()%></td>
			</tr>
			<tr>
				<th>수입/지출</th>
				<td><%=cash.getCategory().getKind()%></td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td><%=cash.getCategory().getTitle()%></td>
			</tr>
			<tr>
				<th>금액</th>
				<td>
				<%
					DecimalFormat df = new DecimalFormat("###,###");
					String money = df.format(cash.getAmount());
				%>
					<%=money%>원
				</td>
			</tr>
			<tr>
				<th>메모</th>
				<td><%=cash.getMemo()%></td>
			</tr>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/dateList?date=<%=cash.getCash_date()%>">목록으로</a>
			<a href="<%=request.getContextPath()%>/updateCash?cashNo=<%=cashNo%>">수정</a>
			<a href="<%=request.getContextPath()%>/deleteCash?cashNo=<%=cashNo%>&cashDate=<%=cash.getCash_date()%>">삭제</a>
			<%
				if (receit == null) { // 영수증이 없을때만 영수증 등록 뜨게
			%>
					<a href="<%=request.getContextPath()%>/insertReceit?cashNo=<%=cashNo%>">영수증 등록</a>
			<%
				} else { // 영수증이 있을때는 영수증 삭제만 뜨게
			%>
					<a href="<%=request.getContextPath()%>/deleteReceit?cashNo=<%=cashNo%>&filename=<%=receit.getFilename()%>">영수증 삭제</a>
			<%	
				}
			%>
		</div>
		
		<div class="receit-section">
			<p>영수증</p>
			<%
				if (receit == null) {
			%>
					<p>영수증 이미지를 첨부해주세요</p>
			<%
				} else {
			%>
					<img src="<%=request.getContextPath()%>/upload/<%=receit.getFilename()%>">
			<%
				}
			%>
		</div>
	</body>
</html>