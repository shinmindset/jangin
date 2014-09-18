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

public class WorkEmpDao {
	public void add(Connection c, WorkEmpVO workEmpVO) throws ClassNotFoundException, SQLException{
		Date nowtime = new Date();
		String now = new SimpleDateFormat("yyyyMMdd").format(nowtime);
		System.out.println("workEmpVO.getNoFk() : "+workEmpVO.getNoFk());
		System.out.println("workEmpVO.getConCode() : "+workEmpVO.getConCode());
		System.out.println("workEmpVO.getEmpCode() : "+workEmpVO.getEmpCode());
		System.out.println("workEmpVO.getExpEmpCode() : "+workEmpVO.getExpEmpCode());
		System.out.println("workEmpVO.getWorkDate() : "+workEmpVO.getWorkDate());
		
		PreparedStatement ps = c.prepareStatement(
				"insert into WORKEMP(NO_FK,CON_CODE,EMP_CODE,EXP_EMP_CODE,WORK_DATE,INSERT_TIME) values (?,?,?,?,?,?)");
		ps.setInt(1, workEmpVO.getNoFk());
		ps.setInt(2, workEmpVO.getConCode());
		ps.setInt(3, workEmpVO.getEmpCode());
		ps.setInt(4, workEmpVO.getExpEmpCode());
		ps.setString(5, workEmpVO.getWorkDate());
		ps.setString(6, now);
		
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
	
	public List<WorkEmpVO> getWorkEmpList(Connection c, WorkVO workVO) throws ClassNotFoundException, SQLException{
		PreparedStatement ps = null;
		ps = c.prepareStatement(
				"select * from workemp where con_code = ? and work_date =? and no_fk =?");
		ps.setInt(1, workVO.getConCode());
		ps.setString(2, workVO.getWorkDate());
		ps.setInt(3, workVO.getNo());
		
		ResultSet rs = ps.executeQuery();
		
		if(!rs.next()){
			return Collections.emptyList();
		}
		List<WorkEmpVO> workEmpList = new ArrayList<WorkEmpVO>();
		WorkEmpVO vo = new WorkEmpVO();
		do{
			vo.setNo(rs.getInt("NO"));
			vo.setNoFk(rs.getInt("NO_FK"));
			vo.setConCode(rs.getInt("CON_CODE"));
			vo.setWorkDate(rs.getString("WORK_DATE"));
			vo.setEmpCode(rs.getInt("EMP_CODE"));
			vo.setExpEmpCode(rs.getInt("EXP_EMP_CODE"));
			workEmpList.add(vo);
		}while(rs.next());
		
		rs.close();
		ps.close();
		
		return workEmpList;
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
