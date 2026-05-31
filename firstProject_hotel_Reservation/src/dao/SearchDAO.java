package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class SearchDAO {

	private static SearchDAO instance = null;
	private SearchDAO() {}
	public static SearchDAO getInstance() {
		if(instance == null) instance = new SearchDAO();
		return instance;
	}
	
	JDBCUtil jdbc = JDBCUtil.getInstance();
	
	public List<Map<String, Object>> selectList(String ag) {
		return jdbc.selectList("SELECT * FROM RESERVE WHERE RES_NO = (?)");
	}
	
	public List<Map<String, Object>> mlist(String ag){
		String sql = "INSERT INTO RESERVE(RES_NO) VALUES(?)";
		return jdbc.selectList(sql);

	}
	
	public Map<String, Object> search(String num){
		String sql = "SELECT ROM.ROM_NO, RES.RES_NO, RES.CHECKIN, RES.CHECKOUT, RES.RES_PRICE, ROM.ROM_GRD, ROM.ROM_PER, CUS.CUS_NAME, RES.RES_PRICE\r\n" + 
				"FROM RESERVE RES, ROOM ROM, CUSTOMER CUS WHERE CUS.CUS_TEL = RES.CUS_TEL\r\n" + 
				"AND RES.ROM_NO = ROM.ROM_NO AND RES.RES_NO = ?";
		List<Object> param = new ArrayList<Object>();
		param.add(num);
		
		Map<String, Object> map = jdbc.selectOne(sql, param);
		return map;
		
	
	}
	
	public int cancel(String resno) {
		String sql = "DELETE FROM RESERVE WHERE RES_NO = ? ";
		List<Object> param = new ArrayList<Object>();
		param.add(resno);

//		int map = jdbc.update(resno);
		return jdbc.update(sql, param);
	}
	 public Map<String, Object> searchreserve(String resno){
		   String sql = "SELECT * FROM RESERVE WHERE RES_NO = ?";
		   List<Object> param = new ArrayList<Object>();
		   param.add(resno);
		   
//		   Map<String, Object> map=jdbc.selectOne(sql);
		   return jdbc.selectOne(sql, param);
	   }
	
	
}
