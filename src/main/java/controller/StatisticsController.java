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
import java.util.HashMap;

import dao.CashDao;

@WebServlet("/statistics")
public class StatisticsController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int year = 2025;
		if (request.getParameter("year") != null) {
			year = Integer.parseInt(request.getParameter("year"));
		}
		
		CashDao cashDao = new CashDao();
		ArrayList<HashMap<String, Object>> totalList = cashDao.totalAmount();
		ArrayList<HashMap<String, Object>> yearTotalList = cashDao.yearTotalAmount(year);
		ArrayList<HashMap<String, Object>> monthTotalList = cashDao.monthTotalAmount(year);
		
		request.setAttribute("year", year);
		request.setAttribute("totalList", totalList);
		request.setAttribute("yearTotalList", yearTotalList);
		request.setAttribute("monthTotalList", monthTotalList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/statistics.jsp");
		rd.forward(request, response);
	}
}
