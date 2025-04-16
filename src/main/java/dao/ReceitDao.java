package dao;

import java.sql.*;
import dto.Receit;
import util.DBUtil;

public class ReceitDao {
	public void insertReceit(Receit r) { // 영수증 등록
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "insert into receit (cash_no, filename) values (?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, r.getCashNo());
			stmt.setString(2, r.getFilename());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
	}
	
	public Receit selectReceitOne(int num) { // 영수증 선택
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Receit receit = null;

		try {
			conn = DBUtil.getConnection();
			String sql = "select cash_no, filename, createdate from receit where cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				receit = new Receit();
				receit.setCashNo(rs.getInt("cash_no"));
				receit.setFilename(rs.getString("filename"));
				receit.setCreatedate(rs.getString("createdate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
			try {rs.close();} catch(Exception e){}
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
		
		return receit;
	}
	
	public void deleteReceitOne(int num) { // 영수증 삭제
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "delete from receit where cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
	}
}
