package com.hyeontae.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyeontae.mapper.PhotoMapper;
import com.hyeontae.vo.PhotoVO;
import com.hyeontae.vo.UserVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class PhotoServiceImpl implements PhotoService{

	private PhotoMapper mapper;
	
	@Override
	public Integer getNumber() {
		
		Integer num = mapper.select_photoNum();
		
		if(num == null) {
			num = 1;
		} else {
			num++;
		}
		
		return num;
	}

	@Transactional
	@Override
	public void create(PhotoVO photo) {
		try {
			mapper.create_photo(photo);
			mapper.create_profile(photo);
			mapper.create_thum(photo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int getSize() {
		return mapper.getSize();
	}

	@Override
	public List<PhotoVO> getList(int page, int contentnum) {
		return mapper.getList(page, contentnum);
	}

	@Override
	public PhotoVO getPhoto(String num) {
		return mapper.getPhoto(num);
	}

	@Transactional
	@Override
	public void update(PhotoVO vo) {
		try {
			mapper.update_photo(vo);
			mapper.update_photo_thum(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int delete(String num) {
		return mapper.delete_photo(num);
	}

	@Override
	public List<PhotoVO> getIndexList() {
		return mapper.getIndexList();
	}

}
