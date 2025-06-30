package com.yedambnb.common;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	private String sort; // ★★★ 누락된 정렬 필드 다시 추가 ★★★

	public Criteria() {
		this(1, 9);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.sort = "recent"; // ★ 정렬 기본값 설정 추가
	}
}