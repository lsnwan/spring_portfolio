package com.hyeontae.vo;

import lombok.Data;

@Data
public class BoardUploadVO {
	private Integer num;
	private String nickname;
	private String filename;
	private String subFileName;
	private int filesize;
}
