package dao;

import java.sql.*;
import java.util.*;
import dto.*;
import util.DBUtil;

public class CategoryDao {
	public int checkCategory(Category c) { // 수입/지출에 같은 항목이 있는지 확인
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int check = 0;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "select * from category where kind = ? and title = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, c.getKind());
			stmt.setString(2, c.getTitle());
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				check = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
			try {rs.close();} catch(Exception e){}
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
		
		return check;
	}
	
	public void insertCategory(Category c) { // 삽입
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "insert into category (kind, title) values (?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, c.getKind());
			stmt.setString(2, c.getTitle());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
	}
	
	public ArrayList<Category> selectCategoryList(Paging p) { // 전체 리스트 출력
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Category> list = new ArrayList<Category>();
		
		try {
			conn = DBUtil.getConnection();
			String sql = "select ct.category_no categoryNo, ct.kind kind, ct.title title, ct.createdate createdate, t.cnt cnt from category ct left outer join"
					+ " (select category_no, count(*) cnt from cash group by category_no) t"
					+ " on ct.category_no = t.category_no"
					+ " order by categoryNO asc"
					+ " limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, p.getBeginRow());
			stmt.setInt(2, p.getRowPerPage());
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				Category c = new Category();
				c.setCateoryNo(rs.getInt("categoryNo"));
				c.setKind(rs.getString("kind"));
				c.setTitle(rs.getString("title"));
				c.setCreatedate(rs.getString("createdate"));
				c.setCount(rs.getInt("cnt"));
				
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
			try {rs.close();} catch(Exception e){}
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
		
		return list;
	}
	
	public ArrayList<Category> selectCategoryListByKind(String kind) { // 수입/지출별로 카테고리 검색하기
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Category> list = new ArrayList<Category>();
		
		try {
			conn = DBUtil.getConnection();
			String sql = "select category_no categoryNo, title from category where kind = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, kind);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				Category c = new Category();
				c.setCateoryNo(rs.getInt("categoryNo"));
				c.setTitle(rs.getString("title"));
				
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
			try {rs.close();} catch(Exception e){}
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
		
		return list;
	}
	
	public Category selectCategoryOne(int num) { // 한 개만 선택
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Category c = null;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "select category_no categoryNo, kind, title, createdate from category where category_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				c = new Category();
				c.setCateoryNo(rs.getInt("categoryNo"));
				c.setKind(rs.getString("kind"));
				c.setTitle(rs.getString("title"));
			}
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
			try {rs.close();} catch(Exception e){}
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}

		return c;
	}
	
	public int totalRow() { // 전체 행 구하기
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int total = 0;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "select count(*) cnt from category";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				total = rs.getInt("cnt");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
			try {rs.close();} catch(Exception e){}
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
		
		return total;
	}
	
	public void updateCategoryTitle(int num, String title) { // 수정
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "update category set title = ? where category_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setInt(2, num);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
            System.out.print("예외 발생");
		} finally {
            try {stmt.close();} catch(Exception e){}
            try {conn.close();} catch(Exception e){}
		}
	}
	
	public void deleteCategory(int num) { // 삭제
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "delete from category where category_no = ?";
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
