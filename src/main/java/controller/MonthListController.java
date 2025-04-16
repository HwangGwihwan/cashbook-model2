package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Calendar;

@WebServlet("/monthList")
public class MonthListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DATE, 1);
		
		if ((request.getParameter("targetMonth") != null) && (request.getParameter("targetYear") != null)) {
			calendar.set(Calendar.YEAR, Integer.parseInt(request.getParameter("targetYear")));
			calendar.set(Calendar.MONTH, Integer.parseInt(request.getParameter("targetMonth")));
		}
		
		System.out.println("MonthListController.doGet#date: " + calendar.get(Calendar.DATE));
		System.out.println("MonthListController.doGet#month: " + (calendar.get(Calendar.MONTH) + 1));
		System.out.println("MonthListController.doGet#year: " + calendar.get(Calendar.YEAR));
		
		// 마지막 날짜
		int lastDate = calendar.getActualMaximum(Calendar.DATE);
		
		// 1일의 요일 -> 시작 공백
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
		int startBlank = dayOfWeek - 1;
		// 뒤 공백
		int endBlank = 0;
		// totalCell은 7의 배수
		int totalCell = startBlank + lastDate + endBlank;
		if (totalCell % 7 != 0) {
			endBlank = 7 - (totalCell % 7);
			totalCell += endBlank;
		}
		
		// 2025-04-10 형태로 만들기
		String date = "";
		date += calendar.get(Calendar.YEAR);
		date += "-";
		if ((calendar.get(Calendar.MONTH) + 1) < 10) {
			date += "0";
			date += (calendar.get(Calendar.MONTH) + 1);
		} else {
			date += (calendar.get(Calendar.MONTH) + 1);
		}
		date += "-";
		
		request.setAttribute("calendar", calendar);
		request.setAttribute("startBlank", startBlank);
		request.setAttribute("lastDate", lastDate);
		request.setAttribute("totalCell", totalCell);
		request.setAttribute("date", date);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/monthList.jsp");
		rd.forward(request, response);
	}
}
