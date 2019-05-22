package com.hyeontae.controller;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hyeontae.service.ReplyService;
import com.hyeontae.service.UserService;
import com.hyeontae.util.Criteria;
import com.hyeontae.util.PageMaker;
import com.hyeontae.vo.ReplyPageDTO;
import com.hyeontae.vo.ReplyVO;
import com.hyeontae.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/replies")
public class ReplyController {
	
	@Inject
	public ReplyService replyService;
	
	@Inject
	public UserService userService;
	
	// 댓글 쓰기
	@PostMapping(value = "/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo, Principal principal) {
		
		Integer rno = replyService.selectNum();
		UserVO user = userService.selectUser(principal.getName());
		String reply = vo.getReply();
		
		vo.setRno(rno);
		vo.setRef(rno);
		vo.setReplyer(user.getNickname());
		vo.setUserid(user.getUsername());
		vo.setProfile(user.getProfile());
		vo.setReply(reply.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		
		log.info("ReplyVO: " + vo);
		
		int resultInsert = replyService.register(vo);
		
		
		return resultInsert == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) : 
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	
	// 댓글 가져오기
	@GetMapping(value = "/pages/{num}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("num") Long num) {
		
		log.info("getList........................");
		
		int pageNum = 0;
		
		if(page == 0 || page == 1) {
			pageNum = 0;
		} else {
			for(int i=1; i<page; i++) {
				pageNum+=10;
			}
		}
		
		Criteria cri = new Criteria(pageNum,10);
		
		return new ResponseEntity<>(replyService.getListPage(cri, num), HttpStatus.OK);
	}
	
	// 댓글 삭제
	@DeleteMapping(value="/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
		log.info("remove: " + rno);

		return replyService.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 특정 댓글 가져오기
	@GetMapping(value="/read/{rno}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> read(@PathVariable("rno")Long rno) {
		
		log.info("read: " + rno);
		
		ReplyVO reply = replyService.read(rno);
		String reply_string = reply.getReply().replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("&nbsp;", " ").replaceAll("<br>", "\n");
		reply.setReply(reply_string);
		
		log.info(reply);
		
		return new ResponseEntity<>(reply, HttpStatus.OK);
	}
	
	
	// 댓글 수정
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{rno}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo,@PathVariable("rno")Long rno) {

		String reply_string = vo.getReply().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>");
		vo.setReply(reply_string);
		vo.setRno(rno.intValue());
		
		log.info("---댓글번호: " + rno);
		
		return replyService.modify(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글에 답변 달기
	@PostMapping(value = "/reply",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> reply(@RequestBody ReplyVO vo, Principal principal) {
		log.info("댓글에 답변 달기");
		log.info("ReplyVO : " + vo);

		UserVO userVO = userService.selectUser(principal.getName());
		
		Integer newRno = replyService.selectNum();
		
		replyService.replyUpPos(vo.getRef(), vo.getPos());

		ReplyVO newReply = new ReplyVO();
		
		newReply.setRno(newRno);
		newReply.setNum(vo.getNum());
		newReply.setPos(vo.getPos()+1);
		newReply.setRef(vo.getRef());
		newReply.setDepth(vo.getDepth()+1);
		newReply.setReplyer(userVO.getNickname());
		newReply.setReply(vo.getReply());
		newReply.setUserid(userVO.getUsername());
		newReply.setProfile(userVO.getProfile());
		
		log.info("====================================================");
		log.info("바뀐 ReplyVO : " + newReply);
		
		
		return replyService.replyReply(newReply) == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) : 
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
