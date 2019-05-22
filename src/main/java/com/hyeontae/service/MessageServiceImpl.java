package com.hyeontae.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hyeontae.mapper.MessageMapper;
import com.hyeontae.vo.MessageVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MessageServiceImpl implements MessageService{

	private MessageMapper mapper;
	
	@Override
	public void write(MessageVO vo) {
		mapper.write(vo);		
	}

	@Override
	public boolean isEmptyNick(String nickname) {
		
		String search = "";
		
		search = mapper.selectUser(nickname);
		
		if(search == null) {
			return true;
		}
		
		return false;
		
	}

	@Override
	public List<MessageVO> getToList(String nickname, int page, int contentnum, Map<String, String> map) {
		return mapper.getToList(nickname, page, contentnum, map);
	}

	@Override
	public int getToSize(String nickname, Map<String, String> map) {
		return mapper.getToSize(nickname, map);
	}

	@Override
	public MessageVO getMessage(String no) {
		return mapper.getMessage(no);
	}

	@Override
	public int toDelete(String no) {
		return mapper.toDelete(no);
	}

	@Override
	public int noReadToSize(String nickname, Map<String, String> map) {
		return mapper.noReadToSize(nickname, map);
	}

	@Override
	public void read(String no) {
		mapper.read(no);
	}

	@Override
	public List<MessageVO> getFromList(String nickname, int page, int contentnum, Map<String, String> map) {
		return mapper.getFromList(nickname, page, contentnum, map);
	}

	@Override
	public int getFromSize(String nickname, Map<String, String> map) {
		return mapper.getFromSize(nickname, map);
	}

	@Override
	public int fromDelete(String no) {
		return mapper.fromDelete(no);
	}

	@Override
	public int sendCancel(String no) {
		return mapper.sendCancel(no);
	}

	@Override
	public int getToMeSize(String nickname, Map<String, String> map) {
		return mapper.getToMeSize(nickname, map);
	}

	@Override
	public List<MessageVO> getToMeList(String nickname, int page, int contentnum, Map<String, String> map) {
		return mapper.getToMeList(nickname, page, contentnum, map);
	}
	
	

}
