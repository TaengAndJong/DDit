/**
 * 
 */
package kr.or.navi.task.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.TaskFileVO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;

@Mapper
public interface TaskDAO {
	
	public List<TaskVO> selectList(PaginationInfo paging);
	public List<TaskVO> selectProjectList(@Param("paging") PaginationInfo paging,@Param("proId") String proId);
	//한건 조회
	public TaskVO select(String taskId);
	public int selectTotalRecord(PaginationInfo paging);
	public int selectProjectTotalRecord(@Param("paging") PaginationInfo paging,@Param("proId")String proId);
	public int deleteTask(String taskId);
	public List<TeamVO> selectTeamList(String proId);
	public int updateTask(TaskVO taskVO);
	public int insertTask(TaskVO taskVO);
	public List<TaskVO> selectChildTaskList(String taskId);
	public int insertFile(TaskFileVO bpfVO);
	public List<TaskFileVO> selectTaskFileList(String taksId);
	public TaskFileVO selectTaskFile(String tfId);
	public int deleteTaksFile(String tfId);
}	
