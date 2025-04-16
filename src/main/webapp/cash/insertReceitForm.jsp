<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	System.out.println("insertReceitForm#cashNo: " + cashNo);

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>영수증 등록</title>
		<style>
	        body {
	            font-family: 'Segoe UI', sans-serif;
	            background-color: #f7f9fc;
	            display: flex;
	            justify-content: center;
	            align-items: center;
	            height: 100vh;
	        }
	
	        form {
	            background-color: white;
	            padding: 30px;
	            border-radius: 12px;
	            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	            width: 350px;
	            display: flex;
	            flex-direction: column;
	            gap: 15px;
	        }
	
	        div {
	            font-size: 16px;
	            display: flex;
	            flex-direction: column;
	        }
	
	        input[type="file"] {
	            margin-top: 6px;
	        }
	
	        button {
	            background-color: #22c55e;
	            color: white;
	            border: none;
	            padding: 12px;
	            font-size: 16px;
	            border-radius: 8px;
	            cursor: pointer;
	            transition: background-color 0.3s;
	        }
	
	        button:hover {
	            background-color: #16a34a;
	        }
	
	        .msg {
	            background-color: #fee2e2;
	            color: #b91c1c;
	            padding: 10px;
	            border-radius: 8px;
	            margin-bottom: 15px;
	            font-weight: bold;
	            text-align: center;
	        }
	    </style>
	</head>
	<body>
		<form action="/cashbook/cash/insertReceitAction.jsp" method="post" enctype="multipart/form-data">
	        <input type="hidden" name="cashNo" value="<%=cashNo%>">
	        
	        <% 
	        	if (request.getParameter("msg") != null) {
	        %>
	            	<div class="msg">png 파일만 올릴 수 있습니다</div>
	        <% 
	        	} 
	        %>
	
	        <div>
	            <label>영수증</label>
	            <input type="file" name="imageFile">
	        </div>
	        <button type="submit">영수증 등록</button>
	    </form>
	</body>
</html>