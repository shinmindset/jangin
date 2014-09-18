package work.workDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import work.workVO.WorkVO;
import work.workVO.WorkEmpVO;
import work.workVO.WorkItemVO;
import work.workVO.WorkDoneVO;

public class WorkDoneDao {
	public void add(Connection c, WorkDoneVO workDoneVO) throws ClassNotFoundException, SQLException{
		Date nowtime = new Date();
		String now = new SimpleDateFormat("yyyyMMdd").format(nowtime);
		System.out.println("now : "+now);
		
		PreparedStatement ps = c.prepareStatement(
				"insert into WORKDONE(NO_FK,CON_CODE,WORK_DATE,WORK_DONE,EXP_WORK_DONE,INSERT_TIME) values (?,?,?,?,?,?)");
		ps.setInt(1, workDoneVO.getNoFk());
		ps.setInt(2, workDoneVO.getConCode());
		ps.setString(3, workDoneVO.getWorkDate());
		ps.setString(4, workDoneVO.getWorkDone());
		ps.setString(5, workDoneVO.getExpWorkDone());
		ps.setString(6, now);
		
		ps.executeUpdate();
		
		ps.close();
		//c.close();
	}
	public List<WorkDoneVO> getList(Connection c, WorkVO workVO) throws ClassNotFoundException, SQLException{
		PreparedStatement ps = null;
		ps = c.prepareStatement(
				"select * from workdone where con_code = ? and work_date =? and no_fk =?");
		ps.setInt(1, workVO.getConCode());
		ps.setString(2, workVO.getWorkDate());
		ps.setInt(3, workVO.getNo());
		
		ResultSet rs = ps.executeQuery();
		
		if(!rs.next()){
			return Collections.emptyList();
		}
		List<WorkDoneVO> workDoneList = new ArrayList<WorkDoneVO>();
		do{
			WorkDoneVO vo = makeSetFromResultSet(rs);
			workDoneList.add(vo);
		}while(rs.next());
		
		rs.close();
		ps.close();
		
		return workDoneList;
	}
	
	private WorkDoneVO makeSetFromResultSet(ResultSet rs) throws SQLException{
		WorkDoneVO vo = new WorkDoneVO();
		vo.setNo(rs.getInt("NO"));
		vo.setNoFk(rs.getInt("NO_FK"));
		vo.setConCode(rs.getInt("CON_CODE"));
		vo.setWorkDate(rs.getString("WORK_DATE"));
		vo.setWorkDone(rs.getString("WORK_DONE"));
		vo.setExpWorkDone(rs.getString("EXP_WORK_DONE"));
		return vo;
	}
	
}
