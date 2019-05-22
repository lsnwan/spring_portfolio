package com.hyeontae.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hyeontae.vo.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
//	@Test
//	public void insert() {
//		log.info("게시글 쓰기 테스트");
//		
//		Integer num = service.selectNum();
//		
//		BoardVO board = new BoardVO();
//		board.setNum(num);
//		board.setNickname("조현태");
//		board.setTitle("테스트 게시글 제목 입니다.");
//		board.setContent("테스트 게시글 내용 입니다.");
//		board.setRef(num);
//		board.setUserid("lsnwan");
//		board.setProfile(null);
//		
//		service.boardWrite(board);
//	}
	
//	@Test
//	public void selectTest() {
//		log.info("셀렉트 테스트");
//		
//		List<BoardVO> board = new ArrayList<>();
//		
//		board = service.getListSelect(0, 10, "title", "asd");
//		
//		for(int i=0; i<board.size(); i++) {
//			log.info(board.get(i).toString());
//		}
//		
//	}
	
	@Test
	public void updateBoard() {
		BoardVO board = new BoardVO();
		
		board.setTitle("수정되었음");
		board.setContent("내용이 수정 되었습니다.");
		board.setNum(68);
		
		service.boardUpdate(board);
		
	}
}
