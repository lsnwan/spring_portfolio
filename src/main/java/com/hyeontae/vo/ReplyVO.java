package com.hyeontae.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int rno;
	private int num;
	private int pos;
	private int ref;
	private int depth;
	private String replyer;
	private String reply;
	private String replyDate;
	private int available;
	private String userid;
	private String profile;
}
