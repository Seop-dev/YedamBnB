package com.yedambnb.vo;

import lombok.Data;

@Data
public class LodgingVO {
    private int lodgingId;
    private int lodgingNo;
    private String name;
    private String description;
    private String address;
    private double lat;
    private double lng;
    private int pricePerNight;
    
    // 썸네일 이미지 파일명을 담을 필드 추가 
    private String thumbnailImg;
}