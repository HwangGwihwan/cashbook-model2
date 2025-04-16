package dao;

import java.sql.*;
import util.DBUtil;

public class AdminDao {
	public boolean login(String pw)  { // 로그인
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		boolean b = false;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "select admin_id adminId, admin_pw adminPw from admin where admin_pw = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, pw);
			rs = stmt.executeQuery();
			if (rs.next()) { // 로그인 성공
				b = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
			try {rs.close();} catch(Exception e){}
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
		
		return b;
	}
	
	public int updateAdminPw(String pw, String newpw) { // 비밀번호 변경
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		try {
			String sql = "update admin set admin_pw = ? where admin_pw = ?";
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newpw);
			stmt.setString(2, pw);
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
		
		return row;
	}
}
