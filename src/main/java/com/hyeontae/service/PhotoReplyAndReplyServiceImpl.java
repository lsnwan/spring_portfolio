package com.hyeontae.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyeontae.mapper.PhotoReplyAndReplyMapper;
import com.hyeontae.util.Criteria;
import com.hyeontae.vo.PhotoReplyAndReplyPageDTO;
import com.hyeontae.vo.PhotoReplyAndReplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
public class PhotoReplyAndReplyServiceImpl implements PhotoReplyAndReplyService {

	private PhotoReplyAndReplyMapper mapper;
	
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
	public int insert(PhotoReplyAndReplyVO vo) {
		try {
			mapper.insert_reply(vo);
			mapper.insert_Profile(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
		return 1;
	}

	@Override
	public PhotoReplyAndReplyPageDTO getList(Criteria cri, String num, String no) {
		return new PhotoReplyAndReplyPageDTO(mapper.totalCount(num, no), mapper.getList(cri, num, no));
	}

	@Override
	public PhotoReplyAndReplyVO getReply(String r_no) {
		return mapper.getReply(r_no);
	}

	@Override
	public int update(PhotoReplyAndReplyVO vo) {
		return mapper.update_reply(vo);
	}

	@Override
	public int remove(String r_no) {
		return mapper.delete_reply(r_no);
	}

}
