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
}