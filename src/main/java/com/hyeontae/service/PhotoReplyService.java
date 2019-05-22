package com.hyeontae.service;

import com.hyeontae.util.Criteria;
import com.hyeontae.vo.PhotoReplyPageDTO;
import com.hyeontae.vo.PhotoReplyVO;

public interface PhotoReplyService {
	public Integer selectNum();
	
	public int create(PhotoReplyVO vo);
	
	public int totalCount(String num);
	
	// 댓글 목록 가져오기
	public PhotoReplyPageDTO getList(Criteria cri, String num);

	// 댓글 가져오기
	public PhotoReplyVO get(String no);
	
	// 수정
	public int update(PhotoReplyVO vo);
	
	// 삭제
	public int remove(String no);
}
