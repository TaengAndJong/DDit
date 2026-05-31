package kr.or.navi.common.preparer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerMapping;

import kr.or.navi.common.preparer.dao.ResourceDAO;
import kr.or.navi.project.dao.IssueDAO;
import kr.or.navi.project.dao.ProjectDAO;
import kr.or.navi.projectdetail.issue.controller.service.IssueService;
import kr.or.navi.security.EmpVOWrapper;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.MenuVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.ResrceVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Preparer("projectPreparer")
public class ProjectMenuViewPreparer implements ViewPreparer{
	@Inject
	private ResourceDAO dao;
	@Inject
	private ProjectDAO proDao;
	@Override
	public void execute(Request req, AttributeContext ctx) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		EmpVOWrapper principal = (EmpVOWrapper) authentication.getPrincipal();
		EmpVO realUser = principal.getRealUser();
		String menu = realUser.getEmpName() +" ("+ realUser.getDeptName() + ")";
		List<MenuVO> main = dao.selectMainList();
		List<MenuVO> list1 = dao.selectProjectList("1");
		List<MenuVO> list2 = dao.selectProjectList("2");
		List<MenuVO> list3 = dao.selectProjectList("3");
		List<MenuVO> list4 = dao.selectProjectList("4");
		Map<String, Object> context = req.getContext(Request.REQUEST_SCOPE);
//		String requestUrl = (String) context.get(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
		
		
		Map requset = (Map) context.get(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
		if(list3!=null&&(String)requset.get("proId")!=null) {
			for(MenuVO m:list3) {
				String url = m.getRescUrl();
				String newUrl=url.replace("{proId}", (String)requset.get("proId"));
				m.setRescUrl(newUrl);
				log.info("url 변경 : {}",url);
			}
		}
		
		
		
		log.info("requestUrl : {}", requset.get("proId"));
		ProjectVO projectVO = proDao.selectProject((String)requset.get("proId"));
		if(projectVO!=null) {
			if(!projectVO.isPLMember(realUser)) {
				list3.remove(list3.size()-1);
				list3.remove(list3.size()-1);
				list3.remove(list3.size()-1);
				context.put("project3MenuList", list3);
			}else {
				context.put("project3MenuList", list3);
			}
		}
		
		context.put("project",projectVO);
		context.put("main", main);
		context.put("sessionMenu", menu);
		context.put("project1MenuList", list1);
		context.put("project2MenuList", list2);
		context.put("project4MenuList", list4);
		context.put("realUser", realUser);
		
		
		Map<String,String> urls=new HashMap<String, String>();
		if(list3 != null) {
			for(MenuVO vo : list3) {
				String url = vo.getRescUrl();
				String rescMenu = vo.getRescMenu();
				String[] split = url.split("/");
				urls.put(rescMenu,split[1]);
			}
		}
		context.put("urls", urls);
	}
}









