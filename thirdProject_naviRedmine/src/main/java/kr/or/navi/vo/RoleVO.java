package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="roleId")
public class RoleVO implements Serializable{
	private String roleId;
	private String roleName;
}
