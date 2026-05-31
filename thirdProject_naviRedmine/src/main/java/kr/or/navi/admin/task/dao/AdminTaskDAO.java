package kr.or.navi.admin.task.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.vo.TaskVO;

@Mapper
public interface AdminTaskDAO {
	
	public int deleteTaskProject(@Param("tasks") List<TaskVO> task);

}
