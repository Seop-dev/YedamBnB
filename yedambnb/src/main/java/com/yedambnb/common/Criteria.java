package com.yedambnb.common;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum; // 현재 페이지 번호
	private int amount;  // 한 페이지에 보여줄 데이터 개수

	public Criteria() {
		this(1, 9); // 기본값: 1페이지, 9개씩
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}