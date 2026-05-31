package kr.or.navi.advice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.TaskProcessStatusVO;
import kr.or.navi.vo.TaskStatusVO;

@Mapper
public interface TaskCommonDAO {
	public List<TaskStatusVO> selectTaskStatusList();
	public List<TaskProcessStatusVO> selectTaskProcessStatusList();
}
