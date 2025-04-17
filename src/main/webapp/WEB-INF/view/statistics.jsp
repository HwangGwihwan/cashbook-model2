<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int year = (int)request.getAttribute("year");
	ArrayList<HashMap<String, Object>> totalList = (ArrayList<HashMap<String, Object>>)request.getAttribute("totalList");
	ArrayList<HashMap<String, Object>> yearTotalList = (ArrayList<HashMap<String, Object>>)request.getAttribute("yearTotalList");
	ArrayList<HashMap<String, Object>> monthTotalList = (ArrayList<HashMap<String, Object>>)request.getAttribute("monthTotalList");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>수입/지출 통계</title>
		<style>
			* {
				box-sizing: border-box;
				font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
				margin: 0;
				padding: 0;
			}
		
			body {
				background-color: #f8f9fa;
				padding: 40px;
				color: #333;
			}
		
			h1 {
				margin-bottom: 30px;
				text-align: center;
				color: #2d6a4f;
			}
		
			form {
				margin-bottom: 40px;
				display: flex;
				justify-content: center;
				gap: 10px;
				align-items: center;
			}
		
			select, button {
				padding: 8px 12px;
				font-size: 14px;
				border-radius: 6px;
				border: 1px solid #ccc;
			}
		
			button {
				background-color: #2d6a4f;
				color: white;
				border: none;
				cursor: pointer;
			}
		
			button:hover {
				background-color: #1b4332;
			}
		
			table {
				width: 100%;
				border-collapse: collapse;
				margin-bottom: 40px;
				background-color: white;
				box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
				border-radius: 8px;
				overflow: hidden;
			}
		
			th {
				background-color: #95d5b2;
				color: #000;
				padding: 12px;
				text-align: center;
				font-weight: 600;
			}
		
			td {
				padding: 10px;
				text-align: center;
				border-top: 1px solid #dee2e6;
			}
		
			tr:nth-child(even) td {
				background-color: #f1f3f5;
			}
		
			/* 📊 월별 수입/지출 통계 테이블 가로 배치용 */
			.monthly-section {
				display: flex;
				justify-content: space-between;
				gap: 20px;
				margin-bottom: 40px;
			}
		
			.monthly-table-wrapper {
				width: 49%;
			}
		
			.monthly-table {
				width: 100%;
				table-layout: fixed;
			}
			
			.calendar-link {
				position: absolute;
				top: 60px;
				left: 30px;
				text-decoration: none;
				color: #2d6a4f;
				font-weight: bold;
				font-size: 16px;
				background-color: #d8f3dc;
				padding: 6px 12px;
				border-radius: 6px;
				transition: background-color 0.2s, color 0.2s;
				box-shadow: 0 2px 6px rgba(0,0,0,0.05);
			}
		
			.calendar-link:hover {
				background-color: #95d5b2;
				color: #081c15;
			}
		</style>
	</head>
	<body>
		<h1>수입/지출 통계</h1>
		<a href="<%=request.getContextPath()%>/monthList" class="calendar-link">달력으로</a>
		<form action="<%=request.getContextPath()%>/statistics" method="get">
			<span>연도</span>
			<select name="year">
				<option value="2021" <%if(year == 2021){%> selected <%}%>>2021</option>
				<option value="2022" <%if(year == 2022){%> selected <%}%>>2022</option>
				<option value="2023" <%if(year == 2023){%> selected <%}%>>2023</option>
				<option value="2024" <%if(year == 2024){%> selected <%}%>>2024</option>
				<option value="2025" <%if(year == 2025){%> selected <%}%>>2025</option>
			</select>
			<button type="submit">선택</button>
		</form>

		<table>
			<tr>
				<th colspan="3">전체 수입/지출 통계</th>
			</tr>
			<tr>
				<th>종류</th>
				<th>건수</th>
				<th>총액</th>
			</tr>
			<%
				for (HashMap<String, Object> map : totalList) {
					int sum = (int)(map.get("sum"));
					ArrayList<String> list = new ArrayList<>();
			%>
					<tr>
						<td><%=map.get("kind")%></td>
						<td><%=map.get("count")%></td>
						<td>
						<%
							DecimalFormat df = new DecimalFormat("###,###");
							String money = df.format(map.get("sum"));
						%>
							<%=money%>원
						</td>
					</tr>
			<%
				}
			%>
		</table>

		<div class="monthly-section">
			<div class="monthly-table-wrapper">
				<table class="monthly-table">
					<tr>
						<th colspan="3"><%=year%>년 월별 수입 통계
					</tr>
					<tr>
						<th>월</th>
						<th>건수</th>
						<th>총액</th>
					</tr>
					<%
						for (HashMap<String, Object> map : monthTotalList) {
							if (map.get("kind").equals("수입")) {
					%>
								<tr>
									<td><%=map.get("month")%></td>
									<td><%=map.get("count")%></td>
									<td>
									<%
										DecimalFormat df = new DecimalFormat("###,###");
										String money = df.format(map.get("sum"));
									%>
										<%=money%>원
									</td>
								</tr>
					<%			
							}
						}
					%>
				</table>
			</div>
		
			<div class="monthly-table-wrapper">
				<table>
					<tr>
						<th colspan="3"><%=year%>년 월별 지출 통계
					</tr>
					<tr>
						<th>월</th>
						<th>건수</th>
						<th>총액</th>
					</tr>
					<%
						for (HashMap<String, Object> map : monthTotalList) {
							if (map.get("kind").equals("지출")) {
					%>
								<tr>
									<td><%=map.get("month")%></td>
									<td><%=map.get("count")%></td>
									<td>
									<%
										DecimalFormat df = new DecimalFormat("###,###");
										String money = df.format(map.get("sum"));
									%>
										<%=money%>원
									</td>
								</tr>
					<%			
							}
						}
					%>
				</table>	
			</div>
		</div>
		
		<table>
			<tr>
				<th colspan="3"><%=year%>년 수입/지출 통계
			</tr>
			<tr>
				<th>종류</th>
				<th>건수</th>
				<th>총액</th>
			</tr>
			<%
				for (HashMap<String, Object> map : yearTotalList) {
			%>
					<tr>
						<td><%=map.get("kind")%></td>
						<td><%=map.get("count")%></td>
						<td>
						<%
							DecimalFormat df = new DecimalFormat("###,###");
							String money = df.format(map.get("sum"));
						%>
							<%=money%>원
						</td>
					</tr>
			<%
				}
			%>
		</table>
	</body>
</html>