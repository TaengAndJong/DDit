package kr.or.navi;

import org.springframework.test.context.junit.jupiter.web.SpringJUnitWebConfig;
import org.springframework.transaction.annotation.Transactional;

@SpringJUnitWebConfig(locations = "file:src/main/resources/kr/or/navi/spring/conf/*-context.xml")
@Transactional
public abstract class AbstractRootContextTest {

}