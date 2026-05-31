package service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import controller.controller;
import dao.CustomerDAO;
import util.ScanUtil;
import util.View;

public class CustomerService {
	private static CustomerService instance = null;

	private CustomerService() {
	}

	public static CustomerService getInstance() {
		if (instance == null)
			instance = new CustomerService();
		return instance;
	}

	CustomerDAO customerDao = CustomerDAO.getInstance();

	public int signUp() {

		System.out.println("::===============  대덕인재호텔 회원가입   ===============::");
		System.out.print("이름 : ");
		String name = ScanUtil.nextLine();
		System.out.print("전화번호 : ");
		String tell = ScanUtil.nextLine();
		System.out.println("\"20세 이상 가입 가능합니다\"");
		System.out.println("");
		System.out.println("생년월일을  ex)\"19990101\" 으로 8자리 입력하세요");
		System.out.print("생년월일 : ");
		String birthStr = ScanUtil.nextLine();

		try {
			int birth = Integer.parseInt(birthStr.substring(0, 4));

			if (birth > 2004) {
				System.out.println();
				System.out.println("미성년자는 가입할수 없습니다.");
				System.out.println();
				System.out.println("::================================================::");
				System.out.println();
				return View.HOME;
			} else {

				List<Object> param = new ArrayList<>();
				param.add(name);
				param.add(tell);
				param.add(birth);

				int result = customerDao.signUp(param);
				System.out.println();
				System.out.println("회원가입이 완료되었습니다!");
				System.out.println("회원가입  " + result + "건이 완료되었습니다.");
				System.out.println();
				System.out.println("::================================================::");
				System.out.println();
				return View.HOME;
			}
		} catch (StringIndexOutOfBoundsException e) {
			System.out.println();
			System.out.println("***[숫자로 입력해주세요!!]***.");
			System.out.println();
			System.out.println("::================================================::");
			System.out.println();
			return View.HOME;
		}
	}// 회원정보 수정

	public int infoUpdate() {
		if (controller.sessionStorage.get("login") == (Object) false) {
			System.out.println("로그인을 먼저 수행해야합니다.");
			System.out.println();
			System.out.println("::================================================::");
			System.out.println();
			return View.HOME;
		}
		Map<String, Object> map = (Map<String, Object>) controller.sessionStorage.get("loginInfo");
		String cus_tell = (String) map.get("CUS_TEL");

		System.out.println("::===============  대덕인재호텔 회원수정   ===============::");
		String sqlStr = "UPDATE CUSTOMER ";
		sqlStr = sqlStr + "SET ";
		System.out.print("이름을 수정하겠습니까?(y/n)");
		String flag = ScanUtil.nextLine();
		if (flag.equalsIgnoreCase("y")) {
			System.out.println("[변경할 이름을 입력하시오]");
			System.out.print("변경할 이름 : ");
			String name = ScanUtil.nextLine();
			sqlStr = sqlStr + " cus_name = '" + name + "', ";
		} // else if(flag.equalsIgnoreCase("n")) {
		else if (flag.equalsIgnoreCase("n")) {
		} else {
			System.out.println("잘 못된 입력 방식입니다.");
			return View.CUSTOMER;
		}

		System.out.print("전화번호를 수정하겠습니까?(y/n)");
		flag = ScanUtil.nextLine();
		if (flag.equalsIgnoreCase("y")) {
			System.out.println("[변경할 전화번호를 입력하시오]");
			System.out.print("변경할 전화번호 : ");
			String hp = ScanUtil.nextLine();
			sqlStr = sqlStr + " cus_tel = '" + hp + "', ";
		} else if (flag.equalsIgnoreCase("n")) {
			System.out.println();
			System.out.println("회원정보가 수정되었습니다.");
			return View.HOME;
		}  else if (flag.equalsIgnoreCase(cus_tell)) {
			System.out.println();
			System.out.println("잘못된 입력방식입니다.");
			System.out.println();
			System.out.println("::================================================::");
			System.out.println();
			return View.CUSTOMER_UPDATE;

		} else if (isTellExists(cus_tell)) {
			System.out.println();
			System.out.println("이미 존재하는 전화번호입니다.");
			System.out.println();
			System.out.println("::================================================::");
			System.out.println();
			return View.CUSTOMER_UPDATE;
		}

		sqlStr = sqlStr.substring(0, sqlStr.length() - 2);
		sqlStr = sqlStr + " WHERE CUS_TEL = ? ";

		int result = customerDao.update(sqlStr, cus_tell);
		if (result > 0) {
			System.out.println("update가 성공적으로 수행되었습니다...");
		}

		return View.HOME;
	}
	private boolean isTellExists(String tell) {
		Map<String, Object> existingCustomer = customerDao.login("", tell, "");
		return existingCustomer != null;
}
}
