package com.hyeontae.service;

import java.util.List;

import com.hyeontae.util.Criteria;
import com.hyeontae.vo.BoardVO;
import com.hyeontae.vo.ReplyPageDTO;
import com.hyeontae.vo.ReplyVO;

public interface ReplyService {
	
	public Integer selectNum();
	public int totalCount(Long num);
	
	public int register(ReplyVO vo);
	
	public List<ReplyVO> getList(Criteria cri, Long num);
	public ReplyVO read(Long rno);
	
	public int remove(Long rno);
	
	public int modify(ReplyVO vo);

	public void replyUpPos(int ref, int pos);
	public void getMaxPos(int ref);

	public int replyReply(ReplyVO vo);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
