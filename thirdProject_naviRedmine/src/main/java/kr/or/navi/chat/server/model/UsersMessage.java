package kr.or.navi.chat.server.model;

import java.util.Set;

/**
 * @Class Name : UsersMessage.java
 * @Description : 사용자 리스트를 담는 VO
 */
public class UsersMessage implements Message {
	/**
	 * 연결되어있는 사용자들
	 */
	private Set<String> users = null;

	public UsersMessage(Set<String> users) {
		this.users = users;
	}

	public Set<String> getUsers() {
		return users;
	}

	public void setUsers(Set<String> users) {
		this.users = users;
	}

}
