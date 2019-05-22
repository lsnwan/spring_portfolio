package com.hyeontae.mapper;

import java.util.Map;

import com.hyeontae.vo.UpdateBirthdayVO;
import com.hyeontae.vo.UpdatePasswordVO;
import com.hyeontae.vo.UpdateProfileVO;
import com.hyeontae.vo.UpdateUserVO;
import com.hyeontae.vo.UserVO;

public interface UserMapper {

	public void signUp(Map<String, String> user);
	
	public void insertProfile(String userid);
	
	public void insertAuth(String userid);
	
	public String selectUserId(String email);
	
	public UserVO selectUser(String userid);
	
	public String selectNickname(String nickname);
	
	public String selectEmail(String email);
	
	public void updateUser(UpdateUserVO user);
	
	public void updateUserBirthday(UpdateBirthdayVO user);
	
	public void updatePassword(UpdatePasswordVO user);
	
	
	public void updateProfile(UpdateProfileVO user);
	
	public void boardProfileUpdate(UpdateProfileVO user);
	
	public void replyProfileUpdate(UpdateProfileVO user);
	
	
	public void photoProfileUpdate(UpdateProfileVO user);
	
	public void photoReplyProfileUpdate(UpdateProfileVO user);
	
	public void photoReplyAndReplyProfileUpdate(UpdateProfileVO user);

	
	public void deleteProfile(UpdateProfileVO user);
	
	public void deleteUser(String userid);
}
