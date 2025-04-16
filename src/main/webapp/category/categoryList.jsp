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
	
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(8);
	
	CategoryDao categoryDao = new CategoryDao();
	int totalRow = categoryDao.totalRow();
	int lastPage = p.getLastPage(totalRow);
	ArrayList<Category> list = categoryDao.selectCategoryList(p);
%>

<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <title>카테고리목록</title>
	    <style>
	        /* 기본 스타일 초기화 */
	        body, h1, div, a, table, th, td {
	            margin: 0;
	            padding: 0;
	            box-sizing: border-box;
	        }
	
	        body {
	            font-family: Arial, sans-serif;
	            background-color: #f4f7fa;
	            color: #333;
	            display: flex;
	            flex-direction: column;
	            align-items: center;
	            height: 100vh;
	            justify-content: flex-start;
	            padding: 20px;
	        }
	
	        h1 {
	            font-size: 32px;
	            margin-bottom: 20px;
	            color: #4CAF50;
	            text-align: center;
	        }

			.category-actions {
			    position: absolute;
			    top: 20px;
			    left: 20px;
			    display: flex;
			    gap: 10px;
			}

	        /* 카테고리 추가 링크 왼쪽 위 배치 */
	        .category-link {
	            font-size: 16px;
	            color: #4CAF50;
	            text-decoration: none;
	            padding: 10px 20px;
	            border-radius: 4px;
	            background-color: #fff;
	            border: 1px solid #4CAF50;
	            transition: background-color 0.3s, color 0.3s;
	        }
	
	        .category-link:hover {
	            background-color: #4CAF50;
	            color: white;
	        }
	        
			.calendar-link {
			    font-size: 16px;
			    color: #4CAF50;
			    text-decoration: none;
			    padding: 10px 20px;
			    border-radius: 4px;
			    background-color: #fff;
			    border: 1px solid #4CAF50;
			    transition: background-color 0.3s, color 0.3s;
			}
			
			.calendar-link:hover {
			    background-color: #4CAF50;
			    color: white;
			}
			
	        /* 로그아웃, 비밀번호 수정 링크 오른쪽 위 배치 */
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
	
	        /* 테이블 스타일 */
	        table {
	            width: 80%;
	            max-width: 1000px;
	            margin-top: 60px; /* 테이블을 화면 중앙에 위치 */
	            border-collapse: collapse;
	            text-align: center;
	        }
	
	        th, td {
	            padding: 12px;
	            border: 1px solid #ccc;
	        }
	
	        th {
	            background-color: #4CAF50;
	            color: white;
	        }
	
	        tr:nth-child(even) {
	            background-color: #f2f2f2;
	        }
	
	        tr:hover {
	            background-color: #ddd;
	        }
	        
	        /* 각 열 너비 고정 */
			th:nth-child(1), td:nth-child(1) { width: 80px; }     /* 번호 */
			th:nth-child(2), td:nth-child(2) { width: 120px; }    /* 수입/지출 */
			th:nth-child(3), td:nth-child(3) { width: 200px; }    /* 분류 */
			th:nth-child(4), td:nth-child(4) { width: 100px; }    /* 수정 */
			th:nth-child(5), td:nth-child(5) { width: 120px; }    /* 삭제 */
			
			.pagination {
			    margin-top: 20px;
			    display: flex;
			    justify-content: center;
			    align-items: center;
			    gap: 10px; /* 버튼 사이 간격 */
			}

	         /* 이전/다음 버튼 스타일 */
	        .pagination a{
	            font-size: 16px;
	            padding: 10px 20px;
	            margin-top: 20px;
	            display: flex;
			    justify-content: center;
			    align-items: center;
	            border: 1px solid #4CAF50;
	            border-radius: 4px;
	            background-color: #fff;
	            color: #4CAF50;
	            transition: background-color 0.3s, color 0.3s;
	        }
	
	        .pagination a:hover {
	            background-color: #4CAF50;
	            color: white;
	        }
	        
	        .pagination .disabled {
			    pointer-events: none;  /* 클릭 방지 */
			    background-color: #e0e0e0;
			    color: #999;
			    border: 1px solid #ccc;
			    cursor: not-allowed;
			}
			
	        /* 링크 스타일: 기본적으로 밑줄 없애기 */
	        a {
	            text-decoration: none; /* 기본 밑줄 제거 */
	            color: inherit; /* 링크 색상은 부모 요소의 색상 사용 */
	        }
	    </style>
	</head>
	<body>
	    <h1>카테고리목록</h1>
	   		<div class="category-actions">
	   			<a href="/cashbook/category/insertCategoryForm.jsp" class="category-link">카테고리 추가</a>
	    		<a href="/cashbook/monthList.jsp" class="calendar-link">달력</a>
	   		</div>
		    <div class="top-links">
		        <a href="/cashbook/login/logout.jsp">로그아웃</a>
		        <a href="/cashbook/login/updateAdminPwForm.jsp">비밀번호 수정</a>
		    </div>
	    <table>
	    	<tr>
	    		<th>번호</th>
	    		<th>수입/지출</th>
	    		<th>카테고리</th>
	    		<th>수정</th>
	    		<th>삭제</th>
	    	</tr>
	    	<%
	    		for (Category c : list) {
	    	%>
	    			<tr>
	    				<td><%=c.getCateoryNo()%></td>
	    				<td><%=c.getKind()%></td>
	    				<td><%=c.getTitle()%></td>
	    				<td><a href="/cashbook/category/updateCategoryTitleForm.jsp?categoryNo=<%=c.getCateoryNo()%>">수정</a></td>
	    				<td>
	    				<% 
	    					if(c.getCount() > 0) { // cash가 있음 -> 삭제불가
	    				%>
	    						삭제 불가
	    				<%
	    				} else {
	    				%>
	    						<a href="/cashbook/category/deleteCategory.jsp?categoryNo=<%=c.getCateoryNo()%>">삭제</a>
	    				<%
	    				}
	    				%>
	    				</td>
	    			</tr>
	    	<%
	    		}
	    	%>
	    </table>
	    
	    <!-- 페이징 -->
	    <div class="pagination">
		    <%
				if (currentPage > 1) {
			%>
					<a href='/cashbook/category/categoryList.jsp?currentPage=<%=currentPage - 1%>'>이전</a>
			<%
				} else {
			%>
					<a class="disabled">이전</a>
			<%
				}
			
				if (currentPage < lastPage) {
			%>
					<a href='/cashbook/category/categoryList.jsp?currentPage=<%=currentPage + 1%>'>다음</a>
			<%
				} else {
			%>
					<a class="disabled">다음</a>
			<%
				}
			%>
		</div>
	</body>
</html>