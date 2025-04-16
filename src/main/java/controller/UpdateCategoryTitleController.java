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

@WebServlet("/updateCategoryTitle")
public class UpdateCategoryTitleController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
		System.out.println("UpdateCategoryTitleController.doGet#categoryNo: " + categoryNo); 
		
		CategoryDao categoryDao = new CategoryDao();
		Category c = categoryDao.selectCategoryOne(categoryNo);
		request.setAttribute("category", c);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/updateCategoryTitle.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
		String kind = request.getParameter("kind");
		String title = request.getParameter("title");
		
		System.out.println("UpdateCategoryTitleController.doPost#categoryNo: " + categoryNo);
		System.out.println("UpdateCategoryTitleController.doPost#kind: " + kind);
		System.out.println("UpdateCategoryTitleController.doPost#title: " + title);
		
		CategoryDao categoryDao = new CategoryDao();
		categoryDao.updateCategoryTitle(categoryNo, title);
		
		response.sendRedirect(request.getContextPath() + "/categoryList");
	}
}
