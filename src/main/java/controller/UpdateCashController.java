package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.CashDao;
import dto.Cash;

@WebServlet("/updateCash")
public class UpdateCashController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int cashNo = Integer.parseInt(request.getParameter("cashNo"));
		System.out.println("UpdateCashController.doGet#cashNo: " + cashNo);
		
		CashDao cashDao = new CashDao();
		Cash cash = cashDao.selectCashOne(cashNo);
		
		request.setAttribute("cashNo", cashNo);
		request.setAttribute("cash", cash);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/updateCash.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int cashNo = Integer.parseInt(request.getParameter("cashNo"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		String memo = request.getParameter("memo");
		String color = request.getParameter("color");
		
		System.out.println("UpdateCashController.doPost#cashNo: " + cashNo);
		System.out.println("UpdateCashController.doPost#amount: " + amount);
		System.out.println("UpdateCashController.doPost#memo: " + memo);
		System.out.println("UpdateCashController.doPost#color: " + color);
		
		Cash cash = new Cash();
		cash.setCashNo(cashNo);
		cash.setAmount(amount);
		cash.setMemo(memo);
		cash.setColor(color);
		
		CashDao cashDao = new CashDao();
		cashDao.updateCashOne(cash);
		
		response.sendRedirect(request.getContextPath() + "/cashOne?cashNo=" + cashNo);
	}
}
