package construction.constructionDao;

import item.itemVO.ItemVO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import construction.constructionVO.*;


public class ConstructionDao {

	public void add(Connection c, ConstructionVO construction) throws ClassNotFoundException, SQLException{
		Date nowtime = new Date();
		String now = new SimpleDateFormat("yyyyMMdd").format(nowtime);
		
		
		PreparedStatement ps = c.prepareStatement(
				"insert into CONSTRUCTION(CON_CODE,CON_NAME,START_DATE,END_DATE,EXP_START_DATE,EXP_END_DATE,INSERT_TIME) value (?,?,?,?,?,?,?)");
		ps.setInt(1, construction.getConCode());
		ps.setString(2, construction.getConName());
		ps.setString(3, construction.getStartDate());
		ps.setString(4, construction.getEndDate());
		ps.setString(5, construction.getExpStartDate());
		ps.setString(6, construction.getExpEndDate());
		ps.setString(7, now);
		
		ps.executeUpdate();
		
		ps.close();
		//c.close();
	}
	public ConstructionVO get(Connection c, ConstructionVO conVO) throws ClassNotFoundException, SQLException{
		
		//System.out.println(conVO.getConCode());
		//System.out.println(conVO.getConName());
		
		PreparedStatement ps = null;

		if(conVO.getConCode()!=0 && conVO.getConName() == null){
			ps = c.prepareStatement(
				"select * from construction where con_code = ?");
		ps.setInt(1, conVO.getConCode());
		}else if(conVO.getConCode()==0 && conVO.getConName() != null){
			ps = c.prepareStatement(
					"select * from construction where CON_NAME =?");
			ps.setString(1, conVO.getConName());
		}else if(conVO.getConCode() != 0 && conVO.getConName() != null){
			ps = c.prepareStatement(
					"select * from construction where CON_CODE = ? and CON_NAME =?");
			ps.setInt(1, conVO.getConCode());
			ps.setString(2, conVO.getConName());
		}
		
		ResultSet rs = ps.executeQuery();
		ConstructionVO con = new ConstructionVO();
		if(rs.next()){
			con.setConCode(rs.getInt("CON_CODE"));
			con.setConName(rs.getString("CON_NAME"));
			con.setEndDate(rs.getString("END_DATE"));
			con.setExpEndDate(rs.getString("EXP_END_DATE"));
			con.setExpStartDate(rs.getString("EXP_START_DATE"));
			con.setStartDate(rs.getString("START_DATE"));
		}else{
			con.setConCode(0);
		}
		rs.close();
		ps.close();
		
		return con;
	}
	
	public List<ConstructionVO> getList(Connection c) throws ClassNotFoundException, SQLException{
		PreparedStatement ps = c.prepareStatement("select * from construction");
		
		ResultSet rs = ps.executeQuery();
		
		if(!rs.next()){
			return Collections.emptyList();
		}
		List<ConstructionVO> constructionList = new ArrayList<ConstructionVO>();
		do{
			ConstructionVO vo = makeSetFromResultSet(rs);
			constructionList.add(vo);
		}while(rs.next());
		return constructionList;
	}
	
	private ConstructionVO makeSetFromResultSet(ResultSet rs) throws SQLException{
		ConstructionVO conVO = new ConstructionVO();
		conVO.setConCode(rs.getInt("CON_CODE"));
		conVO.setConName(rs.getString("CON_NAME"));
		conVO.setEndDate(rs.getString("END_DATE"));
		conVO.setExpEndDate(rs.getString("EXP_END_DATE"));
		conVO.setExpStartDate(rs.getString("EXP_START_DATE"));
		conVO.setStartDate(rs.getString("START_DATE"));
		return conVO;
	}

}
