package com.hyeontae.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.hyeontae.vo.UserLogin;

import lombok.extern.log4j.Log4j;

@Log4j
public class UserLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		log.info("로그인 성공");

		UserLogin user = (UserLogin)authentication.getPrincipal();
		System.out.println(user);
		
		List<String> roleNames = new ArrayList<>();
		
		authentication.getAuthorities().forEach(auth -> {
			roleNames.add(auth.getAuthority());
		});
		
		log.warn("ROLE NAMES: " + roleNames);
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/");
			return;
		}
		
		if(roleNames.contains("ROLE_USER")) {
			response.sendRedirect("/");
			return;
		}
	}
	
	
}
