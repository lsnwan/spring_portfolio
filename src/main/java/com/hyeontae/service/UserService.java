package com.hyeontae.service;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hyeontae.vo.UpdateBirthdayVO;
import com.hyeontae.vo.UpdateUserVO;
import com.hyeontae.vo.UserVO;

public interface UserService {
	
	// 회원가입
	public void resultInsertUser(Map<String, String> map);
	
	// 유저정보
	public UserVO selectUser(String userid);
	
	// 닉네임 검색
	public String selectNickname(String nickname);
	
	// 이메일 검색
	public String selectEmail(String email);
	
	// 유저정보 변경
	public void updateUser(UpdateUserVO user);
	public void updateUserBirthday(UpdateBirthdayVO user);
}
