package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class LoginDAO {
	//ΩÃ±€≈Ê ∆–≈œ¿ª ∏∏µÁ¥Ÿ
	private static LoginDAO instance =null;
	private LoginDAO() {}
	public static LoginDAO getInstance() {
		if(instance == null)
			instance = new LoginDAO();
		return instance;
	}
	
	JDBCUtil jdbc = JDBCUtil.getInstance();
	
	public Map<String, Object> login(String name, String tell){
		String sql = "SELECT * FROM CUSTOMER WHERE CUS_NAME = ? AND CUS_TEL =? ";
		List<Object> param = new ArrayList<Object>();
		param.add(name);
		param.add(tell);
		
		Map<String, Object> map=jdbc.selectOne(sql, param);
		return map;
	}
}
