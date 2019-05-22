package com.hyeontae.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hyeontae.util.Criteria;
import com.hyeontae.vo.BoardVO;
import com.hyeontae.vo.ReplyVO;

public interface ReplyMapper {
	// 답변글 존재 유무 확인 쿼리
	public Integer select_replyNum();
	
	// 답변 총 개수
	public Integer totalCount(Long num);
	
	// 댓글 쓰기
	public int insert_reply(ReplyVO replyVO);
	public int insert_reply_profile(ReplyVO replyVO);
	
	// 댓글 리스트 가져오기
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("num") Long num);
	
	// 특정 댓글 정보 가져오기
	public ReplyVO read(Long rno);
	
	// 댓글 삭제
	public int remove_reply(Long rno);
	
	// 댓글 수정
	public int update(ReplyVO reply);
	
	// 답변을 달기 위한 설정값
	public void replyUpPos(@Param("ref")int ref, @Param("pos")int pos);
	public void getMaxPos(@Param("ref")int ref);
	public int insert_replyReply(ReplyVO replyVO);
}
