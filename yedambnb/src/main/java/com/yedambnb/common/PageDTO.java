package com.yedambnb.common;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage; // 페이지네이션의 시작 번호
	private int endPage;   // 페이지네이션의 끝 번호
	private boolean prev, next; // 이전, 다음 페이지 존재 여부

	private int total;     // 전체 데이터 개수
	private Criteria cri;  // 현재 페이지 정보

	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;

		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;

		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));

		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}