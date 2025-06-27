package com.yedambnb.vo;

import lombok.Data;

@Data
public class LodgingVO {
	public int lodgingId;
	public String description;
	public String address;
	public int lat;
	public int lng;
	public int pricePerNight;
	
}
