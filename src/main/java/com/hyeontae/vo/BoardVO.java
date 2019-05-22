package com.hyeontae.vo;

import lombok.Data;

@Data
public class BoardVO {
	private Integer num;
	private String nickname;
	private String title;
	private String content;
	private int pos;
	private int ref;
	private int depth;
	private String regdate;
	private int views;
	private int available;
	private String userid;
	private String profile;
	private String type;
	private String keyword;
}
