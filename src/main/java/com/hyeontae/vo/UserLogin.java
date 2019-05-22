package com.hyeontae.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserLogin extends User{

	private static final long serialVersionUID = 1L;
	
	private String userid;
	private String nickname;
	private String email;
	private String birthday;
	private String profile;
	private String autho;
	
	
	public UserLogin(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities,
			String userid, String nickname, String email, String birthday, String profile, String autho) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		this.userid = username;
		this.nickname = nickname;
		this.email = email;
		this.birthday = birthday;
		this.profile = profile;
		this.autho = autho;
	}
	
	
}
