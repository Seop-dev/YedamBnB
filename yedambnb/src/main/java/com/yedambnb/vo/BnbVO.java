package com.yedambnb.vo;

import lombok.Data;

@Data
public class BnbVO {
	private int lodgingNo; // lodgingId -> lodgingNo 로 변경
	private String lodgingName;
	private String lodgingAddress;
	private int price;
	private int maxPpl;
	private String lodgingDesc;
	private String lodgingType;
  
	// ★★★ 아래 두 필드를 추가해주세요 ★★★
	private double latitude;  // 위도
	private double longitude; // 경도
	
	// 테이블 통일 필요할꺼같네요
	// (경준)LodgingVO 사용했습니다.
}