package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class BookingVO {
    // tbl_booking 테이블의 컬럼들 (현재 DB 구조와 일치함)
    private int bookingId;
    private String userId;
    private int lodgingNo;
    private String userName;
    private int pricePerNight;
    private Date checkInDate;
    private Date checkOutDate;
    private int memberCount;
    private int fee;
    private int totalPrice;
    private String bookingStatus;

    // JOIN을 통해 가져올 정보들
    private String lodgingName;
    private String commentText;
    private Integer score;
    private String thumbnailImg;
}