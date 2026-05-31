package kr.or.navi.common.preparer;

import java.util.Map;

import javax.inject.Inject;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.web.servlet.HandlerMapping;

import kr.or.navi.admin.emp.dao.AdminEmpDAO;
import kr.or.navi.common.preparer.dao.ResourceDAO;

@Preparer("adminEmpPreparer")
public class AdminEmpPreparer  implements ViewPreparer{
	@Inject
	ResourceDAO dao;
	@Inject
	AdminEmpDAO adminEmpDao;
	@Override
	public void execute(Request req, AttributeContext arg1) {
		
		int empTotal = adminEmpDao.selectEmpTotalRecord();
		int pmsTotal = adminEmpDao.selectPmsTotalRecord();
		int plTotal = adminEmpDao.selectPlTotalRecord();
		int blockTotal = adminEmpDao.selectBlockTotalRecord();
		
		
		Map<String, Object> context = req.getContext(Request.REQUEST_SCOPE);
		String requestUrl = (String) context.get(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);
		String title = "전체 및 PMS 사원조회";
		if(requestUrl.contains("/invite")) {
			title="PMS 사원초대";
		}else if(requestUrl.contains("/empo")) {
			title="프로젝트관리자 관리";
		}else if(requestUrl.contains("/block")) {
			title="PMS 접근권한 관리";
		}
		context.put("mainTitle", title);
		context.put("empTotal", empTotal);
		context.put("pmsTotal", pmsTotal);
		context.put("plTotal", plTotal);
		context.put("blockTotal", blockTotal);
	}

}