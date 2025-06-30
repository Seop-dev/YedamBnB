package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class WishlistVO {
    // TBL_WISHLIST 테이블의 컬럼들
    private int wishlistId;
    private int userNo;
    private int lodgingId; 
    // accommodationId -> lodgingId 로 변경
    private Date createdAt;

    // JOIN을 통해 숙소 정보를 함께 보여주기 위한 추가 필드들
    private String name;           // 숙소 이름 (tbl_lodging)
    private int pricePerNight;     // 1박당 가격 (tbl_lodging)
    // 사진 정보는 팀의 새로운 규칙에 따라 나중에 추가해야 할 수 있으므로 우선 제외합니다.

}