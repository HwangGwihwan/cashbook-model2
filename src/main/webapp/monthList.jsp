<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));

	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	Calendar calendar = Calendar.getInstance();
	calendar.set(Calendar.DATE, 1);
	
	if ((request.getParameter("targetMonth") != null) && (request.getParameter("targetYear") != null)) {
		calendar.set(Calendar.YEAR, Integer.parseInt(request.getParameter("targetYear")));
		calendar.set(Calendar.MONTH, Integer.parseInt(request.getParameter("targetMonth")));
	}
	
	System.out.println("monthList#date: " + calendar.get(Calendar.DATE));
	System.out.println("monthList#month: " + (calendar.get(Calendar.MONTH) + 1));
	System.out.println("monthList#year: " + calendar.get(Calendar.YEAR));
	
	// 마지막 날짜
	int lastDate = calendar.getActualMaximum(Calendar.DATE);
	
	// 1일의 요일 -> 시작 공백
	int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
	int startBlank = dayOfWeek - 1;
	// 뒤 공백
	int endBlank = 0;
	// totalCell은 7의 배수
	int totalCell = startBlank + lastDate + endBlank;
	if (totalCell % 7 != 0) {
		endBlank = 7 - (totalCell % 7);
		totalCell += endBlank;
	}
	
	// 2025-04-10 형태로 만들기
	String date = "";
	date += calendar.get(Calendar.YEAR);
	date += "-";
	if ((calendar.get(Calendar.MONTH) + 1) < 10) {
		date += "0";
		date += (calendar.get(Calendar.MONTH) + 1);
	} else {
		date += (calendar.get(Calendar.MONTH) + 1);
	}
	date += "-";

	CashDao cashDao = new CashDao();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>달력</title>
		<style>
			body {
				font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
				background-color: #f4f4f4;
				text-align: center;
				margin: 20px;
				position: relative;
			}
	
			h1 {
				color: #333;
				margin-bottom: 20px;
			}
			
			.category-link {
			    position: absolute;
			    top: 20px;
			    left: 20px;
			}
			
			.category-link a {
			    font-size: 16px;
			    color: #4CAF50;
			    text-decoration: none;
			    padding: 10px 20px;
			    border-radius: 4px;
			    border: 1px solid #4CAF50;
			    background-color: #fff;
			    transition: all 0.3s ease;
			}
			
			.category-link a:hover {
			    background-color: #4CAF50;
			    color: white;
			}
			
			.top-links {
	            position: absolute;
	            top: 20px;
	            right: 20px;
	            display: flex;
	            gap: 20px;
	        }
	
	        .top-links a {
	            font-size: 16px;
	            color: #fff;
	            background-color: #4CAF50;
	            padding: 10px 20px;
	            border-radius: 4px;
	            text-decoration: none;
	            transition: background-color 0.3s;
	        }
	
	        .top-links a:hover {
	            background-color: #45a049;
	        }
	        
	        .calendar-nav {
			    width: 95%;
			    margin: 40px auto 0;
			    display: flex;
			    justify-content: space-between;
			    align-items: center;
			    position: relative;
			}
				        
			.button-nav {
				padding: 10px 20px;
			    background-color: #007bff;
			    color: white;
			    border: none;
			    border-radius: 8px;
			    font-size: 16px;
			    text-decoration: none;
			    transition: background-color 0.3s;
			}
	
			.button-nav:hover {
				background-color: #0056b3;
			}
		
			.button-nav.prev {
			    margin-left: 20px;
			}
			
			.button-nav.next {
			    margin-right: 20px;
			}
			
			.link {
			  text-decoration: none;
			  color: inherit;
			}
			
			.link:hover {
			  text-decoration: none;
			  color: inherit;
			}

			table {
				margin: 0 auto;
				margin-top: 40px;
				border-collapse: collapse;
				text-align: center;
				width: 95%;
				background-color: #fff;
				box-shadow: 0 4px 8px rgba(0,0,0,0.1);
			}
	
			th, td {
				border: 1px solid #ccc;
				padding: 15px;
				width: 14.28%;
				font-size: 16px;
			}
	
			th {
				background-color: #f0f0f0;
				color: #333;

				heigth: 40px;
			}
	
			td {
				background-color: #fafafa;
				height: 70px;
			}
		    
		    td:hover {
	            background-color: #ddd;
	        }
	         
			th:nth-child(1) { color: red; }    /* 일요일 */
			th:nth-child(7) { color: blue; }   /* 토요일 */
		</style>
	</head>
	<body>
		<h1>		
			<span style="font-size: 24px; font-weight: bold;"><%=calendar.get(Calendar.YEAR)%>년 <%=calendar.get(Calendar.MONTH) + 1%>월</span>
		</h1>
		<div class="category-link">
			<a href="/cashbook/category/categoryList.jsp">카테고리</a>	
			<a href="/cashbook/statistics.jsp">통계자료</a>
		</div>
		<div class="top-links">
	        <a href="/cashbook/login/logout.jsp">로그아웃</a>
	        <a href="/cashbook/login/updateAdminPwForm.jsp">비밀번호 수정</a>
		</div>
		<table>
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
			<tr>
			<%
				for (int i = 1; i <= totalCell; i++) {
			%>
					<td>
					<%
						int d = i - startBlank;
						if (d > 0 && d <= lastDate) {
							String tmp = date;
							if (d < 10) {
								date += "0";
								date += d;
							} else {
								date += d;
							}
							ArrayList<Cash> list = cashDao.selectCashByDate(date);
					%>
							<a href="/cashbook/dateList.jsp?date=<%=date%>" class="link"><%=d%></a><br>
					<%
							date = tmp; // 날짜가 빠진 상태로 다시 되돌림
							for (Cash c : list) {
					%>
								<span style="color:<%=c.getColor()%>;">
									[<%=c.getCategory().getKind()%>]
									<%=c.getCategory().getTitle()%> - 
									<%
										DecimalFormat df = new DecimalFormat("###,###");
										String money = df.format(c.getAmount());
									%>
										<%=money%>
									<br>
								</span>
					<%
							}

						} else {
					%>
							&nbsp;
					<%
						}
					%>
					</td>
			<%
					if (i % 7 == 0) {
			%>
						</tr><tr>
			<%
					}
				}
			%>
			</tr>
		</table>
		<div class="calendar-nav">
		<%
			if (calendar.get(Calendar.MONTH) == 0) { // 1월에서 이전달을 누를경우 전년도 12월이 나오도록 함
		%>
				<a class="button-nav prev" href="/cashbook/monthList.jsp?targetMonth=11&targetYear=<%=calendar.get(Calendar.YEAR) - 1%>">이전달</a>
		<%
			} else {
		%>
				<a class="button-nav prev" href="/cashbook/monthList.jsp?targetMonth=<%=calendar.get(Calendar.MONTH) - 1%>&targetYear=<%=calendar.get(Calendar.YEAR)%>">이전달</a>
		<%
			}
		%>
		
		<%
			if (calendar.get(Calendar.MONTH) == 11) { // 12월에서 다음달을 누를경우 다음년도 1월이 나오도록 함
		%>
				<a class="button-nav next" href="/cashbook/monthList.jsp?targetMonth=0&targetYear=<%=calendar.get(Calendar.YEAR) + 1%>">다음달</a>
		<%
			} else {
		%>
				<a class="button-nav next" href="/cashbook/monthList.jsp?targetMonth=<%=calendar.get(Calendar.MONTH) + 1%>&targetYear=<%=calendar.get(Calendar.YEAR)%>">다음달</a>
		<%
			}
		%>
		</div>
	</body>
</html>