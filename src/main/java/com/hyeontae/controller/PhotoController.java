package com.hyeontae.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hyeontae.service.PhotoService;
import com.hyeontae.service.UserService;
import com.hyeontae.util.PageMaker;
import com.hyeontae.vo.PhotoVO;
import com.hyeontae.vo.UserVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/photo")
public class PhotoController {
	
	@Inject
	ServletContext servletContext;
	
	@Inject
	PhotoService photoService;
	
	@Inject
	UserService userService;
	
	// 리스트 보기 (GET)
	@GetMapping("/list")
	public void photoList(String pagenum, String contentnum, Model model) {
		log.info("photo - 리스트");
		
		PageMaker pm = new PageMaker();
		
		if(pagenum == null) pagenum = "1";
		if(contentnum == null) contentnum = "12";
		
		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);
		
		pm.setTotalcount(photoService.getSize());
		pm.setPagenum(cpagenum-1);
		pm.setContentnum(ccontentnum);
		pm.setCurrentblock(cpagenum);	
		pm.setLastBlock(pm.getTotalcount());
		
		pm.setStartPage(pm.getCurrentblock());
		pm.setEndPage(pm.getLastblock(), pm.getCurrentblock());
		pm.prevNext(cpagenum);
		
		List<PhotoVO> list = new ArrayList<>();
		
		list = photoService.getList(pm.getPagenum()*12, pm.getContentnum());
		
		model.addAttribute("list", list);
		model.addAttribute("page", pm);
		model.addAttribute("pagenum", cpagenum);
		
		log.info("[ PageMaker 값들 ]\n" + pm);
		
	}
	
	// 글쓰기(GET)
	@GetMapping("/write")
	public String photoWrite(Principal principal) {
		if(principal == null) {
			return "redirect:/login";
		}
		log.info("Photo - 글쓰기");
		return "/photo/write";
	}
	
	// 글쓰기에서 CKEditor로 이미지 업로드 작업
	@PostMapping("/imageUpload")
	public void photoImageUpload(String num, HttpServletRequest request, HttpServletResponse response, MultipartFile upload) throws Exception {
		log.info("photo - 이미지업로드");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");		
		
		String checkType = upload.getContentType().substring(0, upload.getContentType().indexOf("/"));
		if(!checkType.equals("image")) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('이미지 파일만 업로드 가능 합니다.');");
			pw.println("</script>");
			return;
		}
		
		Integer number;
		if(num == null) {
			number = photoService.getNumber(); // 작성될 게시글 number
		} else {
			number = Integer.parseInt(num); // 수정될 게시글 number
		}
		
		UUID uuid = UUID.randomUUID(); // 중복방지
		String saveName = uuid.toString() + "_" + upload.getOriginalFilename(); // uuid로 파일 이름 작성
		String uploadPath = servletContext.getRealPath("/resources/photo/"+number+"/"); // 저장될 디렉토리 주소
		
		// 파일을 저장할 폴더 생성
		File folder = new File(uploadPath);
		if(!folder.exists()) {
			try {
				folder.mkdir();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		byte[] bytes = upload.getBytes(); // 업로드할 파일용량(?)
		OutputStream out = new FileOutputStream(new File(uploadPath+saveName)); // 파일 저장을 위한 스트림 설정
		out.write(bytes); // 파일저장
		
		// 썸네일 생성
		try {

			FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"thum_"+saveName));
			Thumbnailator.createThumbnail(upload.getInputStream(), thumbnail, 250, 250);
			thumbnail.close();

		} catch (Exception e) {
			log.info("썸네일 생성 실패");
			e.printStackTrace();
		}
		
		String callback = request.getParameter("CKEditorFuncNum");
		String fileUrl = "/resources/photo/"+number+"/"+saveName;
		
		PrintWriter pw = response.getWriter();
		pw.println("<script>window.parent.CKEDITOR.tools.callFunction(" + callback + ", '" + fileUrl + "', '이미지가 저장 되었습니다.')</script>");
		pw.flush();
		
		out.close();
	}
	
	// 글쓰기 (POST)
	@PostMapping("/write")
	public String photoPostWrite(String title, String description, Principal principal) {
		log.info("====== photo - write(POST) ==========");
		
		
		Integer num = photoService.getNumber(); // 게시글 number 가져오기
		
		// 파일 체크 함수 (실제 작성되지 않은 이미지 삭제)
		fileDirectoryCheck(num, description);
		
		// Thumnail 파일 이름 추출
		String fileName = makeThumnail(description);
		
		/**
		 *  데이터베이스 저장
		 */
		UserVO user = userService.selectUser(principal.getName());
		PhotoVO photo = new PhotoVO();
		
		// board_photo에 들어갈 데이터
		photo.setNum(num);
		photo.setUserid(user.getUsername());
		photo.setNickname(user.getNickname());
		photo.setProfile(user.getProfile());

		// board_photo_profile에 들어갈 데이터
		photo.setTitle(title.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		photo.setContent(description);
		
		// board_photo_thum에 들어갈 데이터
		photo.setFilename(fileName);
		
		photoService.create(photo);
		
		return "redirect:/photo/list";
	}
	
	// 글 가져오기 (GET)
	@GetMapping("/get")
	public String photoGet(String num, Model model) {
		log.info("photo - 글 가져오기");
		log.info("게시글 num: " + num);
		if(num == null) {
			log.info("게시글 번호가 값이 없습니다.");
			return "redirect:/common/error404";
		}
		
		PhotoVO get = new PhotoVO();
		get = photoService.getPhoto(num);
		
		model.addAttribute("photo", get);
		model.addAttribute("num", num);
		return "/photo/get";
	}
	
	// 글 수정하기 (GET)
	@GetMapping("/modify")
	public String photoModify(String num, Model model, Principal principal) {
		log.info("[ photo - modify] ");
		
		PhotoVO photo = new PhotoVO();
		photo = photoService.getPhoto(num);
		
		if(principal == null) {
			return "redirect:/login";
		} else {
			if(!principal.getName().equals(photo.getUserid())) {
				return "redirect:/photo/list";
			}
		}
		
		model.addAttribute("photo", photo);
		
		return "/photo/modify";
	}
	
	// 글 수정하기 (POST)
	@PostMapping("/modify")
	public String photoPostModify(Integer num, String title, String description) {
		log.info("[ photo - modify (POST) ]");
		
		log.info("게시글 번호: " + num);
		
		// 파일 체크 함수 (실제 작성되지 않은 이미지 삭제)
		fileDirectoryCheck(num, description);
				
		// Thumnail 파일 이름 추출
		String fileName = makeThumnail(description);
		
		PhotoVO photo = new PhotoVO();
		photo.setNum(num);
		photo.setTitle(title.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));
		photo.setContent(description);
		photo.setFilename(fileName);
		
		photoService.update(photo);
		
		log.info("[ photo - modify (POST) END ]");
		return "redirect:/photo/list";
	}

	// 글 삭제 (POST)
	@PostMapping("/delete")
	@ResponseBody
	public String photoPostDelete(String num) {
		log.info("[ photo - Delete (post) ]");
		log.info("num: " + num);
		
		int result = photoService.delete(num);
		
		if(result == 1) {
			return "1";
		} else {
			return "-1";			
		}
		
	}
	
	// 리스트에서 사진 바로 보기
	@GetMapping(value = "/showImages/{num}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE } )
	public ResponseEntity<List<String>> showImages(@PathVariable("num")String num) {
		log.info("[ 리스트에서 사진 바로 보기 ]");
		
		List<String> images = new ArrayList<String>();
		
		String directoryPath = servletContext.getRealPath("/resources/photo/"+num+"/"); // 저장될 디렉토리 주소
		
		File path = new File(directoryPath);
		File[] fileList = path.listFiles();
		
		for(File value : fileList) {
			String fileName = value.getName();
			
			if(fileName.indexOf("thum_") == -1) {
				images.add(fileName);				
			}

		}
		
		return new ResponseEntity<>(images, HttpStatus.OK);
	}
	
	
	
	/**************************************************************
	 ***************  PhotoController에서 사용하는 함수  *****************
	 **************************************************************/
	// 파일(이미지)이 실제 작성된 이미지인지 확인 후 아니면 삭제하는 함수
	public void fileDirectoryCheck(Integer num, String content) {
		// 파일 경로
		File dir = new File(servletContext.getRealPath("/resources/photo/"+num+"/"));
		File[] fileList = dir.listFiles();
		
		// 게시글 폴더에 파일을 검색해서 리스트에 저장
		List<String> files = new ArrayList<>();
		try {
			for (int i = 0; i < fileList.length; i++) {
				File file = fileList[i];
				if (file.isFile()) {
					files.add(file.getName());
				} 
			}
		} catch (Exception e) {}
		
		// 리스트에 저장한 파일로 실제 작성한 파일인지 아닌지 비교, 업로드된 이미지 중 작성에 제외된 이미지 삭제
		for(String file:files) {
			if(content.indexOf(file) == -1) {
				// 존재하지 않음, 디렉토리에서 해당 파일 삭제
				if(file.indexOf("thum_") != -1) {
					if(content.indexOf(file.substring(5, file.length())) == -1) {
						System.out.println(file+"파일은 게시글에 존재 하지 않아 삭제 합니다.");
						File deleteFile = new File(servletContext.getRealPath("/resources/photo/"+num+"/")+file);
						deleteFile.delete();
					}
					
				} else {
					System.out.println(file+"파일은 게시글에 존재 하지 않아 삭제 합니다.");
					File deleteFile = new File(servletContext.getRealPath("/resources/photo/"+num+"/")+file);
					deleteFile.delete();					
				}
			}
		}
	}

	// 대표사진으로 사용할 Thumnail 추출
	public String makeThumnail(String content) {
		/**
		 *  첫번째 이미지로 썸네일 주소 가져오기
		 */
		String fileName = "";
		String thumnailPath = "";
		
		if (content.indexOf("<img") != -1) {
			int s = content.indexOf("<img"); // 첫번째 <img>
			thumnailPath = content.substring(s); // 태그부터 자르기
			int s1 = thumnailPath.indexOf("src=\"");
			thumnailPath = thumnailPath.substring(s1 + 5); // /resources 부터
			int end = thumnailPath.indexOf("\""); // 큰따움표 까지
			thumnailPath = thumnailPath.substring(0, end);// 자르기
			fileName = thumnailPath.substring(thumnailPath.lastIndexOf("/") + 1, thumnailPath.length()); // 파일 이름
			thumnailPath = thumnailPath.substring(0, thumnailPath.lastIndexOf("/") + 1);
			
			fileName = thumnailPath + "thum_" + fileName;

			log.info("첫번쨰 이미지 썸네일 주소: " + thumnailPath);
			log.info("첫번쨰 이미지 썸네일 파일 이름: " + fileName);
		} else {
			fileName = "/resources/images/no_image.jpg";
		}
		
		return fileName;
	}
	
	
	
	
}
