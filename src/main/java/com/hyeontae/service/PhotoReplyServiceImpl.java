package com.hyeontae.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyeontae.mapper.PhotoReplyMapper;
import com.hyeontae.util.Criteria;
import com.hyeontae.vo.PhotoReplyPageDTO;
import com.hyeontae.vo.PhotoReplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class PhotoReplyServiceImpl implements PhotoReplyService{

	private PhotoReplyMapper mapper;
	
	@Override
	public Integer selectNum() {
		Integer num = mapper.selectNum();

		if (num == null) {
			num = 1;
		} else {
			num++;
		}

		return num;
	}
	
	@Transactional
	@Override
	public int create(PhotoReplyVO vo) {
		try {
			mapper.insert_reply(vo);
			mapper.insert_profile(vo);
		} catch (Exception e) {
			return -1;
		}
		
		return 1;
	}

	@Override
	public int totalCount(String num) {
		return mapper.totalCount(num);
	}

	@Override
	public PhotoReplyPageDTO getList(Criteria cri, String num) {
		return new PhotoReplyPageDTO(mapper.totalCount(num), mapper.getList(cri, num));
	}

	@Override
	public PhotoReplyVO get(String no) {
		return mapper.getReply(no);
	}

	@Override
	public int update(PhotoReplyVO vo) {
		return mapper.update_reply(vo);
	}

	@Override
	public int remove(String no) {
		return mapper.delete_reply(no);
	}

}
