package com.hyeontae.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hyeontae.util.Criteria;
import com.hyeontae.vo.PhotoReplyAndReplyVO;

public interface PhotoReplyAndReplyMapper {
	
	// 새로운 no 가져오기
	public Integer selectNum();
	
	// 답글 쓰기
	public void insert_reply(PhotoReplyAndReplyVO vo);
	public void insert_Profile(PhotoReplyAndReplyVO vo);
	
	// 총 개수
	public Integer totalCount(@Param("num") String num, @Param("no") String no);
	
	// 댓글 목록 가져오기
	public List<PhotoReplyAndReplyVO> getList(@Param("cri") Criteria cri, @Param("num") String num, @Param("no")String no);
	
	// 특정 답글 가져오기
	public PhotoReplyAndReplyVO getReply(@Param("r_no")String r_no);
	
	// 답글 수정하기
	public int update_reply(PhotoReplyAndReplyVO vo);
	
	// 답글 삭제하기
	public int delete_reply(@Param("r_no")String r_no);
	
}
