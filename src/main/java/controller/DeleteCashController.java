package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.CashDao;

@WebServlet("/deleteCash")
public class DeleteCashController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int cashNo = Integer.parseInt(request.getParameter("cashNo"));
		String cashDate = request.getParameter("cashDate");
		
		System.out.println("DeleteCashController.doGet#cashNo: " + cashNo);
		System.out.println("DeleteCashController.doGet#cashDate: " + cashDate);
		
		CashDao cashDao = new CashDao();
		cashDao.deleteCashOne(cashNo);
		
		response.sendRedirect(request.getContextPath() + "/dateList?date=" + cashDate);
	}
}
