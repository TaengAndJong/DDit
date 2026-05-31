package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class CustomerDAO {
	private static CustomerDAO instance = null;
	private CustomerDAO() {}
	public static CustomerDAO getInstance() {
		if(instance == null) instance = new CustomerDAO();
		return instance;
	}
	
	JDBCUtil jdbc = JDBCUtil.getInstance();
	
	public Map<String, Object> login(String name, String tell, String birth) {
		return jdbc.selectOne(" SELECT * FROM CUSTOMER "
	+" WHERE CUS_NAME='"+name+"' AND CUS_TEL='"+tell+"' AND CUS_BIRT='"+birth+"' ");
	}
	public int signUp(List<Object>param) {
		return jdbc.update("INSERT INTO CUSTOMER (CUS_NAME, CUS_TEL, CUS_BIRT) VALUES (?, ?, ?)", param);
	}

	public int update(String sql, String cus_tell) {
		List<Object> param= new ArrayList<Object>();
		param.add(cus_tell);
		
		return jdbc.update(sql, param);
	}
	//public int selectTEl
}
