package kr.or.navi.common.preparer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerMapping;

import kr.or.navi.common.preparer.dao.ResourceDAO;
import kr.or.navi.mapper.dao.EmpDAO;
import kr.or.navi.security.EmpVOWrapper;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.MenuVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Preparer("mypagePreparer")
public class MypageMenuViewPreparer implements ViewPreparer {
    @Inject
    ResourceDAO dao;

    @Inject
    private EmpDAO empDao;

    @Override
    public void execute(Request req, AttributeContext ctx) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        EmpVOWrapper principal = (EmpVOWrapper) authentication.getPrincipal();
        EmpVO realUser = principal.getRealUser();
        String menu = realUser.getEmpName() + " (" + realUser.getDeptName() + ")";
        // 메인 메뉴 목록을 가져옴
        List<MenuVO> main = dao.selectMainList();
        // 각 카테고리에 해당하는 마이페이지 메뉴 목록을 가져옴
        List<MenuVO> list = dao.selectMyPageList("1");
        List<MenuVO> list2 = dao.selectMyPageList("2");
        List<MenuVO> list3 = dao.selectMyPageList("3");
        // 요청된 컨텍스트에서 맵 객체를 가져옴
        Map<String, Object> context = req.getContext(Request.REQUEST_SCOPE);
        
        // 요청된 URL에서 empId 변수를 가져와서 해당하는 직원의 정보를 가져옴
        Map request = (Map) context.get(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
        log.info("requestUrl : {}", request.get("empId"));
        EmpVO empVO = empDao.selectOne((String)request.get("empId"));
        // 컨텍스트에 직원정보, 메인, 세션메뉴, 카테고리1, 2, 3 추가함
        context.put("emp", empVO);
        context.put("main", main);
        context.put("sessionMenu", menu);
        context.put("mypageMenuList", list);
        context.put("mypage2MenuList", list2);
        context.put("mypage3MenuList", list3);
        context.put("realUser", realUser);
        // 3번 카테고리 메뉴 목록이 비어있지 않으면
        Map<String,String> urls=new HashMap<>();
        if(list3 != null) {
            // 각 메뉴의 URL과 메뉴명을 추출하여 맵에 추가함
            for(MenuVO vo : list3) {

                // ex) /board를 포함하는 애들만 3차메뉴가 나오게 함. contains 사용
				// url /board가 포함된 url만 찾아서 나오게 하면 새로운 맵에 넣는다.
                
                String url = vo.getRescUrl();
                String rescMenu = vo.getRescMenu();
                String[] split = url.split("/");
                urls.put(rescMenu,split[1]);
            }
        }
        // 컨텍스트에 URL 맵을 추가함
        context.put("urls", urls);
    }
}