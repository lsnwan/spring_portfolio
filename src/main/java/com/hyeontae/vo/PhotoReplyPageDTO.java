package com.hyeontae.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class PhotoReplyPageDTO {
	private Integer replyCnt;
	private List<PhotoReplyVO> list;
}
