package util;

import java.sql.*;

public class DBUtil {
	public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/cashbook";
        String dbUser = "root";
        String dbPw = "java1234";
        Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
        return connection;
    }
}
