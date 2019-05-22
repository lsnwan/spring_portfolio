package com.hyeontae.controller;

import java.security.Principal;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hyeontae.service.PhotoReplyAndReplyService;
import com.hyeontae.service.PhotoReplyService;
import com.hyeontae.service.UserService;
import com.hyeontae.util.Criteria;
import com.hyeontae.vo.PhotoReplyAndReplyPageDTO;
import com.hyeontae.vo.PhotoReplyAndReplyVO;
import com.hyeontae.vo.PhotoReplyPageDTO;
import com.hyeontae.vo.PhotoReplyVO;
import com.hyeontae.vo.ReplyPageDTO;
import com.hyeontae.vo.ReplyVO;
import com.hyeontae.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/photoReplyAndReply")
public class PhotoReplyAndReplyController {

	@Inject
	private PhotoReplyAndReplyService prService;
	
	@Inject
	private UserService userService;
	
	// 댓글 쓰기
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody PhotoReplyAndReplyVO vo, Principal principal) {
		log.info("[ 포토 댓글의 답글 쓰기 ]");
		
		int resultInsert = 0;
		int r_no = prService.selectNum();
		
		UserVO user = userService.selectUser(principal.getName());
		
		String str = vo.getContent();
		vo.setContent(str.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		vo.setR_no(r_no);
		vo.setNickname(user.getNickname());
		vo.setUserid(user.getUsername());
		vo.setProfile(user.getProfile());
		
		resultInsert = prService.insert(vo);
		
		log.info("[ 포토 댓글 쓰기 End ]");
		
		return resultInsert == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) : 
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
		
	
	// 목록 가져오기
	@GetMapping(value="/pages/{num}/{no}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<PhotoReplyAndReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("num") String num,
			@PathVariable("no") String no) {
		log.info("[ 답글 목록 가져오기 (JSON) ]");
		
		int pageNum = 0;
		
		if (page == 0 || page == 1) {
			pageNum = 0;
		} else {
			for (int i = 1; i < page; i++) {
				pageNum += 10;
			}
		}

		Criteria cri = new Criteria(pageNum, 10);
		
		return new ResponseEntity<>(prService.getList(cri, num, no), HttpStatus.OK);
	}
	
	
	// 특정 답글 가져오기
	@GetMapping(value="/read/{r_no}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<PhotoReplyAndReplyVO> read(@PathVariable("r_no")String r_no) {
		log.info("[특정 댓글 가져오기 ]");
		
		PhotoReplyAndReplyVO reply = prService.getReply(r_no);
		
		String str = reply.getContent();
		reply.setContent(str.replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("&nbsp;", " ").replaceAll("<br>", "\n"));
		
		return new ResponseEntity<PhotoReplyAndReplyVO>(reply, HttpStatus.OK);
	}
	
	
	// 답글 수정
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{r_no}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody PhotoReplyAndReplyVO vo, @PathVariable("r_no")String r_no) {
		
		PhotoReplyAndReplyVO reply = prService.getReply(r_no);
		reply.setContent(vo.getContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		
		return prService.update(reply) == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 답글 삭제
	@DeleteMapping(value="/{r_no}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("r_no") String r_no) {
		log.info("remove: " + r_no);
		
		return prService.remove(r_no) == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) : 
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
