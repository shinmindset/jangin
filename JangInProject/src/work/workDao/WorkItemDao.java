package work.workDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import work.workVO.WorkVO;
import work.workVO.WorkEmpVO;
import work.workVO.WorkItemVO;
import work.workVO.WorkDoneVO;

public class WorkItemDao {
	public void add(Connection c, WorkItemVO workItemVO) throws ClassNotFoundException, SQLException{
		PreparedStatement ps = c.prepareStatement(
				"insert into WORKITEM(NO_FK,CON_CODE,WORK_DATE,ITEM_CODE,EXP_ITEM_CODE) values (?,?,?,?,?)");
		ps.setInt(1, workItemVO.getNoFk());
		ps.setInt(2, workItemVO.getConCode());
		ps.setString(3, workItemVO.getWorkDate());
		ps.setInt(4, workItemVO.getItemCode());
		ps.setInt(5, workItemVO.getExpItemCode());
		
		ps.executeUpdate();
		
		ps.close();
		//c.close();
	}
	
	public WorkVO get(Connection c, WorkVO workVO) throws ClassNotFoundException, SQLException{
		
		PreparedStatement ps = null;
		ps = c.prepareStatement(
					"select * from work where CON_CODE = ? and WORK_DATE =?");
		ps.setInt(1, workVO.getConCode());
		ps.setString(2, workVO.getWorkDate());
		
		ResultSet rs = ps.executeQuery();
		WorkVO vo = new WorkVO();
		if(rs.next()){
			vo.setNo(rs.getInt("NO"));
			vo.setConCode(rs.getInt("CON_CODE"));
			vo.setWorkDate(rs.getString("WORK_DATE"));
			vo.setWeather(rs.getString("WEATHER"));
			vo.setAuth(rs.getString("AUTH"));
			vo.setETC(rs.getString("ETC"));
		}else{
			vo.setConCode(0);
		}
		rs.close();
		ps.close();
		
		return vo;
	}
	

	public List<WorkItemVO> getWorkItemList(Connection c, WorkVO workVO) throws ClassNotFoundException, SQLException{
		PreparedStatement ps = null;
		ps = c.prepareStatement(
				"select * from workitem where con_code = ? and work_date =? and no_fk =?");
		ps.setInt(1, workVO.getConCode());
		ps.setString(2, workVO.getWorkDate());
		ps.setInt(3, workVO.getNo());
		
		ResultSet rs = ps.executeQuery();
		
		if(!rs.next()){
			return Collections.emptyList();
		}
		List<WorkItemVO> workItemList = new ArrayList<WorkItemVO>();
		WorkItemVO vo = new WorkItemVO();
		do{
			vo.setNo(rs.getInt("NO"));
			vo.setNoFk(rs.getInt("NO_FK"));
			vo.setConCode(rs.getInt("CON_CODE"));
			vo.setWorkDate(rs.getString("WORK_DATE"));
			vo.setItemCode(rs.getInt("ITEM_CODE"));
			vo.setExpItemCode(rs.getInt("EXP_ITEM_CODE"));
			workItemList.add(vo);
		}while(rs.next());
		
		rs.close();
		ps.close();
		
		return workItemList;
	}
}
