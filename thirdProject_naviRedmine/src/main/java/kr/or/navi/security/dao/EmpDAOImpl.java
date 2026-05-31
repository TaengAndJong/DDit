package kr.or.navi.security.dao;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import kr.or.navi.mapper.dao.EmpDAO;
import kr.or.navi.security.EmpVOWrapper;
import kr.or.navi.vo.EmpVO;

@Repository("userDetailService")
public class EmpDAOImpl implements UserDetailsService{
	
	@Inject
	private EmpDAO mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		EmpVO member = mapper.selectOne(username);
		if(member==null)
			throw new UsernameNotFoundException(String.format("%s 사용자 없음.", username));
		return new EmpVOWrapper(member);
	}

}
