package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.CashDao;
import dao.ReceitDao;
import dto.Cash;
import dto.Receit;

@WebServlet("/cashOne")
public class CashOneController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String login = (String)(session.getAttribute("login"));

		if (login == null) { // 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int cashNo = Integer.parseInt(request.getParameter("cashNo"));
		System.out.println("CashOneController.doGet#cashNo: " + cashNo);
		
		CashDao cashDao = new CashDao();
		Cash cash = cashDao.selectCashOne(cashNo);
		
		ReceitDao receitDao = new ReceitDao();
		Receit receit = receitDao.selectReceitOne(cashNo);
	}
}
