# 👨‍💻 DDit 프로젝트 아카이브
> **대덕인재개발원 백엔드 정규 과정 프로젝트 모음**
> 본 저장소는 자바 프로그래밍 기본기부터 자바 웹 서블릿 표준 스펙, Model 2(MVC) 아키텍처 기반의 대규모 프로젝트 및 오픈 API/AI 연동까지의 기술적 성장 과정을 담은 포트폴리오 아카이브입니다.

---

## 📂 프로젝트 라인업 요약

| 프로젝트명 | 기획 의도 및 정체성 |  
| :--- | :--- |
| **1. Hotel_Reservation** | 순수 자바와 OOP 원칙을 다지기 위한 CLI 기반 호텔 예약 관리 프로그램 
| `Java 8`, `CLI`, `OOP`,`Oracle` |
| **2. Academic_Management** | 웹 스코프 생명주기를 이해하기 위한 MVC 구조의 학사관리 시스템 
| `JSP/Servlet`, `MyBatis`, `Oracle` |
| **3. NaviRedmine (PMS)** | 기존 Redmine을 벤치마킹한  프로젝트 관리 시스템 
| `Servlet 3.1`, `DBCP2`, `MyBatis`, `AI OpenAPI` |

---

## 1️⃣ firstProject_hotel_Reservation
> **Java CLI 기반의 객체 지향 호텔 예약 관리 시스템**
Java CLI 기반의 객체 지향 호텔 예약 관리를 구현한 시스템 


---

## 2️⃣ secondProject_academic_management
> **JSP / Servlet / MyBatis를 활용한 학사관리 시스템**
자바 웹 표준 서블릿과 JSP를 이용하여 구현한 Model 2(MVC) 아키텍처 중심의 시스템
[포트폴리오 PDF 다운로드](./refDoc/navi_프로젝트 수행계획서_상세.pdf)

- **주요 구현:**
  * **Model 2 (MVC 패턴) 구현:** 화면 출력(JSP)과 비즈니스 통제(Servlet)를 분리하여 서비스 결합도 최적화.
  * **데이터 전달 스코프 제어:** `HttpServletRequest`와 `HttpSession` 스코프를 활용한 안전한 유저 컨텍스트 유지 및 화면 포워딩/리다이렉트 분기 제어.
  * **영속성 레이어 최적화:** `MyBatis` 아키텍처를 결합하여 SQL 매퍼와 엔티티 데이터 간의 데이터 매핑 프로세스 자동화.

---

## 3️⃣ thirdProject_naviRedmine (PMS)

> **Spring Framework와 AI 오픈 API를 활용한 스마트 통합 프로젝트 관리 시스템**
> 본 프로젝트는 기존 Redmine을 벤치마킹하여 협업 및 일감 관리 기능(Gantt Chart, Kanban)을 고도화하고, 화상회의 등 개발자 협업 프로젝트

#### 1. 웹 표준 생명주기 및 순수 Model 2(MVC) 아키텍처 구현
- **서블릿 컨테이너 스펙 제어:** `javax.servlet-api 3.1` 표준 스펙을 바탕으로 Front Controller 패턴을 응용하여, 클라이언트의 요청(Request)과 세션(Session) 스코프 생명주기를 밀착 제어하는 견고한 아키텍처 설계.
- **표준 뷰 딜리버리 구조:** 스크립틀릿(Scriptlet)을 배제하고 `JSTL 1.2` 및 EL 표현식을 활용하여 가독성과 유지보수성이 극대화된 사용자 화면(JSP) 및 커스텀 뷰 매핑 환경 구축.

#### 2. 고성능 데이터 커넥션 및 영속성 레이어 최적화
- **DBCP2 자원 관리:** 대규모 협업 시스템(PMS) 특성에 맞춰 자원의 효율적인 분배를 위해 `Apache Commons DBCP2` 커넥션 풀을 직접 연동 및 관리.
- **MyBatis 매퍼 아키텍처:** 자바 객체(VO)와 SQL 문을 분리하는 `MyBatis 3.5`를 도입하고, 동적 쿼리를 활용한 복잡한 조건별 일감 검색 및 위키/프로젝트 권한 필터링 시스템 구현.
- **SQL 실시간 추적:** 개발 단계에서 발생하는 성능 병목을 예방하기 위해 `log4jdbc-log4j2`를 바인딩하여 실행 SQL 문과 트랜잭션 타임을 명확히 시각화 및 모니터링.

#### 3. 비동기 데이터 통신 및 공통 유틸리티 모듈화
- **Jackson 기반 JSON 마샬링:** REST API(GitHub API, AI Open API 등) 연동 및 비동기 메신저 데이터 교환 시 `Jackson-databind`를 활용해 자바 객체와 JSON 포맷 간의 변환 아키텍처를 추상화.
- **Java 8 날씨/일정 시계열 처리:** 마감일 및 간트차트 일정 관리를 위해 `jackson-datatype-jsr310` 라이브러리를 연동하여, Java 8 `java.time` API 패키지 데이터를 손실 없이 온전하게 직렬화.
- **유효성 검증 공통화:** `Apache Commons Lang3` 및 `BeanUtils`를 결합하여 사용자 입력값(학사/일감/회원 정보)의 Null 방어 코드 및 예외 처리 로직의 생산성 확보.

#### 4. 지속 가능한 품질 관리를 위한 단위 테스트
- **JUnit5 테스트 주도 개발:** 백엔드 비즈니스 서비스 로직의 신뢰성을 보장하기 위해 `JUnit Jupiter Engine` 기반의 단위 테스트(Unit Test) 케이스 검증.

### 🛠 Tech Stack (기술 스택)

#### Backend & Architecture
- **Environment & Standard:** Java 8 (JDK 1.8), Java Web Servlet API 3.1, JSP API 2.2
- **Design Pattern:** Model 2 Architecture (Pure MVC Pattern)
- **Database & ORM:** Oracle Database (OJDBC8), MyBatis 3.5
- **Connection Pool:** Apache Commons DBCP2
- **Data Interchange:** Jackson Databind (JSON Marshalling/Unmarshalling)

#### Libraries & Utilities
- **Boilerplate Control:** Project Lombok
- **Utilities:** Apache Commons Lang3, Commons BeanUtils
- **Logging Engine:** Log4j2, SLF4J, Log4jdbc-log4j2 (SQL 실시간 성능 로깅)
- **Test Framework:** JUnit 5 (Jupiter Engine)

#### Build Tool
- **Dependency Management:** Apache Maven (Compiler 3.8.1, WAR 3.2.3)