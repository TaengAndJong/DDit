package kr.or.navi.login.service;

import java.util.Map;
import java.util.Properties;

import javax.inject.Inject;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import kr.or.navi.login.dao.LoginDAO;
import kr.or.navi.mail.ServerKind;
import kr.or.navi.mail.ServerKind.ServerSpec;
import kr.or.navi.vo.EmpVO;
@Service
public class LoginServiceImpl implements LoginService {
	@Inject
	private LoginDAO dao;
	
	@Override
	public Map<String, String> checkAuthEmpId(EmpVO emp) {
		Map<String, String> resultMap = new HashedMap();
		String empName = emp.getEmpName();
		String empRrno = emp.getEmpRrno();
		EmpVO checkEmp = dao.selectEmpRrno(empName,empRrno);
		String from = checkEmp.getEmpMail();
		String empId = checkEmp.getEmpId();
		if(checkEmp!=null) {
			sendMail(from, empId,empName);
			resultMap.put("msg", "ok");
		}else {
			resultMap.put("msg", "fail");
		}
		return resultMap;
	}
	public void sendMail(String to, String empId,String empName) {
		ServerSpec mailServer = ServerKind.GMAIL.getSmtp();
		String username = "rlftkd9@gmail.com";
		String password = "vagq rtzb mxhk oqnx";
		String from = "navi@navimine.com";
		// 1) MailSender 기본 설정
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost(mailServer.getHost());
		mailSender.setPort(mailServer.getPort());
		mailSender.setUsername(username);
		mailSender.setPassword(password);
		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", true);
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		mailSender.setJavaMailProperties(props);
		// 2) javax.mail.internet.MimeMessage 객체를 직접 생성하기 위해
		// MimeMessagePreparator를 콜백 인터페이스로 사용한다.
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				mimeMessage.setFrom(new InternetAddress(from));
				mimeMessage.setRecipients(RecipientType.TO, to);
				mimeMessage.setSubject("[NAVI MINE] 사원번호 입니다.");
				StringBuffer html = new StringBuffer();
				html.append("<div style=\"max-width:640px;margin:0 auto;box-shadow:0px 1px 5px rgba(0,0,0,0.1);border-radius:4px;overflow:hidden\">\r\n"
						+ "    <div style=\"margin:0px auto;max-width:640px;background:#ffffff;\">\r\n"
						+ "        <table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size:0px;width:100%;background:#ffffff;\" border=\"0\">\r\n"
						+ "            <tbody>\r\n"
						+ "                <tr>\r\n"
						+ "                    <td style=\"text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:40px 50px;\">\r\n"
						+ "                        <div style=\"vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;\">\r\n"
						+ "                            <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n"
						+ "                                <tbody>\r\n"
						+ "                                    <tr>\r\n"
						+ "                                        <td align=\"left\" style=\"word-break:break-word;font-size:0px;padding:0px;\">\r\n"
						+ "                                            <div style=\"cursor:auto;color:#737F8D;font-family:Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px;line-height:24px;text-align:left;\">\r\n"
						+ "\r\n														<strong>NaviMine</stroing>"												
						+ "                                                <h2 style=\"font-family: Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-weight: 500;font-size: 20px;color: #4F545C;letter-spacing: 0.27px;\">\r\n"
						+ "                                                    "+empName+" 님, 안녕하세요.</h2>\r\n"
						+ "                                                <p> "+empName+" 님의 사원번호는 <strong>"+empId+"</strong> 입니다.</p>\r\n"
						+ "                                                \r\n"
						+ "                                                \r\n"
						+ "\r\n"
						+ "                                            </div>\r\n"
						+ "                                        </td>\r\n"
						+ "                                    </tr>\r\n"
						+ "                                    \r\n"
						+ "                                    <tr>\r\n"
						+ "                                        <td style=\"word-break:break-word;font-size:0px;padding:30px 0px;\">\r\n"
						+ "                                            <p style=\"font-size:1px;margin:0px auto;border-top:1px solid #DCDDDE;width:100%;\">\r\n"
						+ "                                            </p>\r\n"
						+ "                                        </td>\r\n"
						+ "                                    </tr>\r\n"
						+ "                                    \r\n"
						+ "                                </tbody>\r\n"
						+ "                            </table>\r\n"
						+ "                        </div>\r\n"
						+ "                    </td>\r\n"
						+ "                </tr>\r\n"
						+ "            </tbody>\r\n"
						+ "        </table>\r\n"
						+ "    </div>\r\n"
						+ "    \r\n"
						+ "</div>");
				mimeMessage.setContent(html.toString(), "text/html;charset=UTF-8");
				
			}
		};
		// 3) 전송시 콜백 객체를 send 메소드에 인자로 넘긴다.
		mailSender.send(preparator);
		
	}
	@Override
	public Map<String, String> checkAuthEmpPs(EmpVO emp) {
		Map<String, String> resultMap = new HashedMap();
		String empId = emp.getEmpId();
		String empName = emp.getEmpName();
		String empRrno = emp.getEmpRrno();
		EmpVO checkEmp = dao.selectEmpPs(empName,empRrno,empId);
		String from = checkEmp.getEmpMail();
		String empPass = checkEmp.getEmpPass();
		if(checkEmp!=null) {
			sendPassMail(from, empPass,empName);
			resultMap.put("msg", "ok");
		}else {
			resultMap.put("msg", "fail");
		}
		return resultMap;
	}
	public void sendPassMail(String to, String empPass,String empName) {
		ServerSpec mailServer = ServerKind.GMAIL.getSmtp();
		String username = "rlftkd9@gmail.com";
		String password = "vagq rtzb mxhk oqnx";
		String from = "navi@navimine.com";
		// 1) MailSender 기본 설정
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost(mailServer.getHost());
		mailSender.setPort(mailServer.getPort());
		mailSender.setUsername(username);
		mailSender.setPassword(password);
		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", true);
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		mailSender.setJavaMailProperties(props);
		// 2) javax.mail.internet.MimeMessage 객체를 직접 생성하기 위해
		// MimeMessagePreparator를 콜백 인터페이스로 사용한다.
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				mimeMessage.setFrom(new InternetAddress(from));
				mimeMessage.setRecipients(RecipientType.TO, to);
				mimeMessage.setSubject("[NAVI MINE] 비밀번호 입니다.");
				StringBuffer html = new StringBuffer();
				html.append("<div style=\"max-width:640px;margin:0 auto;box-shadow:0px 1px 5px rgba(0,0,0,0.1);border-radius:4px;overflow:hidden\">\r\n"
						+ "    <div style=\"margin:0px auto;max-width:640px;background:#ffffff;\">\r\n"
						+ "        <table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size:0px;width:100%;background:#ffffff;\" border=\"0\">\r\n"
						+ "            <tbody>\r\n"
						+ "                <tr>\r\n"
						+ "                    <td style=\"text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:40px 50px;\">\r\n"
						+ "                        <div style=\"vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;\">\r\n"
						+ "                            <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n"
						+ "                                <tbody>\r\n"
						+ "                                    <tr>\r\n"
						+ "                                        <td align=\"left\" style=\"word-break:break-word;font-size:0px;padding:0px;\">\r\n"
						+ "                                            <div style=\"cursor:auto;color:#737F8D;font-family:Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px;line-height:24px;text-align:left;\">\r\n"
						+ "\r\n														<strong>NaviMine</stroing>"												
						+ "                                                <h2 style=\"font-family: Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-weight: 500;font-size: 20px;color: #4F545C;letter-spacing: 0.27px;\">\r\n"
						+ "                                                    "+empName+" 님, 안녕하세요.</h2>\r\n"
						+ "                                                <p> "+empName+" 님의 비밀번호는 <strong>"+empPass+"<strong> 입니다.</p>\r\n"
						+ "                                                \r\n"
						+ "                                                \r\n"
						+ "\r\n"
						+ "                                            </div>\r\n"
						+ "                                        </td>\r\n"
						+ "                                    </tr>\r\n"
						+ "                                    \r\n"
						+ "                                    <tr>\r\n"
						+ "                                        <td style=\"word-break:break-word;font-size:0px;padding:30px 0px;\">\r\n"
						+ "                                            <p style=\"font-size:1px;margin:0px auto;border-top:1px solid #DCDDDE;width:100%;\">\r\n"
						+ "                                            </p>\r\n"
						+ "                                        </td>\r\n"
						+ "                                    </tr>\r\n"
						+ "                                    \r\n"
						+ "                                </tbody>\r\n"
						+ "                            </table>\r\n"
						+ "                        </div>\r\n"
						+ "                    </td>\r\n"
						+ "                </tr>\r\n"
						+ "            </tbody>\r\n"
						+ "        </table>\r\n"
						+ "    </div>\r\n"
						+ "    \r\n"
						+ "</div>");
				mimeMessage.setContent(html.toString(), "text/html;charset=UTF-8");
				
			}
		};
		// 3) 전송시 콜백 객체를 send 메소드에 인자로 넘긴다.
		mailSender.send(preparator);
		
	}

}
