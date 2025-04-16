<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String login = (String)(session.getAttribute("login"));
	
	if (login == null) { // 로그아웃 상태
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	System.out.println("insertReceitForm#cashNo: " + cashNo);
	
	Part part = request.getPart("imageFile"); // 파일 받는 API
	String originalName = part.getSubmittedFileName(); // one1.png
	
	// 1) 중복되지 않는 새로운 파일이름 생성 - java.util.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString();
	filename = filename.replace("-", "");
	
	// 2) 1의 결과에 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 . 의 인덱스값 반환
	String ext = originalName.substring(dotLastPos);
	
	// Request 입력값 유효성 검정
	if(!ext.equals(".png")) {
		response.sendRedirect("/cashbook/cash/insertReceitForm.jsp?msg=error");
		return; // JSP 코드진행을 종료
	}
	
	filename = filename + ext;
	
	Receit receit = new Receit();
	receit.setCashNo(cashNo);
	receit.setFilename(filename);
	
	// 3) 파일저장
	String path = request.getServletContext().getRealPath("upload"); 
	// 톰켓안에 poll 프로젝트안 upload폴더 실제 물리적주소를 반환
	System.out.println("path: "+path);
	File emptyFile = new File(path, filename);
	// 파일을 보낼 inputstram 설정
	InputStream is = part.getInputStream(); // 파트안의 스트림(이미지파일의 바이너리파일)
	// 파일을 받을 outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); // inputstream binary -> 반복(1byte씩) -> outputstream
	
	// 4) db의 저장
	ReceitDao receitDao = new ReceitDao();
	receitDao.insertReceit(receit);
	
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo=" + cashNo);
%>
