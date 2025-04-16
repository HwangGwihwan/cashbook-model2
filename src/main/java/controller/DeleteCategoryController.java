package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.CategoryDao;

@WebServlet("/deleteCategory")
public class DeleteCategoryController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
		System.out.println("DeleteCategoryController.doGet#categoryNo: " + categoryNo);
		
		CategoryDao categoryDao = new CategoryDao();
		categoryDao.deleteCategory(categoryNo);
		
		response.sendRedirect(request.getContextPath() + "/categoryList");
	}
}
