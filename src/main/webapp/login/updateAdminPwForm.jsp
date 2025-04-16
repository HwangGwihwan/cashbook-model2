<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));

	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 수정</title>
 		<style>
	        /* 기본 스타일 초기화 */
	        body, h1, div, span, input, button {
	            margin: 0;
	            padding: 0;
	            box-sizing: border-box;
	        }
	
	        body {
	            font-family: Arial, sans-serif;
	            background-color: #f4f7fa;
	            display: flex;
	            flex-direction: column;
	            justify-content: center;
	            align-items: center;
	            height: 100vh;
	            margin: 0;
	            color: #333;
	        }
	
	        h1 {
	            font-size: 32px;
	            margin-bottom: 30px;
	            color: #4CAF50;
	            text-align: center;
	        }
	
	        form {
	            background-color: #fff;
	            padding: 30px;
	            border-radius: 8px;
	            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	            width: 100%;
	            max-width: 400px;
	            box-sizing: border-box;
	        }
	
	        div {
	            margin-bottom: 20px;
	            display: flex;
	            flex-direction: column;
	        }
	
	        span {
	            font-size: 16px;
	            margin-bottom: 5px;
	            color: #333;
	        }
	
	        input[type="password"] {
	            padding: 10px;
	            font-size: 16px;
	            border: 1px solid #ccc;
	            border-radius: 4px;
	            outline: none;
	            transition: border-color 0.3s;
	        }
	
	        input[type="password"]:focus {
	            border-color: #4CAF50;
	        }
	
	        button {
	            width: 100%;
	            padding: 12px;
	            font-size: 16px;
	            background-color: #4CAF50;
	            color: #fff;
	            border: none;
	            border-radius: 4px;
	            cursor: pointer;
	            transition: background-color 0.3s;
	        }
	
	        button:hover {
	            background-color: #45a049;
	        }
	
	        button:focus {
	            outline: none;
	        }
	
	        /* 메시지 스타일 */
	        .error {
	            color: red;
	            font-size: 14px;
	            margin-top: 10px;
	        }
    	</style>
	</head>
	<body>
		<h1>비밀번호 수정</h1>
		<form action="/cashbook/login/updateAdminPwAction.jsp" method="post">
			<div>
				<span>현재 비밀번호: </span><input type="password" name="pw" placeholder="현재 비밀번호를 입력하세요">
			</div>
			<div>
				<span>새 비밀번호: </span><input type="password" name="newpw1" placeholder="새 비밀번호를 입력하세요">
			</div>
			<div>
				<span>비밀번호 확인: </span><input type="password" name="newpw2" placeholder="새 비밀번호를 한번 더 입력하세요">
			</div>
			<button type="submit">비밀번호 변경</button>
		</form>
	</body>
</html>