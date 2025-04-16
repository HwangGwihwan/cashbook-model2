<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <title>로그인</title>
	    <style>
	        /* Reset some default styles */
	        body, h1, form, div {
	            margin: 0;
	            padding: 0;
	            box-sizing: border-box;
	        }
	
	        body {
	            font-family: Arial, sans-serif;
	            background-color: #f4f7fa;
	            display: flex;
	            justify-content: center;
	            align-items: center;
	            flex-direction: column;  /* 수직 방향으로 정렬 */
	            height: 100vh;
	            margin: 0;
	        }
	
	        h1 {
	            font-size: 24px;
	            margin-bottom: 20px;
	            color: #333;
	        }
	
	        form {
	            background-color: #fff;
	            padding: 20px;
	            border-radius: 8px;
	            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	            width: 300px;
	            text-align: center;
	        }
	
	        div {
	            margin-bottom: 15px;
	        }
	
	        input[type="password"] {
	        	width: 100%;
			    height: 44px;
			    padding: 0 10px;
			    font-size: 16px;
			    border: 1px solid #ccc;
			    border-radius: 4px;
			    outline: none;
			    transition: border-color 0.3s;
			    box-sizing: border-box;
	        }
	
	        input[type="password"]:focus {
	            border-color: #4CAF50;
	        }
	
	        button {
	            width: 100%;
	            padding: 10px;
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
	
	        .error {
	            color: red;
	            font-size: 14px;
	            margin-top: 10px;
	        }
	    </style>
	</head>
	<body>
	    <h1>로그인</h1>
	    <form action="<%=request.getContextPath()%>/login" method="post">
	        <div><input type="password" name="pw" placeholder="비밀번호를 입력하세요"></div>
	        <div><button type="submit">로그인</button></div>
	    </form>
	</body>
</html>