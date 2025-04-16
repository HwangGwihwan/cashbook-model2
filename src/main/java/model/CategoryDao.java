package model;

import java.sql.*;
import java.util.*;
import dto.*;

public class CategoryDao {
	public int checkCategory(Category c) throws ClassNotFoundException, SQLException { // 수입/지출에 같은 항목이 있는지 확인
		int check = 0;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select * from category where kind = ? and title = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getKind());
		stmt.setString(2, c.getTitle());
		rs = stmt.executeQuery();
		
		if (rs.next()) {
			check = 1;
		}
		
		conn.close();
		return check;
	}
	
	public void insertCategory(Category c) throws ClassNotFoundException, SQLException { // 삽입
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "insert into category (kind, title) values (?, ?)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getKind());
		stmt.setString(2, c.getTitle());
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public ArrayList<Category> selectCategoryList(Paging p) throws ClassNotFoundException, SQLException { // 전체 리스트 출력
		ArrayList<Category> list = new ArrayList<Category>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select ct.category_no categoryNo, ct.kind kind, ct.title title, ct.createdate createdate, t.cnt cnt from category ct left outer join"
				+ " (select category_no, count(*) cnt from cash group by category_no) t"
				+ " on ct.category_no = t.category_no"
				+ " order by categoryNO asc"
				+ " limit ?, ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
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
		
		conn.close();
		return list;
	}
	
	public ArrayList<Category> selectCategoryListByKind(String kind) throws ClassNotFoundException, SQLException { // 수입/지출별로 카테고리 검색하기
		ArrayList<Category> list = new ArrayList<Category>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select category_no categoryNo, title from category where kind = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, kind);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			Category c = new Category();
			c.setCateoryNo(rs.getInt("categoryNo"));
			c.setTitle(rs.getString("title"));
			
			list.add(c);
		}
		
		conn.close();
		return list;
	}
	
	public Category selectCategoryOne(int num) throws ClassNotFoundException, SQLException { // 한 개만 선택
		Category c = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select category_no categoryNo, kind, title, createdate from category where category_no = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		
		if (rs.next()) {
			c = new Category();
			c.setCateoryNo(rs.getInt("categoryNo"));
			c.setKind(rs.getString("kind"));
			c.setTitle(rs.getString("title"));
		}
		
		conn.close();
		return c;
	}
	
	public int totalRow() throws ClassNotFoundException, SQLException { // 전체 행 구하기
		int total = 0;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*) cnt from category";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		if (rs.next()) {
			total = rs.getInt("cnt");
		}
		
		conn.close();
		return total;
	}
	
	public void updateCategoryTitle(int num, String title) throws ClassNotFoundException, SQLException { // 수정
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "update category set title = ? where category_no = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setInt(2, num);
		stmt.executeUpdate();
		
		conn.close();	
	}
	
	public void deleteCategory(int num) throws ClassNotFoundException, SQLException { // 삭제
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from category where category_no = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		stmt.executeUpdate();
		
		conn.close();
	}
}
