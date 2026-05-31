package util;

public class PrintUtil {
	public static void main(String[] args) {
		printf("|%4o|%10o|%6o|%-8o|", "*", 1000000, "성", "룡", "abc");
	}

	/**
	 * System.out.printf()을 이용하면서 한글 공백처리에 대한 불편함을 개선한 메서드
	 * 
	 * @param format      : System.out.printf() 에 입력하는 format과 비슷한 모양. 단, %{int}o 로
	 *                    입력하여 정수, 문자열을 구분하지 않는다. 음수를 입력하면 좌측정렬, 양수를 입력하면 우측정렬이다.
	 * @param spaceString : 빈 공간을 채워넣을 문자열 입력. null을 입력하면 기본값 " "이 들어간다.
	 * @param args        : format에서 %{int}o 부분을 채워줄 값을 순서대로 입력해야한다.
	 */
	public static void printf(String format, String spaceString, Object... args) {
		if (spaceString == null)
			spaceString = " ";
		String str = "";
		int idx = 0;
		for (int i = 0; i < format.length(); i++) {
			char c = format.charAt(i);
			String f = "";
			if (c == '%') {
				c = format.charAt(++i);
				while (c != 'o' && i < format.length() - 1) {
					f += c;
					c = format.charAt(++i);
				}
				str += formater(args[idx++].toString(), Integer.parseInt(f), spaceString);
			} else {
				str += c;
			}
		}
		System.out.println(str);
	}

	private static String formater(String str, int length, String spaceString) {
		String result = "";
		int s = Math.abs(length);
		for (int i = 0; i < str.length(); i++) {
			if (str.charAt(i) >= 'ㄱ' && str.charAt(i) <= '힇') {
				s -= 2;
			} else {
				s--;
			}
		}
		if (length < 0) {
			result += str;
			result = setSpace(result, s, spaceString);
		} else {
			result = setSpace(result, s, spaceString);
			result += str;
		}
		return result;
	}

	private static String setSpace(String str, int count, String spaceString) {
		for (int i = 0; i < count; i++) {
			str += spaceString;
		}
		return str;
	}

	// 프로그램 시작 인트로
	static public void intro() {
	         String[] team = { "T■","T■", "T■■", "T■■",  "T■■■", "T■■■",  "T■■■E", "T■■■E", "T■■E", "T■■E", "T■E", "T■E", 
	               "TE", "TE", "TE■","TE■","TE■■","TE■■","TE■■■","TE■■■","TE■■■A","TE■■■A","TE■■A","TE■■A","TE■A","TE■A","TEA","TEA",
	               "TEA■","TEA■","TEA■■","TEA■■","TEA■■■M", "TEA■■M", "TEA■■M", "TEA■M", "TEA■M", "TEAM", "TEAM", "TEAM■", 
	               "TEAM■", "TEAM2", "TEAM2","■■■■■", "■■■■■", "TEAM2", "TEAM2","■■■■■", "■■■■■","TEAM2", "TEAM2" };
	         String[] name1 = { "ㄱ","ㄱ", "기","기", "김","김", "김ㅌ","김ㅌ", "김태","김태", "김탱","김탱", "김태으","김태으", "김태은","김태은"};
	         String[] name2 = { "ㅎ","ㅎ", "하","하", "항","항", "하예","하예", "하옞","하옞", "하예조","하예조", "하예종","하예종"};
	         String[] name3 = { "ㅇ","ㅇ", "우","우", "움","움", "우미","우미", "우민","우민", "우민ㄱ","우민ㄱ", "우민규","우민규"};
	         String[] name4 = { "ㄱ","ㄱ","기", "기","김", "김","김ㅊ", "김ㅊ","김차", "김차","김창", "김창","김창ㅇ", "김창ㅇ","김창요", "김창요", "김창용","김창용"};
	         String[] name5 = { "ㄴ", "ㄴ","나", "나","남", "남","남ㅎ", "남ㅎ","남흐", "남흐","남희", "남희","남흿", "남흿", "남희수", "남희수",};
	         int t1 = 0, n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0;
	         String pressEnter = "";
	         for (int i = 0; i < team.length; i++) {
	            String team_1 = "", name_1 = "", name_2 = "", name_3 = "", name_4 = "", name_5 ="";

	            int j = i;
	            if (j > team.length - 1)
	               j = team.length - 1;
	            team_1 = team[j];
	            if (i >= team.length) {
	               if (n1 > name1.length - 1)
	                  n1 = name1.length - 1;
	               name_1 = name1[n1++];
	            }
	            if (i >= team.length + name1.length) {
	               if (n2 > name2.length - 1)
	                  n2 = name2.length - 1;
	               name_2 = name2[n2++];
	            }
	            if (i >= team.length + name1.length + name2.length) {
	               if (n3 > name3.length - 1)
	                  n3 = name3.length - 1;
	               name_3 = name3[n3++];
	            }
	            if (i >= team.length + name1.length + name2.length + name3.length) {
	               if (n4 > name4.length - 1)
	                  n4 = name4.length - 1;
	               name_4 = name4[n4++];
	            }

	            if (i == team.length + name1.length + name2.length + name3.length + name4.length) {
	               if (n5 > name5.length - 1) {
	            	   n5 = name5.length - 1;
		               name_5 = name5[n5++];
	            }
	            if (i == team.length + name1.length + name2.length + name3.length + name4.length - 1 + name_5.length() -1) {
		               Util.wait(100);
		               if (i == team.length - 1) {
		                  Util.wait(100);
	               pressEnter = "엔터를 눌러주세요.";
	               
	            }
	     
	            Util.wait(150);         
	            System.out.println("\n\n::============::>>> 대덕호텔 예약 키오스크 <<<::============::\n");
	            //  System.out.println("\n\n★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★\n");
	            System.out.println("                                     " + "대덕인재호텔에 오신걸 환영합니다.");
	            System.out.println("                                           " + "즐거운 시간 되시길 바랍니다"+'\n');
	            System.out.println();
	            System.out.println("                                               점주 :" + team_1);    //+ "  ◀▤■■■■■▣ ");
	            System.out.println("        " + "MADE BY" + " " + name_1 + "\t" + name_2 + "\t" + name_3 + "\t" + name_4);
	            System.out.println("                       ");
	            System.out.println("                               ");
	            System.out.println("                                 ");
	            System.out.println("                                  ");
	            System.out.println('\t'+"         "+'\t'+""+'\t'+"          제작지원 : 이상철님");
	            System.out.println("::==================================================::\n" + pressEnter);
	         
	            }ScanUtil.nextLine();

}

	         }
	}
}
