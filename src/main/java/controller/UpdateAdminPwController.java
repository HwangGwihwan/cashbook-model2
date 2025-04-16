package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.AdminDao;

@WebServlet("/updateAdminPw")
public class UpdateAdminPwController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/updateAdminPw.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		String pw = request.getParameter("pw");
		String newpw1 = request.getParameter("newpw1");
		String newpw2 = request.getParameter("newpw2");
		
		System.out.println("UpdateAdminPwController.doPost#pw: " + pw);
		System.out.println("UpdateAdminPwController.doPost#newpw1: " + newpw1);
		System.out.println("UpdateAdminPwController.doPost#newpw2: " + newpw2);
		
		if (!newpw1.equals(newpw2)) { // 바꾼 비밀번호 확인이 맞지 않음
			response.sendRedirect(request.getContextPath() + "/updateAdminPw");
			return;
		}
		
		AdminDao adminDao = new AdminDao();
		int row = adminDao.updateAdminPw(pw, newpw1);
		
		if (row == 0) { // 비밀번호 변경 실패
			response.sendRedirect(request.getContextPath() + "/updateAdminPw");
		} else { // 비밀번호 변경 성공
			response.sendRedirect(request.getContextPath() + "/logout");
		}
	}
}
