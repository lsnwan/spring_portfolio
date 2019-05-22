package com.hyeontae.util;

import lombok.Data;

@Data
public class PageMaker {
	private int totalcount; // 전체 게시물 수
	private int pagenum; // 현재페이지 번호
	private int contentnum = 10; // 한 페이지에 표시할 개수
	private int startpage = 1; // 시작 페이지 (현재블럭)
	private int endpage; // 끝 페이지 (현재 페이지 블럭)
	private boolean prev = false; // 이전 블럭으로
	private boolean next = false; // 다음 블럭
	private int currentblock; // 현재 페이지 블럭
	private int lastblock; // 마지막 페이지 블럭
	private String type; // 검색 타입
	private String keyword; // 검색 키워드
	
	
	// 시작 페이지
	public void setStartPage(int currentblock) {
		this.startpage = (currentblock*5)-4;
	}
	
	// 5페이지를 한 블록으로 총 블록 수
	public void setCurrentblock(int pagenum) {
		this.currentblock = pagenum/5;
		if(pagenum % 5 > 0) {
			this.currentblock++;
		}
	}
	
	// 마지막 페이지
	public void setEndPage(int getLastBlock, int getCurrentBlock) {
		
		if(getLastBlock == 0) {
			this.endpage = 0;
		} else if(getLastBlock == getCurrentBlock) {
			this.endpage = calcPage(getTotalcount(), getContentnum());
		} else {
			this.endpage = getStartpage()+4;
		}
		
	}
	
	// 5페이지를 한 블록으로 마지막 블록
	public void setLastBlock(int totalCount) {
		this.lastblock = totalCount / (5 * this.contentnum);
		if(totalcount%(5 * this.contentnum) > 0) {
			this.lastblock++;
		}
	}
	
	// 전체 페이지 수를 계산하는 함수
	public int calcPage(int totalcount, int contentnum) {
		
		if (totalcount == 0) totalcount = 1;
		int totalpage = totalcount/contentnum;
		
		if(totalcount%contentnum > 0) {
			totalpage++;
		}
		
		return totalpage;
	}
	
	// 이전, 다음 페이지 화살표 표시하는 체크함수
	public void prevNext(int pagenum) {
		if (calcPage(getTotalcount(), getContentnum()) < 6) {
			setPrev(false);
			setNext(false);
		}
		else if(pagenum > 0 && pagenum < 6) {
			setPrev(false);
			setNext(true);
		} 
		else if (getLastblock() == getCurrentblock()) {
			setPrev(true);
			setNext(false);
		}
		else {
			setPrev(true);
			setNext(true);
		}
	}
	
	
}
