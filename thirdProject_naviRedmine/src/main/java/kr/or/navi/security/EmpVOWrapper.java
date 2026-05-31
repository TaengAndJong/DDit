package kr.or.navi.security;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import kr.or.navi.vo.EmpVO;

public class EmpVOWrapper extends User{
	private EmpVO realUser;
	
	public EmpVOWrapper(EmpVO realUser) {
		super(realUser.getEmpId(),
				realUser.getEmpPass(),
				realUser.getEmpRoles().stream()
				.map(SimpleGrantedAuthority::new)
				.collect(Collectors.toList())
				);
		this.realUser=realUser;
	}
	public EmpVO getRealUser() {
		return realUser;
	}
}
