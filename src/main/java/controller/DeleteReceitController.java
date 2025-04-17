package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;

import dao.ReceitDao;


@WebServlet("/deleteReceit")
public class DeleteReceitController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int cashNo = Integer.parseInt(request.getParameter("cashNo"));
		String filename = request.getParameter("filename");
		
		System.out.println("DeleteReceitController.doGet#cashNo: " + cashNo);
		System.out.println("DeleteReceitController.doGet#filename: " + filename);
		
		// db삭제
		ReceitDao receitDao = new ReceitDao();
		receitDao.deleteReceitOne(cashNo);
		
		// 파일 삭제
		String path = request.getServletContext().getRealPath("upload");
		File file = new File(path, filename); // new File 경로에 파일이 없으면 빈파일을 생성
		if (file.exists()) { // 빈파일이 아니라면
			file.delete();
		}
		
		response.sendRedirect(request.getContextPath() + "/cashOne?cashNo=" + cashNo);
	}
}
