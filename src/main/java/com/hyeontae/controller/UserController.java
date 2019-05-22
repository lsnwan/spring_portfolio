package com.hyeontae.controller;

import java.io.File;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hyeontae.service.BoardService;
import com.hyeontae.service.ReplyService;
import com.hyeontae.service.UserService;
import com.hyeontae.util.FileUploadUtil;
import com.hyeontae.util.FindMail;
import com.hyeontae.vo.SignVO;
import com.hyeontae.vo.UpdateBirthdayVO;
import com.hyeontae.vo.UpdatePasswordVO;
import com.hyeontae.vo.UpdateProfileVO;
import com.hyeontae.vo.UpdateUserVO;
import com.hyeontae.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/users")
public class UserController {
	
	@Inject
	BCryptPasswordEncoder encoder;
	
	@Inject
	UserService userService;
	
	@Inject
	BoardService boardService;
	
	@Inject
	ReplyService replyService;
	
	@Inject
	SqlSession sql;
	
	@Inject
	ServletContext servletContext;
	
	@GetMapping("/signup")
	public String singup(Principal principal) {
		log.info("회원가입 페이지");
		if(principal != null) {
			return "redirect:/";
		}
		return "/users/signup";
	}
	
	@PostMapping("/signupAction")
	public void signupAction(HttpServletRequest request, HttpServletResponse response, 
			SignVO user, @RequestParam String year, @RequestParam String month, @RequestParam String day) throws Exception{
		log.info("회원가입 처리 페이지");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		Map<String, String> map = new HashMap<>();
		String birthday = year + "/" + month + "/" + day;		
		user.setPassword(encoder.encode(user.getPassword()));
		
		map.put("userid", user.getUserid());
		map.put("password", user.getPassword());
		map.put("nickname", user.getNickname());
		map.put("email", user.getEmail());
		map.put("birthday", birthday);
		
		userService.resultInsertUser(map);
		
		out.println("<script>"
				+ "alert('회원가입이 완료 되었습니다.');"
				+ "location.href='/login';"
				+ "</script>");
	}
	
	@PostMapping("/duplicationIdCheck")
	@ResponseBody
	public String duplicationIdCheck(@RequestParam("userId") String userid){
		log.info("아이디체크 AJax");
		
		log.info("userID: " + userid);
		
		UserVO users = userService.selectUser(userid);
		
		if(users == null) {
			return "1";
		} else {
			return "0";
		}		
	}
	
	@PostMapping("/duplicationNicknameCheck")
	@ResponseBody
	public String duplicationNicknameCheck(@RequestParam("nickname") String nickname){
		log.info("닉네임체크 AJax");
		
		log.info("nickname: " + nickname);
		
		String nicknameCheck = userService.selectNickname(nickname);
		
		if(nicknameCheck == null || nicknameCheck.isEmpty()) {
			return "1";
		} else {
			return "0";
		}		
	}
	
	@PostMapping("/duplicationEmailCheck")
	@ResponseBody
	public String duplicationEmailCheck(@RequestParam("email") String email){
		log.info("이메일체크 AJax");
		
		String emailCheck = userService.selectEmail(email);
		
		if(emailCheck == null || emailCheck.isEmpty()) {
			return "1";
		} else {
			return "0";
		}		
	}
	
	@PostMapping("/updateEmailCheck")
	@ResponseBody
	public String updateEmailCheck(@RequestParam("email") String email, @RequestParam("userEmail") String userEmail){
		log.info("UserUpdate 이메일체크 AJax");
		
		String emailCheck = userService.selectEmail(email);
		
		if(email.equals(userEmail)) {
			return "0"; // 변경사항 없음
		} else {
			if( emailCheck == null || emailCheck.equals("")) {
				return "1"; // 수정 가능
			} else {
				return "-1"; // 중복 됨
			}
		}
		
	}
	
	@GetMapping("/updateUser")
	public String updateUser(Principal principal, Model model) {
		
		if(principal==null) {
			return "redirect:/login";
		}
		
		String userid = principal.getName();
		UserVO user = userService.selectUser(userid);
		
		String birthday = user.getBirthday();
		String birthdayToken[] = birthday.split("/");
		String birthdayName[] = {"year","month","day"};
		
		model.addAttribute("userid", user.getUsername());
		model.addAttribute("nickname", user.getNickname());
		model.addAttribute("email", user.getEmail());
		
		for(int i=0; i<birthdayToken.length; i++) {
			model.addAttribute(birthdayName[i], birthdayToken[i]);
		}
		
		return "/users/updateUser";
	}
	
	@PostMapping("/userUpdate")
	public void userUpdateAction(HttpServletRequest request, HttpServletResponse response,
			Principal principal,
			@RequestParam String email, 
			@RequestParam String year, 
			@RequestParam String month, 
			@RequestParam String day) throws Exception{
		
		String birthday = year+"/"+month+"/"+day;
		
		String userid = principal.getName();
		UserVO user = userService.selectUser(userid);
		
		UpdateUserVO updateUser = new UpdateUserVO();
		UpdateBirthdayVO updateBirthday = new UpdateBirthdayVO();
		
		updateUser.setUserid(userid);
		updateUser.setEmail(email);
		updateUser.setBirthday(birthday);
		
		updateBirthday.setUserid(userid);
		updateBirthday.setBirthday(birthday);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(email.equals(user.getEmail())) {
			// 생년월일만 변경
			sql.update("user.updateUserBirthday", updateBirthday);
		} else {
			// 이메일, 생년월일 변경
			sql.update("user.updateUser", updateUser);
		}

		out.println("<script>"
				+ "alert('회원정보가 변경 되었습니다.');"
				+ "location.href='/';"
				+ "</script>");		
	}
	
	@GetMapping("/updatePasswordCheck")
	public String updatePasswordCheck(Principal principal) {
		log.info("비밀번호변경 확인 페이지");
		if(principal==null) {
			return "redirect:/login";
		}
		return "/users/updatePasswordCheck";
	}
	
	@PostMapping("/updatePasswordCheck")
	public void updatePasswordCheck(HttpServletRequest request, HttpServletResponse response, Principal principal, @RequestParam String password) throws Exception {
		log.info("비밀번호변경 확인 처리 페이지");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		UserVO user = userService.selectUser(principal.getName());
		
		if(encoder.matches(password, user.getPassword())) {
			// 비밀번호 일치
			out.println("<script>"
					+ "location.href='/users/updatePassword';"
					+ "</script>");		
		} else {
			// 비밀번호 불일치
			out.println("<script>"
					+ "alert('비밀번호가 일치하지 않습니다.');"
					+ "history.back();"
					+ "</script>");		
		}
	}
	
	@GetMapping("/updatePassword")
	public String updatePassword(Principal principal) {
		log.info("비밀번호 변경 페이지");
		if(principal==null) {
			return "redirect:/login";
		}
		return "/users/updatePassword";
	}
	
	@PostMapping("/updatePassword")
	public void updatePasswordPost(HttpServletRequest request, HttpServletResponse response, Principal principal, @RequestParam String password) throws Exception {
		log.info("비밀번호 변경 처리 페이지");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String userid = principal.getName();
		UpdatePasswordVO user = new UpdatePasswordVO();
		
		user.setUserid(userid);
		user.setPassword(encoder.encode(password));
		
		sql.update("user.updatePassword", user);
		
		request.getSession().invalidate();
		
		out.println("<script>"
				+ "alert('비밀번호가 변경 되었습니다.');"
				+ "location.href='/login';"
				+ "</script>");		
	}
	
	@GetMapping("/updateProfile")
	public String updateProfile(Principal principal) {
		if(principal==null) {
			return "redirect:/login";
		}
		return "/users/updateProfile";
	}
	
	@PostMapping("/updateProfileAction")
	public void updateProfileAction(MultipartFile file, Principal principal, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		FileUploadUtil upload = new FileUploadUtil();
		
		String rootPath = servletContext.getRealPath("/resources/profile/"+principal.getName()+"/");
		String fileName = file.getOriginalFilename();

		// 파일 업로드
		// 업로드 후 코드화된 파일이름으로 대체 
		fileName = upload.uploadUserProfile(fileName, rootPath, file.getBytes());

		// 썸네일 생성
		upload.thumbnail(rootPath, fileName, file);

		// SQL VO 설정
		UpdateProfileVO user = new UpdateProfileVO();
		user.setUserid(principal.getName());
		user.setProfile(fileName);
		
		// SQL 저장
		sql.update("user.updateProfile", user);
		sql.update("user.boardProfileUpdate", user);
		sql.update("user.replyProfileUpdate", user);
		
		sql.update("user.photoProfileUpdate", user);
		sql.update("user.photoReplyProfileUpdate", user);
		sql.update("user.photoReplyAndReplyProfileUpdate", user);
		
		
		// 세션 비움
		request.getSession().invalidate();
		
		out.println("<script>"
				+ "alert('프로필이 변경 되었습니다.');"
				+ "location.href='/login';"
				+ "</script>");
	}
	
	@PostMapping("/deleteProfile")
	public void deleteProfile(HttpServletRequest request, HttpServletResponse response, Principal principal) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		UpdateProfileVO user = new UpdateProfileVO();
		String userid = principal.getName();
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		String uploadFolder = rootPath + "upload/profile/" + userid + "/";
		
		user.setUserid(userid);
		user.setProfile("");
		
		File saveDir = new File(uploadFolder);
		
		if(saveDir.exists()) {
			File[] files = saveDir.listFiles();

			for(int i=0; i<files.length; i++) {
				files[i].delete();
			}
		}

		saveDir.delete();
		
		sql.update("user.deleteProfile", user);
		sql.update("user.boardProfileUpdate", user);
		
		request.getSession().invalidate();
		
		out.println("<script>"
				+ "location.href='/login';"
				+ "</script>");
		
	}
	
	@GetMapping("/deleteUser")
	public String deleteUser(Principal principal) {
		if(principal==null) {
			return "redirect:/login";
		}
		return "/users/deleteUser";
	}
	
	@PostMapping("/deleteUser")
	public void deleteUserPost(HttpServletRequest request, HttpServletResponse response, Principal principal, String password, String email) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		log.info("userPassword: " + password);
		log.info("userEmail: " + email);
		
		String userid = principal.getName();
		UserVO user = userService.selectUser(userid);
		
		if(encoder.matches(password, user.getPassword()) && user.getEmail().equals(email)) {
			log.info("모두 일치 탈퇴하기");
			
			sql.update("user.deleteUser", userid);
			
			request.getSession().invalidate();
			
			out.println("<script>"
					+ "alert('회원탈퇴에 성공 했습니다. 이용해 주셔서 감사합니다.');"
					+ "location.href='/';"
					+ "</script>");
		} else {
			log.info("일치하지 않음");
			out.println("<script>"
					+ "alert('정보가 일치하지 않습니다.');"
					+ "history.back();"
					+ "</script>");
		}
	}
	
	@GetMapping("/findPassword")
	public void findPassword() {
		
	}
	
	@PostMapping("/findPassword")
	public void findPasswordPost(HttpServletRequest request, HttpServletResponse response, String userid, String email) throws Exception {
		log.info("비밀번호 찾기 처리");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		UserVO user = userService.selectUser(userid);
		
		if(user!=null) {
			if(user.getEmail().equalsIgnoreCase(email)) {
				//이메일이 일치하는 경우
				
				Random rnd =new Random();

				StringBuffer buf =new StringBuffer();

				for(int i=0;i<6;i++){
				    if(rnd.nextBoolean()){
				        buf.append((char)((int)(rnd.nextInt(26))+97));
				    }else{
				        buf.append((rnd.nextInt(10)));
				    }
				}
				
				String newPassword = buf.toString();
				log.info("랜덤Password: " + newPassword);

				String encodingPassword = encoder.encode(newPassword);
				log.info("랜덤Password(암호화): " + encodingPassword);
				
				UpdatePasswordVO userPassword = new UpdatePasswordVO();
				userPassword.setUserid(userid);
				userPassword.setPassword(encodingPassword);
				
				sql.update("user.updatePassword", userPassword);
				
				// 메일 발송
				FindMail mail = new FindMail();
				mail.sendMail(user.getEmail(), newPassword);

				out.println("<script>"
						+ "alert('새로운 비밀번호가 생성 되었습니다. 이메일을 확인해 주세요');"
						+ "location.href='/login';"
						+ "</script>");
				return;
				
			} else {
				out.println("<script>"
						+ "alert('이메일이 일치하지 않습니다.');"
						+ "history.back();"
						+ "</script>");
				return;
			}			
		}
		
		out.println("<script>"
				+ "alert('아이디가 존재하지 않습니다.');"
				+ "history.back();"
				+ "</script>");
		
		return;
	}
	
	
	@GetMapping("/findUserId")
	public void findUserId() {}
	
	@PostMapping("/findUserId")
	public void findUserIdPost(HttpServletRequest request, HttpServletResponse response, String email) throws Exception {
		log.info("아이디 찾기 포스트");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		
		String userId = sql.selectOne("user.selectUserId", email);
		
		if(userId==null) {
			out.println("<script>"
					+ "alert('아이디가 존재하지 않습니다.');"
					+ "history.back();"
					+ "</script>");
		} 
		
		int length = userId.length();
		
		userId = userId.substring(0, length/2);
		
		int nowlen = userId.length();
		
		for(int i=0; i<(length-nowlen); i++) {
			userId += "*";
		}
		
		request.getSession().setAttribute("findUserId", userId);
		
		out.println("<script>"
				+ "location.href='/users/findUserIdSuccess';"
				+ "</script>");
	}
	
	@GetMapping("/findUserIdSuccess")
	public String findUserIdSuccess(HttpSession session, Model model) {
		log.info("아이디 찾기 성공");
		
		String findId = (String) session.getAttribute("findUserId");
		
		if(findId == null) {
		    return "redirect:/";
		}
		
		model.addAttribute("findid", findId);
		
		session.invalidate();
		
		return "/users/findUserIdSuccess";
		
	}
}
