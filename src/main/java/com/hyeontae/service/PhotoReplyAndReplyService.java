package com.hyeontae.service;

import com.hyeontae.util.Criteria;
import com.hyeontae.vo.PhotoReplyAndReplyPageDTO;
import com.hyeontae.vo.PhotoReplyAndReplyVO;

public interface PhotoReplyAndReplyService {
	
	public Integer selectNum();
	
	public int insert(PhotoReplyAndReplyVO vo);
	
	public PhotoReplyAndReplyPageDTO getList(Criteria cri, String num, String no);
	
	public PhotoReplyAndReplyVO getReply(String r_no);
	
	public int update(PhotoReplyAndReplyVO vo);
	
	public int remove(String r_no);
}
