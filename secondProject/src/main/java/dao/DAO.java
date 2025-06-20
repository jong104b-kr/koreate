package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
	Connection con; // 선언
	
	public void getCon() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/2ndprj"; // 데이터베이스명 : 2ndprj
			String user="root";
			String password="1111";
			
			con = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
