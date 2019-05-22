package com.hyeontae.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hyeontae.util.Criteria;
import com.hyeontae.vo.PhotoReplyVO;

public interface PhotoReplyMapper {
	
	// 새로운 no 가져오기
	public Integer selectNum();
	
	// 댓글 쓰기
	public void insert_reply(PhotoReplyVO vo);
	public void insert_profile(PhotoReplyVO vo);
	
	// 총 개수
	public Integer totalCount(String num);
	
	// 댓글 목록 가져오기
	public List<PhotoReplyVO> getList(@Param("cri") Criteria cri, @Param("num") String num);
	
	// 특정 댓글 가져오기
	public PhotoReplyVO getReply(@Param("no") String no);
	
	// 댓글 수정
	public int update_reply(PhotoReplyVO vo);
	
	// 댓글 삭제
	public int delete_reply(@Param("no")String no);
}
