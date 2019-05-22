package com.hyeontae.service;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyeontae.mapper.UserMapper;
import com.hyeontae.vo.UpdateBirthdayVO;
import com.hyeontae.vo.UpdateUserVO;
import com.hyeontae.vo.UserVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class UserServiceImpl implements UserService {
	
	SqlSession sqlSession;
	
	UserMapper mapper;
	
	@Transactional
	@Override
	public void resultInsertUser(Map<String, String> user) {
		log.info("회원가입처리");
		sqlSession.insert("user.signUp", user);
		sqlSession.insert("user.insertProfile", user.get("userid").toString());
		sqlSession.insert("user.insertAuth", user.get("userid").toString());
	}

	
	@Override
	public UserVO selectUser(String userid) {
		log.info("유저정보검색");
		return sqlSession.selectOne("user.selectUser", userid);
	}


	@Override
	public String selectNickname(String nickname) {
		log.info("닉네임 검색");
		return sqlSession.selectOne("user.selectNickname",nickname);
	}


	@Override
	public String selectEmail(String email) {
		log.info("이메일 검색");
		return sqlSession.selectOne("user.selectEmail", email);
	}

	@Override
	public void updateUser(UpdateUserVO user) {
		mapper.updateUser(user);		
	}


	@Override
	public void updateUserBirthday(UpdateBirthdayVO user) {
		mapper.updateUserBirthday(user);
	}




	
}
