package com.hyeontae.controller;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hyeontae.service.BoardService;
import com.hyeontae.service.PhotoService;
import com.hyeontae.vo.BoardVO;
import com.hyeontae.vo.PhotoVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	
	@Inject
	private BoardService boardService;
	
	@Inject
	private PhotoService photoService;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		List<BoardVO> listBoard = boardService.indexList();
		List<PhotoVO> listPhoto = photoService.getIndexList();
		
		for(int i=0; i<listBoard.size(); i++) {
			String str = listBoard.get(i).getTitle().replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("&nbsp;", " ").replaceAll("<br>", "\n");
			
			listBoard.get(i).setTitle(str);
		}
		
		model.addAttribute("list", listBoard);
		model.addAttribute("photo", listPhoto);
		
		return "index";
	}
	
	@GetMapping("/login")
	public void loginInput() {
		log.info("로그인 페이지");
	}
	
	@PostMapping("/login")
	public void login() {
		log.info("포스트 로그인 페이지");
	}
	
	@PostMapping("/logout")
	public void logout(HttpSession session) {
		session.invalidate();
		log.info("로그아웃페이지");
	}
	
	@GetMapping("/logoutSuccess")
	public void logoutSuccess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.println("<script>"
				+ "alert('로그아웃 되었습니다.');"
				+ "location.href='/';"
				+ "</script>");	
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("Access Denied: " + auth);
		
		model.addAttribute("msg", "접근할 수 없는 페이지 입니다.");
	}
	
	
}
