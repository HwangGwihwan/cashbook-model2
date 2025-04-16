package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import dto.*;

public class CashDao {
	public ArrayList<Cash> selectCashByDate(String date) throws ClassNotFoundException, SQLException { // 날짜별 수입,지출 확인
		ArrayList<Cash> list = new ArrayList<Cash>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select cs.cash_no cashNo, cs.category_no categoryNo, ct.kind, ct.title, cs.cash_date cashDate, cs.amount, cs.memo, cs.color, r.filename"
				+ " from cash cs INNER JOIN category ct on cs.category_no = ct.category_no"
				+ " left outer join receit r on cs.cash_no = r.cash_no"
				+ " where cash_date = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, date);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			Cash cash = new Cash();
			cash.setCashNo(rs.getInt("cashNo"));
			cash.setCategoryNo(rs.getInt("categoryNo"));
			cash.setCash_date(rs.getString("cashDate"));
			cash.setAmount(rs.getInt("amount"));
			cash.setMemo(rs.getString("memo"));
			cash.setColor(rs.getString("color"));
			
			Category category = new Category();
			category.setKind(rs.getString("kind"));
			category.setTitle(rs.getString("title"));
			cash.setCategory(category);
			
			Receit receit = new Receit();
			receit.setFilename(rs.getString("filename"));
			cash.setReceit(receit);
			
			list.add(cash);
		}
		
		conn.close();
		return list;
	}
	
	public Cash selectCashOne(int num) throws ClassNotFoundException, SQLException { // 하나 선택
			Cash cash = null;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "select cs.cash_date, ct.kind, ct.title, cs.amount, cs.memo"
					+ " from cash cs INNER JOIN category ct on cs.category_no = ct.category_no where cash_no = ?";
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				cash = new Cash();
				cash.setCash_date(rs.getString("cash_date"));
				cash.setAmount(rs.getInt("amount"));
				cash.setMemo(rs.getString("memo"));
				
				Category category = new Category();
				category.setKind(rs.getString("kind"));
				category.setTitle(rs.getString("title"));
				
				cash.setCategory(category);
			}
			
			conn.close();
			return cash;
	}
	
	public void insertCash(Cash c) throws ClassNotFoundException, SQLException { // 입력
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "insert into cash (category_no, cash_date, amount, memo, color) values (?, ?, ?, ?, ?)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, c.getCategoryNo());
		stmt.setString(2, c.getCash_date());
		stmt.setInt(3, c.getAmount());
		stmt.setString(4, c.getMemo());
		stmt.setString(5, c.getColor());
		stmt.executeUpdate();
		
		conn.close();
	}

	public void updateCashOne(Cash c) throws ClassNotFoundException, SQLException { // 수정
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "update cash set amount = ?, memo = ?, color = ? where cash_no = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, c.getAmount());
		stmt.setString(2, c.getMemo());
		stmt.setString(3, c.getColor());
		stmt.setInt(4, c.getCashNo());
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public void deleteCashOne(int num) throws ClassNotFoundException, SQLException { // 삭제
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from cash where cash_no = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public ArrayList<HashMap<String, Object>> totalAmount() throws ClassNotFoundException, SQLException { // 전체 수입/지출 총액
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select kind, count(*) count, sum(cs.amount) sum from cash cs inner join category ct on cs.category_no = ct.category_no group by ct.kind";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("kind", rs.getString("kind"));
			map.put("count", rs.getInt("count"));
			map.put("sum", rs.getInt("sum"));
			
			list.add(map);
		}
		
		conn.close();
		return list;
	}
	
	public ArrayList<HashMap<String, Object>> yearTotalAmount(int year) throws ClassNotFoundException, SQLException { // 특정년도의 수입/지출 통계
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select year(cash_date) year, kind, count(*) count, sum(cs.amount) sum from cash cs inner join category ct on cs.category_no = ct.category_no"
					+ " where year(cash_date) = ? group by year(cash_date), ct.kind";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("kind", rs.getString("kind"));
			map.put("count", rs.getInt("count"));
			map.put("sum", rs.getInt("sum"));
			
			list.add(map);
		}
		
		return list;
	}
	
	public ArrayList<HashMap<String, Object>> monthTotalAmount(int year) throws ClassNotFoundException, SQLException { // 특정년도의 월별 수입/지출 통계
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select month(cash_date) month, kind, count(*) count, sum(cs.amount) sum from cash cs inner join category ct on cs.category_no = ct.category_no"
					+ " where year(cash_date) = ? group by month(cash_date), ct.kind order by month(cash_date)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("month", rs.getString("month"));
			map.put("kind", rs.getString("kind"));
			map.put("count", rs.getInt("count"));
			map.put("sum", rs.getInt("sum"));
			
			list.add(map);
		}
		
		return list;
	}
}
