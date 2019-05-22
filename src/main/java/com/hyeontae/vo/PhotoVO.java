package com.hyeontae.vo;

import lombok.Data;

@Data
public class PhotoVO {
	
	private Integer num;
	private String nickname;
	private String title;
	private String content;
	private String regdate;
	private int views;
	private int available;
	
	private String userid;
	private String profile;
	
	private String filename;
}
