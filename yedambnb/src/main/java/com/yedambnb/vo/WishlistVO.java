package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class WishlistVO {
    
    // TBL_WISHLIST의 컬럼
    private int wishlistId;
    private int userNo;
    private int lodgingId;
    private Date createdAt;

    // --- JOIN을 통해 TBL_LODGING에서 가져올 추가 정보 ---
    private String name;            // 숙소 이름
    private int pricePerNight;    // 1박 가격
    private String thumbnailImg;    // 썸네일 이미지 경로
    
}