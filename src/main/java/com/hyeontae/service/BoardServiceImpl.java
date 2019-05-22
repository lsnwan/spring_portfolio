package com.hyeontae.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyeontae.mapper.BoardMapper;
import com.hyeontae.vo.BoardUploadVO;
import com.hyeontae.vo.BoardVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Transactional
	@Override
	public void boardWrite(BoardVO boardVO) {
		try {
			mapper.insert_board(boardVO);
			mapper.insert_board_profile(boardVO);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public Integer selectNum() {

		Integer num = mapper.select_boardNum();
		
		if(num==null) {
			log.info("데이터 없음");
			num = 1;
			return num;
		}
		return num+1;
	}

	@Override
	public void boardUpload(BoardUploadVO boardUploadVO) {
		// TODO Auto-generated method stub
		mapper.insert_board_upload(boardUploadVO);
	}

	@Override
	public List<BoardVO> getList(int page, int contentnum, String type, String keyword) {
		
		List<BoardVO> board = new ArrayList<BoardVO>();
		
		if(type.equals("") && keyword.equals("")) {
			board = mapper.boardList(page, contentnum);			
		} else if(type.equals("title")) {
			board = mapper.boardListTitle(page, contentnum, keyword);
		} else if (type.equals("content")) {
			board = mapper.boardListContent(page, contentnum, keyword);
		} else if (type.equals("nickname")) {
			board = mapper.boardListNickname(page, contentnum, keyword);
		}
		
		return board;
	}

	@Override
	public int boardCount(String type, String keyword) {
		
		int count = 0;
		
		if(type.equals("") && keyword.equals("")) {
			count =  mapper.boardCount();			
		} else if(type.equals("title")) {
			count = mapper.boardCountTitle(keyword);
		} else if(type.equals("content")) {
			count = mapper.boardCountContent(keyword);
		} else if(type.equals("nickname")) {
			count = mapper.boardCountNickname(keyword);
		}
		
		return count;
	}

	@Override
	public BoardVO get(int num) {
		BoardVO board = new BoardVO();
		board = mapper.get(num);
		return board;
	}

	@Override
	public List<BoardUploadVO> boardGetUpload(int num) {
		List<BoardUploadVO> board = new ArrayList<BoardUploadVO>();
		board = mapper.boardUpload(num);
		return board;
	}

	@Override
	public int uploadCount(String num) {
		return mapper.uploadCount(num);
	}

	@Override
	public void deleteFile(int num, String filename) {
		mapper.deleteFile(num, filename);		
	}

	@Override
	public void boardUpdate(BoardVO boardVO) {
		mapper.update_board(boardVO);
		
	}

	@Override
	public void boardDelete(int num) {
		mapper.delete_board(num);		
	}

	@Override
	public int selectAvailable(int num) {
		return mapper.select_available(num);
	}

	@Transactional
	@Override
	public void boardReply(BoardVO boardVO) {
		mapper.insert_reply(boardVO);
		mapper.insert_board_profile(boardVO);
	}

	@Override
	public void getMaxPos(int ref) {
		mapper.getMaxPos(ref);
	}

	@Override
	public void replyUpPos(int ref, int pos) {
		mapper.replyUpPos(ref, pos);
	}

	@Override
	public void viewsUp(int num) {
		mapper.viewsUp(num);
	}

	@Override
	public List<BoardVO> indexList() {
		return mapper.indexList();
	}


}
