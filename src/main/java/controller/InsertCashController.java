package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

import dao.CashDao;
import dao.CategoryDao;
import dto.Cash;
import dto.Category;

@WebServlet("/insertCash")
public class InsertCashController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		String cashDate = request.getParameter("cashDate");
		String kind = request.getParameter("kind");
		
		System.out.println("InsertCashController.doGet#cashDate: " + cashDate);
		System.out.println("InsertCashController.doGet#kind: " + kind);
		
		ArrayList<Category> list = null;
		
		if (kind != null) { // insertCash.jsp에서 kind선택 후 재요청
			// DB : 선택된 kind의 title 목록
			CategoryDao categoryDao = new CategoryDao();
			list = categoryDao.selectCategoryListByKind(kind);
		}
		
		request.setAttribute("cashDate", cashDate);
		request.setAttribute("kind", kind);
		request.setAttribute("list", list);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/insertCash.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		String cashDate = request.getParameter("cashDate");
		int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		String memo = request.getParameter("memo");
		String color = request.getParameter("color");
		
		System.out.println("InsertCashController.doPost#cashDate: " + cashDate);
		System.out.println("InsertCashController.doPost#categoryNo: " + categoryNo);
		System.out.println("InsertCashController.doPost#amount: " + amount);
		System.out.println("InsertCashController.doPost#memo: " + memo);
		System.out.println("InsertCashController.doPost#color: " + color);
		
		Cash cash = new Cash();
		cash.setCategoryNo(categoryNo);
		cash.setCash_date(cashDate);
		cash.setAmount(amount);
		cash.setMemo(memo);
		cash.setColor(color);
		
		CashDao cashDao = new CashDao();
		cashDao.insertCash(cash);
		
		response.sendRedirect(request.getContextPath() + "/dateList?date=" + cashDate);
	}

}
