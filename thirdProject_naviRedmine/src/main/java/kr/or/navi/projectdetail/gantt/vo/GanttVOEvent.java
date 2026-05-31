package kr.or.navi.projectdetail.gantt.vo;

import java.io.Serializable;

import kr.or.navi.vo.TaskVO;
import lombok.Data;
@Data
public class GanttVOEvent implements Serializable{
	private TaskVO task;
	//식별자 taskId
	private String id;
	//라벨 내용 taskTitle
	private String name;
	//시작일 YYYY-MM-DD 형태
	private String start;
	//종료일 YYYY-MM-DD 형태
	private String end;
	//진행률
	private int progress;
	//상위 일감
	private String dependencies;
	public GanttVOEvent(TaskVO task) {
		this.task=task;
	}
	/**
	 * 일감 ID
	 * @return
	 */
	public String getId() {
		return task.getTaskId();
	}
	/**
	 * 그래프에 표시될 라벨 정보
	 * @return
	 */
	public String getName() {
		return task.getTaskTitle();
	}
	/**
	 * 시작일
	 * @return
	 */
	public String getStart() {
		return task.getTaskRegDtStr();
	}
	/**
	 * 마감일
	 * @return
	 */
	public String getEnd() {
		return task.getTaskCompDtStr();
	}
	/**
	 * 진행률
	 * @return
	 */
	public int getProgress() {
		return Integer.parseInt(task.getTaskProcessStatus().getTpsIng().replaceAll("%", "")) ;
	}
	/**
	 * 상위일감id
	 * @return
	 */
	public String getDependencies() {
		return task.getTaskTopId();
	}
	
}
