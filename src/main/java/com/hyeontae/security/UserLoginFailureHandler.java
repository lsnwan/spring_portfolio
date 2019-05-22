package com.hyeontae.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserLoginFailureHandler implements AuthenticationFailureHandler{
	
	private String loginidname;
    private String loginpwdname;
    private String errormsgname;
    private String defaultFailureUrl;

	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		System.out.println("로그인 실패");
		
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        String errormsg = null;
        
        if(exception instanceof BadCredentialsException) {
            errormsg = "아이디나 비밀번호가 맞지 않습니다.";
        } else if(exception instanceof InternalAuthenticationServiceException) {
            errormsg = "아이디나 비밀번호가 맞지 않습니다.";
        } else if(exception instanceof DisabledException) {
            errormsg = "휴먼계정이거나 탈퇴한 회원입니다. 관리자에게 문의하세요.";
        }

        
		request.setAttribute("userid", username);
		request.setAttribute("password", password);
		request.setAttribute(errormsgname, errormsg);
		request.setAttribute("error", "true");
		
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
		
	}

}
