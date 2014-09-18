package item.itemDao;

import item.itemVO.ItemVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import construction.constructionVO.ConstructionVO;

public class ItemDao {
	
	public void add(Connection c, ItemVO item) throws ClassNotFoundException, SQLException{
		Date nowtime = new Date();
		String now = new SimpleDateFormat("yyyyMMdd").format(nowtime);
		
		System.out.println("item.getItemName() in Dao: "+item.getItemName());
		
		if(item.getItemName().equals("") || ("").equals(item.getItemName()) || item.getItemName() == null){
			System.out.println("item empty space ");
			return;
			
		}
		
		PreparedStatement ps = c.prepareStatement(
				"insert into ITEM(ITEM_NAME, QTT, INSERT_TIME) values(?,?,?)");
		ps.setString(1, item.getItemName());
		ps.setInt(2, item.getQtt());
		ps.setString(3, now);
		
		ps.executeUpdate();
		ps.close();
		//c.close();
	}
	
	public void update(Connection c, ItemVO item) throws ClassNotFoundException, SQLException{
		System.out.println("item : "+item.getQtt());
		PreparedStatement ps = c.prepareStatement(
				"update item set qtt = ? where  ITEM_NAME = ?");
		ps.setInt(1, item.getQtt());
		ps.setString(2, item.getItemName());

		ps.executeUpdate();
		ps.close();
		//c.close();
	}
	
	public ItemVO get(Connection c, ItemVO vo) throws ClassNotFoundException, SQLException{
		PreparedStatement ps = null;
		if(vo.getItemCode()!=0 && vo.getItemName() == null){
			ps = c.prepareStatement(
					"select * from item where ITEM_CODE =?");
			ps.setInt(1, vo.getItemCode());
		}else if(vo.getItemCode()==0 && vo.getItemName() != null){
			ps = c.prepareStatement(
					"select * from item where ITEM_NAME =?");
			ps.setString(1, vo.getItemName());
		}else if(vo.getItemCode() != 0 && vo.getItemName() != null){
			ps = c.prepareStatement(
					"select * from item where ITEM_CODE = ? and ITEM_NAME =?");
			ps.setInt(1, vo.getItemCode());
			ps.setString(2, vo.getItemName());
		}
		
		ResultSet rs = ps.executeQuery();
		ItemVO itemVO = new ItemVO();
		if(rs.next()){
			itemVO.setItemCode(rs.getInt("ITEM_CODE"));
			itemVO.setItemName(rs.getString("ITEM_NAME"));
			itemVO.setQtt(rs.getInt("QTT"));
		}else{
			itemVO.setItemCode(0);
		}
		
		rs.close();
		ps.close();
		return itemVO;
	}
	
	public List<ItemVO> getList(Connection c) throws ClassNotFoundException, SQLException{
		PreparedStatement ps = c.prepareStatement("select * from item");
		ResultSet rs = ps.executeQuery();
		
		if(!rs.next()){
			return Collections.emptyList();
		}
		List<ItemVO> itemList = new ArrayList<ItemVO>();
		do{
			ItemVO itemVO = makeSetFromResultSet(rs);
			itemList.add(itemVO);
		}while(rs.next());
		return itemList;
	}
	
	private ItemVO makeSetFromResultSet(ResultSet rs) throws SQLException{
		ItemVO itemVO = new ItemVO();
		itemVO.setItemCode(rs.getInt("ITEM_CODE"));
		itemVO.setItemName(rs.getString("ITEM_NAME"));
		itemVO.setQtt(rs.getInt("QTT"));
		return itemVO;
	}
	
}
