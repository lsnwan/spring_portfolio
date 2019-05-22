package com.hyeontae.vo;

import lombok.Data;

@Data
public class MessageVO {
	private int no;
	private String fromuser;
	private String touser;
	private String content;
	private String regdate;
	private int readnum;
	private int fromavailable;
	private int toavailable;
	private int sendcancel;
}
