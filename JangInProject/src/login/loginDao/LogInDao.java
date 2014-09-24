package login.loginDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import login.loginVO.LogInVO;

public class LogInDao {
	public LogInVO get(Connection c, LogInVO login) throws ClassNotFoundException, SQLException {
		String id = login.getUserId();
		String pw = login.getPassword();
		
		PreparedStatement ps = null;
		
		ps = c.prepareStatement("select * from LOGIN where USER_ID = ? and PASSWORD =?");
		ps.setString(1, id);
		ps.setString(2, pw);
		
		ResultSet rs = ps.executeQuery();
		LogInVO loginVO = new LogInVO();
		loginVO.setUserId(rs.getString("USER_ID"));
		loginVO.setUserId(rs.getString("PASSWORD"));
		
		rs.close();
		ps.close();
		
		return login;
	}
}
