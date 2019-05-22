package com.hyeontae.service;

import java.util.List;
import java.util.Map;

import com.hyeontae.vo.MessageVO;

public interface MessageService {
	
	public void write(MessageVO vo);
	
	public boolean isEmptyNick(String nickname);

	public int getToSize(String nickname, Map<String, String> map);
	public int getFromSize(String nickname, Map<String, String> map);
	public int getToMeSize(String nickname, Map<String, String> map);
	
	
	public int noReadToSize(String nickname, Map<String, String> map);
	
	
	
	public List<MessageVO> getToList(String nickname, int page, int contentnum, Map<String, String> map);
	public List<MessageVO> getFromList(String nickname, int page, int contentnum, Map<String, String> map);
	public List<MessageVO> getToMeList(String nickname, int page, int contentnum, Map<String, String> map);
	
	public MessageVO getMessage(String no);
	
	public int toDelete(String no);
	public int fromDelete(String no);
	public int sendCancel(String no);
	
	public void read(String no);
}
