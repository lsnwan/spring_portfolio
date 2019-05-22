package com.hyeontae.vo;

import lombok.Data;

@Data
public class SignVO {
	
	private String userid;
	private String password;
	private String passwordConfirm;
	private String nickname;
	private String birthday;
	private String email;
	
}
