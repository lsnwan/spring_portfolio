package com.hyeontae.vo;

import lombok.Data;

@Data
public class PhotoReplyVO {
	private int num;
	private Integer no;
	private String nickname;
	private String content;
	private String regdate;
	private int available;
	
	private String userid;
	private String profile;
}
