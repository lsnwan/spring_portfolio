package com.hyeontae.controller;

import java.io.PrintWriter;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hyeontae.service.MessageService;
import com.hyeontae.service.UserService;
import com.hyeontae.util.PageMaker;
import com.hyeontae.vo.MessageVO;
import com.hyeontae.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/message")
public class MessageController {
	
	@Inject
	private UserService userService;
	
	@Inject
	private MessageService messageService;
	
	@GetMapping("/tolist")
	public String list(Principal principal, String pagenum, String contentnum, String type, String keyword, Model model) {
		
		if(principal == null) {
			return "redirect:/login";
		}

		UserVO user = userService.selectUser(principal.getName());
		
		/**
		 * 검색 세팅
		 */
		if(type == null) type = "";
		if(keyword == null) keyword = "";
		Map<String, String> map = new HashMap<>();
		map.put(type, keyword);
		
		/**
		 * 페이지 세팅
		 */
		PageMaker pm = new PageMaker();
		
		if(pagenum == null) pagenum = "1";
		if(contentnum == null) contentnum = "10";
		
		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);
		
		pm.setTotalcount(messageService.getToSize(user.getNickname(), map));
		pm.setPagenum(cpagenum-1);
		pm.setContentnum(ccontentnum);
		pm.setCurrentblock(cpagenum);	
		pm.setLastBlock(pm.getTotalcount());
		
		pm.setStartPage(pm.getCurrentblock());
		pm.setEndPage(pm.getLastblock(), pm.getCurrentblock());
		pm.prevNext(cpagenum);
		
		// 리스트 목록 가져오기
		List<MessageVO> list = messageService.getToList(user.getNickname(), pm.getPagenum()*10, pm.getContentnum(), map);
		
		// 리스트에 한줄로 표시하기 위해 <br>테그를 지움
		for(MessageVO get : list) {
			String str = get.getContent();
			get.setContent(str.replaceAll("<br>", ""));
		}
		
		model.addAttribute("list", list);
		model.addAttribute("page", pm);
		model.addAttribute("pagenum", cpagenum);
		model.addAttribute("total", messageService.getToSize(user.getNickname(), map));
		model.addAttribute("noRead", messageService.noReadToSize(user.getNickname(), map));
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		
		return "/message/tolist";
		
	}
	
	// 쪽지보내기 뷰
	@GetMapping("/send")
	public String send(Principal principal, Model model) {
		
		if(principal == null) {
			return "redirect:/login";
		}
		
		UserVO user = userService.selectUser(principal.getName());
		
		model.addAttribute("to", user.getNickname()); // 내게 쓰기용
		
		return "/message/send";
	}

	// 답장 쓰기 뷰
	@GetMapping("/reSend")
	public String reSend(String no,Principal principal, Model model) {
		
		if(principal == null) {
			return "redirect:/login";
		}
		
		MessageVO message = messageService.getMessage(no);
		
		model.addAttribute("toUser", message.getFromuser());
		
		return "/message/reSend";
	}
	
	// 쪽지 쓰기 처리
	@PostMapping("/send")
	public String sendPost(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, String toUser, String toContent, Principal principal) throws Exception {
		log.info("[쪽지 보내기 POST]");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		UserVO user = userService.selectUser(principal.getName());
		MessageVO message = new MessageVO();
		
		message.setFromuser(user.getNickname());
		message.setTouser(toUser.trim().replaceAll(" ", ""));
		message.setContent(toContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		
		
		// 받는 사람을 검색해서 없는 사람이면 되돌아가기
		if(messageService.isEmptyNick(message.getTouser())) {
			
			redirectAttributes.addFlashAttribute("toUserr", message.getTouser());
			redirectAttributes.addFlashAttribute("toContentr", toContent);
			redirectAttributes.addFlashAttribute("errorMessage", "toError");
			
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		messageService.write(message);
		
		return "redirect:/message/send";
	}
	
	// 새창 쪽지 쓰기 갯
	@GetMapping("/windowSend")
	public String windowWrite(String nick, Principal principal, Model model) {
		if(principal == null) {
			return "redirect:/login";
		}
		
		log.info("새창 닉네임: " + nick);
		
		UserVO user = userService.selectUser(principal.getName());
		
		
		model.addAttribute("nick", nick);
		model.addAttribute("to", user.getNickname());
		
		return "/message/windowSend";
	}
	
	// 새창 쪽지 쓰기 처리
	@PostMapping("/windowSend")
	public void windowWritePost(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, String toUser, String toContent, Principal principal) throws Exception {
		log.info("[쪽지 보내기 POST]");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		UserVO user = userService.selectUser(principal.getName());
		MessageVO message = new MessageVO();
		
		message.setFromuser(user.getNickname());
		message.setTouser(toUser.trim().replaceAll(" ", ""));
		message.setContent(toContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		
		messageService.write(message);
		
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("self.close();");
		pw.println("</script>");
		
	}
	
	// 받은 쪽지 읽기
	@GetMapping("/read")
	public String read(Principal principal, String no, Model model) {

		if(principal == null) {
			return "redirect:/login";
		}
		
		messageService.read(no); // 쪽지 읽음 처리
		MessageVO vo = messageService.getMessage(no);
		
		model.addAttribute("message", vo);
		
		return "/message/read";
		
	}
	
	// 보낸 쪽지 읽기
	@GetMapping("/sendRead")
	public String sendRead(Principal principal, String no, Model model) {
		log.info("[ 보낸 쪽지 내용 보기 ]");
		
		if(principal == null) {
			return "redirect:/login";
		}
		
		MessageVO vo = messageService.getMessage(no);
		
		model.addAttribute("message", vo);
		
		return "/message/sendRead";
	}
	
	// 읽음버튼 처리
	@PostMapping(value = "/readProcess")
	public ResponseEntity<String> readProcess(String[] values) {
		
		int result = 1;
		
		try {
			for(String value : values) {
				messageService.read(value);
			}
			result = 1;
		} catch (Exception e) {
			result = 0;
		}

		return result == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK) 
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);// 500 에러
	}
	
	
	// 받은 쪽지 삭제
	@PostMapping(value = "/todelete")
	public ResponseEntity<String> todelete(String no, String[] values) {
		
		int result = 1;
		
		if(no != null && values == null) {
			log.info("[delete no ]");
			result = messageService.toDelete(no);
		} else {
			log.info("[ delete values ]");			
			for(String value : values) {
				result = messageService.toDelete(value);
			}
		}
		
		return result == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK) 
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);// 500 에러
	}
	
	// 보낸 쪽지 삭제
	@PostMapping(value = "/fromdelete")
	public ResponseEntity<String> fromdelete(String no, String[] values) {
		
		int result = 1;
		
		if(no != null && values == null) {
			log.info("[delete no ]");
			result = messageService.fromDelete(no);
		} else {
			log.info("[ delete values ]");			
			for(String value : values) {
				result = messageService.fromDelete(value);
			}
		}
		
		return result == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK) 
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);// 500 에러
	}
	
	// 보낸 쪽지 목록 보기
	@GetMapping("/sendlist")
	public String sendlist(Principal principal, String pagenum, String contentnum, String type, String keyword, Model model) {
		log.info("[ 보낸 쪽지함 ]");
		
		if(principal == null) {
			return "redirect:/login";
		}

		UserVO user = userService.selectUser(principal.getName());
		
		/**
		 * 검색 세팅
		 */
		if(type == null) type = "";
		if(keyword == null) keyword = "";
		Map<String, String> map = new HashMap<>();
		map.put(type, keyword);
		
		/**
		 * 페이지 세팅
		 */
		PageMaker pm = new PageMaker();
		
		if(pagenum == null) pagenum = "1";
		if(contentnum == null) contentnum = "10";
		
		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);
		
		pm.setTotalcount(messageService.getFromSize(user.getNickname(), map));
		pm.setPagenum(cpagenum-1);
		pm.setContentnum(ccontentnum);
		pm.setCurrentblock(cpagenum);	
		pm.setLastBlock(pm.getTotalcount());
		
		pm.setStartPage(pm.getCurrentblock());
		pm.setEndPage(pm.getLastblock(), pm.getCurrentblock());
		pm.prevNext(cpagenum);
		
		// 리스트 목록 가져오기
		List<MessageVO> list = messageService.getFromList(user.getNickname(), pm.getPagenum()*10, pm.getContentnum(), map);
		
		// 리스트에 한줄로 표시하기 위해 <br>테그를 지움
		for(MessageVO get : list) {
			String str = get.getContent();
			get.setContent(str.replaceAll("<br>", ""));
		}
		
		model.addAttribute("list", list);
		model.addAttribute("page", pm);
		model.addAttribute("pagenum", cpagenum);
		model.addAttribute("total", messageService.getFromSize(user.getNickname(), map));
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		
		
		return "/message/sendlist";
	}
	
	// 발송 취소 처리 Ajax
	@PostMapping("/sendCancel")
	public ResponseEntity<String> sendCancel(String no) {
		log.info("[ 발송 취소하기 처리 ]");
		log.info("no: " + no);
		
		int result = messageService.sendCancel(no);
		
		return result == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK) 
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 내게 쓰기
	@GetMapping("/tomelist")
	public String tomelist(Principal principal, String pagenum, String contentnum, String type, String keyword, Model model) {
		
		if(principal == null) {
			return "redirect:/login";
		}
		
		UserVO user = userService.selectUser(principal.getName());
		
		/**
		 * 검색 세팅
		 */
		if(type == null) type = "C";
		if(keyword == null) keyword = "";
		Map<String, String> map = new HashMap<>();
		map.put(type, keyword);
		
		/**
		 * 페이지 세팅
		 */
		PageMaker pm = new PageMaker();
		
		if(pagenum == null) pagenum = "1";
		if(contentnum == null) contentnum = "10";
		
		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);
		
		pm.setTotalcount(messageService.getToMeSize(user.getNickname(), map));
		pm.setPagenum(cpagenum-1);
		pm.setContentnum(ccontentnum);
		pm.setCurrentblock(cpagenum);	
		pm.setLastBlock(pm.getTotalcount());
		
		pm.setStartPage(pm.getCurrentblock());
		pm.setEndPage(pm.getLastblock(), pm.getCurrentblock());
		pm.prevNext(cpagenum);
		
		// 리스트 목록 가져오기
		List<MessageVO> list = messageService.getToMeList(user.getNickname(), pm.getPagenum()*10, pm.getContentnum(), map);
		
		// 리스트에 한줄로 표시하기 위해 <br>테그를 지움
		for(MessageVO get : list) {
			String str = get.getContent();
			get.setContent(str.replaceAll("<br>", ""));
		}
		
		model.addAttribute("list", list);
		model.addAttribute("page", pm);
		model.addAttribute("pagenum", cpagenum);
		model.addAttribute("total", messageService.getToMeSize(user.getNickname(), map));
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		
		return "/message/tomelist";
	}
	
	// 내게 쓴 글 읽기
	@GetMapping("/tomeRead")
	public String tomeRead(Principal principal, String no, Model model) {
		log.info("[ 보낸 쪽지 내용 보기 ]");
		
		if(principal == null) {
			return "redirect:/login";
		}
		
		MessageVO vo = messageService.getMessage(no);
		
		model.addAttribute("message", vo);
		
		return "/message/tomeRead";
	}
	
	// 내게 쓴 쪽지 삭제
	@PostMapping(value = "/tomedelete")
	public ResponseEntity<String> tomeDelete(String no, String[] values) {
		
		int result = 0;
		
		if(no != null && values == null) {
			result = messageService.toDelete(no);
		} else {
			for(String value : values) {
				result = messageService.toDelete(value);
			}
		}
		
		return result == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);// 500 에러
	}
	
}
