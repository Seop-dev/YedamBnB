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
	private double latitude;
	private double longitude;
}