package com.hyeontae.service;

import java.util.List;

import com.hyeontae.vo.PhotoVO;

public interface PhotoService {
	
	// 다음 작성될 게시글 number 가져오기
	public Integer getNumber();
	
	// 게시글 총 개수
	public int getSize();
	
	// 글쓰기
	public void create(PhotoVO photo);
	
	// 글 목록 가져오기
	public List<PhotoVO> getList(int page, int contentnum);
	public List<PhotoVO> getIndexList();
	
	// 게시글 가져오기
	public PhotoVO getPhoto(String num);
	
	// 게시글 수정
	public void update(PhotoVO vo);
	
	// 게시글 삭제
	public int delete(String num);
	
}
