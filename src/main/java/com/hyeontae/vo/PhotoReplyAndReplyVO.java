package com.hyeontae.vo;

import lombok.Data;

@Data
public class PhotoReplyAndReplyVO {
	private int num;
	private int no;
	private int r_no;
	private String nickname;
	private String content;
	private String regdate;
	private int available;
	
	private String userid;
	private String profile;
}
