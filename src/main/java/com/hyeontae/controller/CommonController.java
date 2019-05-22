package com.hyeontae.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common")
public class CommonController {
	
	@GetMapping("/error404")
	public void error404() {
	}
	
	@GetMapping("/error403")
	public void error403() {
	}
	
	@GetMapping("/error500")
	public void error500() {
	}
	
	@GetMapping("/error503")
	public void error503() {
	}
	
	@GetMapping("/error400")
	public void error400() {
	}
	
	@GetMapping("/error405")
	public void error405() {
	}
	
	
}
