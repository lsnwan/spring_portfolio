package com.hyeontae.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hyeontae.vo.PhotoVO;

public interface PhotoMapper {
	
	public Integer select_photoNum();
	
	// 총 개수
	public int getSize();
	
	// 글쓰기 작업 Mapper
	public void create_photo(PhotoVO vo);
	public void create_profile(PhotoVO vo);
	public void create_thum(PhotoVO vo);
	
	// 리스트 페이지 작업 Mapper
	public List<PhotoVO> getList(@Param("pagenum") int page, @Param("contentnum") int contentnum);
	
	// index 화면 리스트 페이지 작업 Mapper
	public List<PhotoVO> getIndexList();
	
	// 글 읽기 작업 Mapper
	public PhotoVO getPhoto(@Param("num") String num);
	
	// 글 수정 작업 Mapper
	public void update_photo(PhotoVO vo);
	public void update_photo_profile(PhotoVO vo);
	public void update_photo_thum(PhotoVO vo);
	
	// 글 삭제 작업 Mapper
	public int delete_photo(@Param("num") String num);
	
}
