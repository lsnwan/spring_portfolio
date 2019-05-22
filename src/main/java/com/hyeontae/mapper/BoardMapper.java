package com.hyeontae.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hyeontae.vo.BoardUploadVO;
import com.hyeontae.vo.BoardVO;

public interface BoardMapper {
	// 게시글이 존재 유무 확인 쿼리
	public Integer select_boardNum();
	
	// 글쓰기
	public void insert_board(BoardVO boardVO);
	public void insert_board_upload(BoardUploadVO boardUploadVO);
	public void insert_board_profile(BoardVO boardVO);
	
	// 리스트 가져오기
	public List<BoardVO> boardList(@Param("pagenum") int page, @Param("contentnum") int contentnum);
	public List<BoardVO> boardListTitle(@Param("pagenum") int page, @Param("contentnum") int contentnum, @Param("keyword")String keyword);
	public List<BoardVO> boardListContent(@Param("pagenum") int page, @Param("contentnum") int contentnum, @Param("keyword")String keyword);
	public List<BoardVO> boardListNickname(@Param("pagenum") int page, @Param("contentnum") int contentnum, @Param("keyword")String keyword);
	
	// 게시글 수
	public int boardCount();
	public int boardCountTitle(@Param("keyword")String keyword);
	public int boardCountContent(@Param("keyword")String keyword);
	public int boardCountNickname(@Param("keyword")String keyword);
	public int uploadCount(@Param("num") String num);

	// 업로드 리스트 가져오기
	public List<BoardUploadVO> boardUpload(@Param("num")int num);
	
	// 특정 게시글 가져오기
	public BoardVO get(@Param("num") int num);
	
	// 업로드 파일 지우기
	public void deleteFile(@Param("num") int num, @Param("filename") String filename);
	
	// 게시글 수정
	public void update_board(BoardVO boardVO);
	
	// 게시글 삭제
	public void delete_board(@Param("num") int num);
	
	// 특정 게시글 삭제여부
	public int select_available(@Param("num") int num);
	
	// 답변을 달기 위한 설정값
	public void replyUpPos(@Param("ref")int ref, @Param("pos")int pos);
	public void getMaxPos(@Param("ref")int ref);
	
	// 답변 달기
	public void insert_reply(BoardVO boardVO);
	
	// 조회수 증가
	public void viewsUp(@Param("num") int num);
	
	// 최근 게시물
	public List<BoardVO> indexList();
}
