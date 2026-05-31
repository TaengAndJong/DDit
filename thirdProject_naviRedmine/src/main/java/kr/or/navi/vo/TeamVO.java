package kr.or.navi.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="proId")
public class TeamVO implements Serializable{
	private String proId;
	private String empId;
	private String roleId;
	private String teamYn;
	private EmpVO emp;
	private List<TaskVO> taskList;
	public String getTaskIng() {
		int scount=0;
		int tcount=0;
		if(taskList!=null) {
			for(TaskVO task : taskList) {
				if("T00007".equals(task.getTpsId())) {
					scount++;
				}
				tcount++;
			}	
		}
		return scount+"/"+tcount;
	}
}
