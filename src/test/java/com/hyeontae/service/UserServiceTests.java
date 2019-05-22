package com.hyeontae.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hyeontae.util.Criteria;
import com.hyeontae.vo.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class UserServiceTests {
	
	@Inject
	private ReplyService service;
	
	@Inject
	SqlSession sqlSession;
	
	@Inject
	BCryptPasswordEncoder pwEncoder;
	
//	@Test
//	public void testService() {
//		log.info("회원가입 테스트");
//		
//		Map<String, String> user = new HashMap<>();
//		user.put("userid", "fffdsfsd");
//		String encoderPassword = pwEncoder.encode("1234");
//		user.put("password", encoderPassword);
//		user.put("nickname", "수리동동");
//		user.put("email", "progsin@naver.com");
//		user.put("birthday", "1987/07/01");
//		
//		log.info("userid: " + user.get("userid").toString());
//		log.info("password: " + user.get("password").toString());
//		log.info("nickname: " + user.get("nickname").toString());
//		log.info("email: " + user.get("email").toString());
//		log.info("birthday: " + user.get("birthday").toString());
//		
//		service.resultInsertUser(user);
//	}
	
//	@Test
//	public void selectUser() {
//		log.info("회원정보 테스트");
//		
//		UserVO user = service.selectUser("lsnwan");
//		
//		log.info("유저아이디: " + user.getUsername());
//		log.info("유저비밀번호: " + user.getPassword());
//		log.info("유저이름: " + user.getNickname());
//		log.info("enabled: " + user.getEnabled());
//		log.info("유저이메일: " + user.getEmail());
//		
//		
//	}
	
//	@Test
//	public void test() {
//		log.info("================ 댓글 가져오기 테스트 ====================");
//		List<ReplyVO> list = new ArrayList<ReplyVO>();
//		Criteria cri = new Criteria(1, 10);
//		Long num = 64L;
//		
//		log.info("댓글 출력: ");
//		list = service.getList(cri, num);
//		
//		log.info("리스트 크기: " + list.size());
//		
//		for (ReplyVO reply : list) {
//			log.info(reply.getReply());	
//		}
//		
//		log.info("출력 끝");
//	}
}
