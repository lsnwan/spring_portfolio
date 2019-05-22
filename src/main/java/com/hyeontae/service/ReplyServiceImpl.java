package com.hyeontae.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyeontae.mapper.ReplyMapper;
import com.hyeontae.util.Criteria;
import com.hyeontae.vo.ReplyPageDTO;
import com.hyeontae.vo.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	private ReplyMapper mapper;
	
	@Override
	public Integer selectNum() {
		Integer num = mapper.select_replyNum();
		
		if(num == null) {
			log.info("데이터 없음");
			num = 1;
			return num;
		}
		return num+1;
	}

	@Override
	public int totalCount(Long num) {
		
		Integer tc = mapper.totalCount(num);
		
		if ( tc == null ) {
			tc = 0;
			return tc;
		}
		
		return tc;
	}
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		try {
			mapper.insert_reply(vo);
			mapper.insert_reply_profile(vo);			
		} catch (Exception e) {
			return 0;
		}
		
		return 1;
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long num) {
		return mapper.getListWithPaging(cri, num);
	}

	@Override
	public int remove(Long rno) {
		
		return mapper.remove_reply(rno);
	}

	@Override
	public ReplyVO read(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public void replyUpPos(int ref, int pos) {
		mapper.replyUpPos(ref, pos);
	}

	@Override
	public void getMaxPos(int ref) {
		mapper.getMaxPos(ref);
	}

	@Override
	public int replyReply(ReplyVO vo) {
		try {
			mapper.insert_replyReply(vo);
			mapper.insert_reply_profile(vo);
		} catch (Exception e) {
			return 0;
		}
		
		return 1;
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(
				mapper.totalCount(bno),
				mapper.getListWithPaging(cri, bno));
	}

	

}
