package com.hyeontae.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hyeontae.service.BoardService;
import com.hyeontae.service.ReplyService;
import com.hyeontae.service.UserService;
import com.hyeontae.util.FileUploadUtil;
import com.hyeontae.util.PageMaker;
import com.hyeontae.vo.BoardUploadVO;
import com.hyeontae.vo.BoardVO;
import com.hyeontae.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {

	@Inject
	ServletContext servletContext;
	
	@Inject
	private UserService userService;
	
	@Inject
	private BoardService boardService;
	
	@Inject
	private ReplyService replyService;
	
	@GetMapping("/list")
	public String list(String pagenum, String contentnum, String type, String keyword, Model model) {
		
		PageMaker pagemaker = new PageMaker();
		
		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);
		
		pagemaker.setTotalcount(boardService.boardCount(type, keyword)); // 검색 후 전체 게시글 수			
		
		pagemaker.setPagenum(cpagenum-1);					// 현재페이지, sql에서 limit 0에 해당함
		pagemaker.setContentnum(ccontentnum);				// 한 페이지에 총 몇개씩 보일지 수
		pagemaker.setCurrentblock(cpagenum);				// 현재 페이지 블럭이 몇번인지 현재 페이지 번호를 통해서 지정
		pagemaker.setLastBlock(pagemaker.getTotalcount());	// 마지막 블럭 번호를 전체 게시글 수를 통해서 정함
		
		pagemaker.setStartPage(pagemaker.getCurrentblock()); // 시작 페이지를 페이지 블럭 번호를 정한다.
		pagemaker.setEndPage(pagemaker.getLastblock(), pagemaker.getCurrentblock()); // 마지막 페이지를 마지막 페이지 블럭과 현재 페이지 블럭 번호로 정한다.
		pagemaker.prevNext(cpagenum);	// 현재 페이지 번호로 화살표를 나타낼지 
		
		
		List<BoardVO> list = new ArrayList<>();
			
		list = boardService.getList(pagemaker.getPagenum()*10, pagemaker.getContentnum(), type, keyword);
		
		model.addAttribute("list", list);
		model.addAttribute("page", pagemaker);
		model.addAttribute("pagenum", cpagenum);
		model.addAttribute("contentnum", ccontentnum);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		
		return "/board/list";
	}
	
	
	@GetMapping("/write")
	public String write(Principal principal, String pagenum,String type,String keyword, String content, String contentnum, Model model) {
		
		if(principal == null) {
			return "redirect:/login";
		}
		
		log.info("type: " + type);
		log.info("content: " + content);
		
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pagenum", pagenum);
		model.addAttribute("contentnum", contentnum);
		
		return "/board/write";
		
	}
	
	
	@PostMapping("/write")
	public String writePost(MultipartFile[] files, String title, String type, String keyword, String content, String pagenum, String contentnum, Principal principal) throws Exception {

		UserVO userVO = userService.selectUser(principal.getName());
		
		BoardVO boardVO = new BoardVO();
		BoardUploadVO boardUploadVO = new BoardUploadVO();
		FileUploadUtil upload = new FileUploadUtil();
		
		// 새로 갱신할 게시글 num 가져오기
		Integer num = boardService.selectNum();

		// 파일 경로
		String rootPath = servletContext.getRealPath("/resources/board/"+num+"/");
		log.info(rootPath);
		
		boardVO.setNum(num);
		boardVO.setTitle(title.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		boardVO.setContent(content);
		boardVO.setNickname(userVO.getNickname());
		boardVO.setRef(num);
		boardVO.setUserid(userVO.getUsername());
		boardVO.setProfile(userVO.getProfile());
		
		boardUploadVO.setNum(num);
		boardUploadVO.setNickname(userVO.getNickname());
		
		boardService.boardWrite(boardVO);
		
		for(int i=1; i < files.length; i++) {
			
			if(files[i].getOriginalFilename().equals("")) {
				continue;
			}
			
			UUID uuid = UUID.randomUUID();
			String saveName = uuid.toString() + "_" + files[i].getOriginalFilename();
			boardUploadVO.setFilename(saveName);
			boardUploadVO.setFilesize((int)files[i].getSize());
			
			// sql 파일 정보 저장
			boardService.boardUpload(boardUploadVO);
	
			// 파일 저장
			upload.boardUpload(saveName, rootPath, files[i].getBytes());
			
		}

		return "redirect:/board/list?type=" + type + "&keyword=" + keyword + "&pagenum="+ 1 + "&contentnum=" + contentnum;
	}
	
	
	@PostMapping("/modify")
	public String postModify(MultipartFile[] files, String title, String content, String num, String type, String keyword, String pagenum, String contentnum, Principal principal) throws Exception {
		
		UserVO userVO = userService.selectUser(principal.getName());
		
		BoardVO boardVO = new BoardVO();
		BoardUploadVO boardUploadVO = new BoardUploadVO();
		FileUploadUtil upload = new FileUploadUtil();
		
		// 파일 경로
		String rootPath = servletContext.getRealPath("/resources/board/"+num+"/");
		
		boardVO.setNum(Integer.parseInt(num));
		boardVO.setTitle(title.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		boardVO.setContent(content);

		boardService.boardUpdate(boardVO);

		boardUploadVO.setNum(Integer.parseInt(num));
		boardUploadVO.setNickname(userVO.getNickname());
		
		for(int i=1; i < files.length; i++) {
			
			if(files[i].getOriginalFilename().equals("")) {
				continue;
			}
			
			UUID uuid = UUID.randomUUID();
			String saveName = uuid.toString() + "_" + files[i].getOriginalFilename();
			boardUploadVO.setFilename(saveName);
			boardUploadVO.setFilesize((int)files[i].getSize());
			
			// sql 파일 정보 저장
			boardService.boardUpload(boardUploadVO);
	
			// 파일 저장
			upload.boardUpload(saveName, rootPath, files[i].getBytes());
			
		}
		
		return "redirect:/board/get?num=" + num + "&type=" + type + "&keyword=" + keyword + "&pagenum=" + pagenum + "&contentnum=" + contentnum;
	}
	
	
	
	
	@GetMapping("/get")
	public void get(@RequestParam("num") Long num, String type, String keyword, String pagenum, String contentnum, Model model) {
		
		List<BoardUploadVO> list = new ArrayList<>();
		list = boardService.boardGetUpload(num.intValue());
		
		// 댓글 총 갯수
		int totalCount = replyService.totalCount(num);
		
		// 업로드 된 파일 확인
		for(int i=0; i<list.size(); i++) {
			String filename = list.get(i).getFilename();
			int filesize = list.get(i).getFilesize();
			
			filename = filename.substring(filename.indexOf("_")+1, filename.length());
			filesize = filesize/1024;
			
			list.get(i).setFilesize(filesize);
			list.get(i).setSubFileName(filename);
						
		}
		
		// 조회수 증가
		boardService.viewsUp(num.intValue());
		
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pagenum", pagenum);
		model.addAttribute("contentnum", contentnum);
		model.addAttribute("board", boardService.get(num.intValue()));
		model.addAttribute("upload", list);
		model.addAttribute("totalReplyCount", totalCount);
	}
	
	@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent")String userAgent, String num, String fileName) {
		
		log.info("download File: " + fileName);
		log.info("userAgent: " + userAgent);
		
		Resource resource = new FileSystemResource("/resources/board/"+num+"/" + fileName);
		
		log.info("resource: " + resource);
		
		String resourceName = resource.getFilename();
		log.info("resourceName: " + resourceName);
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1, resourceName.length());
		log.info("resourceOriginalName: " + resourceOriginalName);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
				log.info("downloadName: " + downloadName);
			} else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			} else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
				
			}
			
			log.info("downloadName: " + downloadName);
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		
	}
	
	@GetMapping("/modify")
	public void modify(String num, String type, String keyword, String pagenum, String contentnum, Model model) {
		
		BoardVO board = new BoardVO();
		board = boardService.get(Integer.parseInt(num));
		
		int uploadCount = boardService.uploadCount(num);
		
		List<BoardUploadVO> list = new ArrayList<>();
		list = boardService.boardGetUpload(Integer.parseInt(num));
		
		for(int i=0; i<list.size(); i++) {
			String filename = list.get(i).getFilename();
			int filesize = list.get(i).getFilesize();
			
			filename = filename.substring(filename.indexOf("_")+1, filename.length());
			filesize = filesize/1024;

			list.get(i).setFilesize(filesize);
			list.get(i).setSubFileName(filename);
		}
		
		model.addAttribute("upload", list);
		model.addAttribute("board", board);
		model.addAttribute("uploadCount", uploadCount);
		model.addAttribute("num", num);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pagenum", pagenum);
		model.addAttribute("contentnum", contentnum);
	}
	
	@PostMapping("/fileDelete")
	@ResponseBody
	public String fileDelete(@RequestParam("filename")String filename, @RequestParam("userid") String userid, @RequestParam("num") String num) {
		
		String rootPath = servletContext.getRealPath("/resources/board/"+num+"/");
		
		File[] listFile = new File(rootPath).listFiles();
		
		try {
			if(listFile.length > 0){
				for(int i = 0 ; i < listFile.length ; i++){
					if(listFile[i].getName().equals(filename)) {
						
						listFile[i].delete();
						boardService.deleteFile(Integer.parseInt(num), filename);
						
						return "1";
					}
				}
				return "-1";
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "0";
	
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String postDelete(@RequestParam("num") String num) {
		log.info("delete Ajax 입니다.");
		
		if(boardService.selectAvailable(Integer.parseInt(num)) == 0) {
			return "-1";
		}
		
		boardService.boardDelete(Integer.parseInt(num));
		
		return "1";
	}
	
	@GetMapping("/reply")
	public void reply(String num, String type, String keyword, String pagenum, String contentnum, Model model) {
		log.info("답변 갯방식");
		
		BoardVO board = boardService.get(Integer.parseInt(num));
		
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("board", board);
		model.addAttribute("pagenum", pagenum);
		model.addAttribute("contentnum", contentnum);
	}
	
	@PostMapping("/reply")
	public String postReply(MultipartFile[] files, String title, String content, String pagenum, String type, String keyword,
			String contentnum, Principal principal, int pos, int ref, int depth) throws Exception {
		log.info("답변 포스트방식");
		
		if(principal == null) return "redirect:/login";
		
		UserVO userVO = userService.selectUser(principal.getName());
		
		BoardVO boardVO = new BoardVO();
		BoardUploadVO boardUploadVO = new BoardUploadVO();
		FileUploadUtil upload = new FileUploadUtil();
		
		Integer num = boardService.selectNum();
		
		// pos값 증가
		boardService.replyUpPos(ref, pos);
		
		// 파일 경로
		String rootPath = servletContext.getRealPath("/resources/board/"+num+"/");
		
		// 게시글 세팅
		boardVO.setNum(num);
		boardVO.setTitle(title.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		boardVO.setContent(content);
		boardVO.setNickname(userVO.getNickname());
		
		boardVO.setPos(pos+1);
		boardVO.setRef(ref);
		boardVO.setDepth(depth+1);
		
		boardVO.setUserid(userVO.getUsername());
		boardVO.setProfile(userVO.getProfile());
		
		boardUploadVO.setNum(num);
		boardUploadVO.setNickname(userVO.getNickname());
		
		// 댓글 DB 저장
		boardService.boardReply(boardVO);
		
		for(int i=1; i < files.length; i++) {
			
			if(files[i].getOriginalFilename().equals("")) {
				continue;
			}
			
			UUID uuid = UUID.randomUUID();
			String saveName = uuid.toString() + "_" + files[i].getOriginalFilename();
			boardUploadVO.setFilename(saveName);
			boardUploadVO.setFilesize((int)files[i].getSize());
			
			// sql 파일 정보 저장
			boardService.boardUpload(boardUploadVO);
	
			// 파일 저장
			upload.boardUpload(saveName, rootPath, files[i].getBytes());
			
		}

		return "redirect:/board/list?type=" + type + "&keyword=" + keyword + "&pagenum="+pagenum + "&contentnum=" + contentnum;
	}
}
