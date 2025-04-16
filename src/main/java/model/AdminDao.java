package model;

import java.sql.*;

public class AdminDao {
	public boolean login(String pw) throws ClassNotFoundException, SQLException { // 로그인
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select admin_id adminId, admin_pw adminPw from admin where admin_pw = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, pw);
		rs = stmt.executeQuery();
		
		if (rs.next()) { // 로그인 성공
			conn.close();
			return true;
		} else { // 로그인 실패
			conn.close();
			return false;
		}
	}
	
	public int updateAdminPw(String pw, String newpw) throws ClassNotFoundException, SQLException { // 비밀번호 변경
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "update admin set admin_pw = ? where admin_pw = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newpw);
		stmt.setString(2, pw);
		int row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
}
