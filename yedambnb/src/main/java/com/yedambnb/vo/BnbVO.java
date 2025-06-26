package com.yedambnb.vo;

import lombok.Data;

@Data // Getter, Setter, toString 등을 자동으로 생성해주는 Lombok 어노테이션
public class BnbVO {
	private int lodgingId;
	private String lodgingName;
	private String lodgingAddress;
	private int price;
	private int maxPpl;
	private String lodgingDesc;
	private String lodgingType;
}