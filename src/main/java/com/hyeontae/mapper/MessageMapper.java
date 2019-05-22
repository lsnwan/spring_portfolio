package com.hyeontae.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hyeontae.vo.MessageVO;

public interface MessageMapper {
	
	public void write(MessageVO vo); // 글쓰기
	
	public String selectUser(@Param("nickname")String nickname); // 받는사람 존재여부 검색
	
	
	public int getToSize(@Param("nickname")String nickname, @Param("map")Map<String, String> map); // 받은 쪽지 총 개수
	public int noReadToSize(@Param("nickname")String nickname, @Param("map")Map<String, String> map); // 읽지 않은 받은 쪽지 개수
	
	public int getFromSize(@Param("nickname")String nickname, @Param("map")Map<String, String> map); // 보낸 쪽지 총 개수
	public int getToMeSize(@Param("nickname")String nickname, @Param("map")Map<String, String> map); // 내게 보낸 쪽지 총 개수
	
	// 받은 쪽지 목록 & 특정 쪽지 내용 가져오기
	public List<MessageVO> getToList(@Param("nickname") String nickname, @Param("pagenum") int page, @Param("contentnum")int contentnum, @Param("map")Map<String, String> map);
	public MessageVO getMessage(@Param("no")String no); 
	
	// 보낸 쪽지 목록
	public List<MessageVO> getFromList(@Param("nickname") String nickname, @Param("pagenum") int page, @Param("contentnum")int contentnum, @Param("map")Map<String, String> map);
	
	// 내게 보낸 쪽지 목록
	public List<MessageVO> getToMeList(@Param("nickname") String nickname, @Param("pagenum") int page, @Param("contentnum")int contentnum, @Param("map")Map<String, String> map);
	
	
	public int toDelete(@Param("no")String no); // 받은 쪽지 삭제 & 발송 취소 처리
	public int fromDelete(@Param("no")String no); // 보낸 쪽지 삭제 처리
	public int sendCancel(@Param("no")String no); // 발송 취소 처리
	
	public void read(@Param("no")String no);
	
	
	
	
	
}
