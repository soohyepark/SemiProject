package bean;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {
	String driver = "com.mysql.cj.jdbc.Driver";
	String path = "jdbc:mysql://localhost:3306/git";
	String user = "hong";
	String pwd = "1234";
	
	Connection conn;
	
	public DBConn() {
		try {
			Class.forName(driver);//드라이버를 메모리에 로딩(Class.forname())
			conn = DriverManager.getConnection(path, user, pwd); //connection을 생성
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConn() {
		return conn;
	}
	
}
