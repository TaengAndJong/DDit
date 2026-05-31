package kr.or.navi.common.preparer;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerMapping;

import kr.or.navi.common.preparer.dao.ResourceDAO;
import kr.or.navi.security.EmpVOWrapper;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.MenuVO;
import kr.or.navi.vo.ResrceVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Preparer("quickPreparer")
public class QuickMenuViewPreparer implements ViewPreparer{
	@Inject
	ResourceDAO dao;
	@Override
	public void execute(Request req, AttributeContext ctx) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		EmpVOWrapper principal = (EmpVOWrapper) authentication.getPrincipal();
		EmpVO realUser = principal.getRealUser();
		String menu = realUser.getEmpName() +" ("+ realUser.getDeptName() + ")";
		log.info("menu : {}" , menu);
		List<MenuVO> main = dao.selectMainList();
		List<MenuVO> quickMain = dao.selectQuickList();
		Map<String, Object> context = req.getContext(Request.REQUEST_SCOPE);
		String requestUrl = (String) context.get(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);
		log.info("requestUrl : {}",requestUrl);
		for(MenuVO vo : quickMain) {
			if(vo.getRescUrl().contains(requestUrl)) {
				log.info("vo.getRescMenu() :{}",vo.getRescMenu());
				context.put("titleName", vo.getRescMenu());
			}
		}
		context.put("sessionMenu", menu);
		context.put("quickMain", quickMain);
		context.put("main", main);
		context.put("realUser", realUser);
	}
}

