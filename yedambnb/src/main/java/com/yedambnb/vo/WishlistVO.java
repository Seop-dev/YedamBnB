package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class WishlistVO {
	public int wishlistId;
	public int userNo;
	public int accommodationId;
	public Date createdAt;
	public String name;           // 숙소 이름
	public int pricePerNight;     // 1박당 가격
	public String photoPath;      // 대표 이미지 경로
}