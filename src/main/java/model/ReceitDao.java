package model;

import java.sql.*;
import dto.Receit;

public class ReceitDao {
	public void insertReceit(Receit r) throws ClassNotFoundException, SQLException { // 영수증 등록
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "insert into receit (cash_no, filename) values (?, ?)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, r.getCashNo());
		stmt.setString(2, r.getFilename());
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public Receit selectReceitOne(int num) throws ClassNotFoundException, SQLException { // 영수증 선택
		Receit receit = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select cash_no, filename, createdate from receit where cash_no = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			receit = new Receit();
			receit.setCashNo(rs.getInt("cash_no"));
			receit.setFilename(rs.getString("filename"));
			receit.setCreatedate(rs.getString("createdate"));
		}
		
		conn.close();
		return receit;
	}
	
	public void deleteReceitOne(int num) throws ClassNotFoundException, SQLException { // 영수증 삭제
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from receit where cash_no = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		stmt.executeUpdate();
		
		conn.close();
	}
}
