package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class BookingVO {
    // tbl_booking 테이블의 컬럼들
    private int bookingId;
    private int userNo;
    private int lodgingNo;
    private Date checkInDate;
    private Date checkOutDate;
    private int adults;
    private int children;
    private int totalPrice;
    private String bookingStatus;

    // JOIN을 통해 다른 테이블에서 가져온 정보
    private String name;           // [수정] accommodationName -> name
    private int pricePerNight;     // [추가] 1박당 가격 필드
    private String photoPath;      // 이미지 경로 필드
    
    private Integer score;       // 리뷰가 없을 수도 있으므로, null을 허용하는 Integer 타입 사용
    private String commentText;
    
    // userNo 제거 필요
    // 인원(person) 컬럼 추가 필요
    private int userId;
}