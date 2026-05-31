package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of= {"rescId","roleId"})
public class RoleResourceVO implements Serializable{
	private String rescId;
	private String roleId;
}
