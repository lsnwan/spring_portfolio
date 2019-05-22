package com.hyeontae.security;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.hyeontae.vo.UserLogin;
import com.hyeontae.vo.UserVO;

public class UserAuthenticationService implements UserDetailsService {
	
	@Inject
	SqlSessionTemplate sqlSession;
	
	@Inject
	BCryptPasswordEncoder passwordEncoder;
	
	public UserAuthenticationService() {}
	
	public UserAuthenticationService(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {

		UserVO user = sqlSession.selectOne("user.selectUser", userid);
		
		if(user == null) {
			throw new UsernameNotFoundException(userid);		
		}
		
		List<GrantedAuthority> authority = new ArrayList<>();
		
		authority.add(new SimpleGrantedAuthority(user.getAuthority()));
		
		
		return new UserLogin(user.getUsername(),
						   user.getPassword(),
						   user.getEnabled() == 1,
						   true, true, true, authority,
						   user.getUsername(),
						   user.getNickname(),
						   user.getEmail(),
						   user.getBirthday(),
						   user.getProfile(),
						   user.getAuthority());	
	}

}
