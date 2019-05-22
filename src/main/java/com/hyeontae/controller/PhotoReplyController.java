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

import com.hyeontae.service.PhotoReplyService;
import com.hyeontae.service.UserService;
import com.hyeontae.util.Criteria;
import com.hyeontae.vo.PhotoReplyPageDTO;
import com.hyeontae.vo.PhotoReplyVO;
import com.hyeontae.vo.ReplyPageDTO;
import com.hyeontae.vo.ReplyVO;
import com.hyeontae.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/photoReply")
public class PhotoReplyController {

	@Inject
	private PhotoReplyService prService;
	
	@Inject
	private UserService userService;
	
	// 댓글 쓰기
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody PhotoReplyVO vo, Principal principal) {
		log.info("[ 포토 댓글 쓰기 ]");
		
		UserVO user = userService.selectUser(principal.getName());
		Integer no = prService.selectNum();

		vo.setNo(no);
		vo.setNickname(user.getNickname());
		vo.setUserid(user.getUsername());
		vo.setProfile(user.getProfile());
		
		String str = vo.getContent();
		vo.setContent(str.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		
		int resultInsert = prService.create(vo);
		
		log.info("댓글 쓰기 결과: " + resultInsert);
		log.info("[ 포토 댓글 쓰기 End ]");
		
		return resultInsert == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) : 
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	// 목록 가져오기
	@GetMapping(value="/pages/{num}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<PhotoReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("num") String num) {
		log.info("[ 댓글 목록 가져오기 (JSON) ]");
		
		int pageNum = 0;

		if (page == 0 || page == 1) {
			pageNum = 0;
		} else {
			for (int i = 1; i < page; i++) {
				pageNum += 10;
			}
		}

		Criteria cri = new Criteria(pageNum, 10);
		
		return new ResponseEntity<>(prService.getList(cri, num), HttpStatus.OK);
	}
	
	// 특정 댓글 가져오기
	@GetMapping(value="/read/{no}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<PhotoReplyVO> read(@PathVariable("no")String no) {
		log.info("댓글번호: " + no);
		
		PhotoReplyVO reply = prService.get(no);
		
		String str = reply.getContent();
		reply.setContent(str.replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("&nbsp;", " ").replaceAll("<br>", "\n"));
		
		return new ResponseEntity<PhotoReplyVO>(reply, HttpStatus.OK);
	}
	
	// 댓글 수정
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{no}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody PhotoReplyVO vo, @PathVariable("no")String no) {
		log.info("[ 댓글 수정 ]");
		
		PhotoReplyVO reply = prService.get(String.valueOf(vo.getNo()));
		reply.setContent(vo.getContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		
		return prService.update(reply) == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 삭제
	@DeleteMapping(value="/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") String rno) {
		log.info("remove: " + rno);

		return prService.remove(rno) == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) : 
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
