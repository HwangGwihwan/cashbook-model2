package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.CategoryDao;
import dto.Category;

@WebServlet("/insertCategory")
public class InsertCategoryController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/insertCategory.jsp");
		rd.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		String kind = request.getParameter("kind");
		String title = request.getParameter("title");
		
		System.out.println("InsertCategoryController.doPost#kind: " + kind);
		System.out.println("InsertCategoryController.doPost#title: " + title);
	
		Category c = new Category();
		c.setKind(kind);
		c.setTitle(title);
		
		CategoryDao categoryDao = new CategoryDao();
		int check = categoryDao.checkCategory(c);
		
		if (check == 0) { // 중복 없음
			categoryDao.insertCategory(c);
		}
		// 중복 있을 경우에는 삽입x

		response.sendRedirect(request.getContextPath() + "/categoryList");
	}
}
