package kr.or.navi.admin.task.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.admin.task.dao.AdminTaskDAO;
import kr.or.navi.vo.TaskVO;

@Service
public class AdminTaskServiceImpl implements AdminTaskService {

	@Inject
	private AdminTaskDAO adminTaskDao;

	@Override
	public int taskCheckedDelete(List<TaskVO> task) {
		return adminTaskDao.deleteTaskProject(task);
	}

}
