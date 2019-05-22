package com.hyeontae.vo;

import lombok.Data;

@Data
public class UserVO {
	private String username;
	private String password;
	private String nickname;
	private int enabled;
	private String email;
	private String birthday;
	private String profile;
	private String authority;
}
