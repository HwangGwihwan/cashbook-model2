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
import dto.Cash;


@WebServlet("/dateList")
public class DateListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		String date = request.getParameter("date");
		System.out.println("DateListController.doGet#date: " + date);
		
		CashDao cashDao = new CashDao();
		ArrayList<Cash> cashList = cashDao.selectCashByDate(date);
		
		int targetYear = Integer.parseInt(date.substring(0, 4));
		int targetMonth = Integer.parseInt(date.substring(5, 7));
		
		request.setAttribute("cashList", cashList);
		request.setAttribute("targetYear", targetYear);
		request.setAttribute("targetMonth", targetMonth);
		request.setAttribute("date", date);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/dateList.jsp");
		rd.forward(request, response);
	}
}
