package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.*;
import java.nio.file.Files;
import java.util.UUID;

import dao.ReceitDao;
import dto.Receit;


@WebServlet("/insertReceit")
public class InsertReceitController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int cashNo = Integer.parseInt(request.getParameter("cashNo"));
		String msg = "";
		if (request.getParameter("msg") != null) {
			msg = request.getParameter("msg");
		}
		
		System.out.println("InsertReceitController.doGet#cashNo: " + cashNo);
		System.out.println("InsertReceitController.doGet#msg: " + msg);
		
		request.setAttribute("cashNo", cashNo);
		request.setAttribute("msg", msg);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/insertReceit.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int cashNo = Integer.parseInt(request.getParameter("cashNo"));
		System.out.println("InsertReceitController.doPost#cashNo: " + cashNo);
		
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
			response.sendRedirect(request.getContextPath() + "/insertReceit?cashNo=" + cashNo + "&msg=error");
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
		
		ReceitDao receitDao = new ReceitDao();
		receitDao.insertReceit(receit);
		
		response.sendRedirect(request.getContextPath() + "/cashOne?cashNo=" + cashNo);
	}
}
