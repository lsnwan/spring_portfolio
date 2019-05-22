package com.hyeontae.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hyeontae.vo.BoardUploadVO;
import com.hyeontae.vo.BoardVO;

public interface BoardService {
	public Integer selectNum();
	public void boardWrite(BoardVO boardVO);
	public void boardUpload(BoardUploadVO boardUploadVO);
	
	public List<BoardVO> getList(int page, int contentnum, String type, String keyword);
	public int boardCount(String type, String keyword);
	public int uploadCount(String num);
	
	public List<BoardUploadVO> boardGetUpload(int num);
	
	public BoardVO get(int num);
	
	public void deleteFile(int num, String filename);
	
	public void boardUpdate(BoardVO boardVO);
	public void boardDelete(int num);
	public int selectAvailable(int num);
	
	public void replyUpPos(int ref, int pos);
	public void getMaxPos(int ref);

	public void boardReply(BoardVO boardVO);
	
	public void viewsUp(int num);
	
	public List<BoardVO> indexList();
}
