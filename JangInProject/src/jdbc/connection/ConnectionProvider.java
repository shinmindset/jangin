package jdbc.connection;

import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;


public class ConnectionProvider{
	public static Connection getConnection()  throws SQLException{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Connection c = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/jangin?characterEncoding=UTF-8", "",
				""); 
		return c;
	}
}