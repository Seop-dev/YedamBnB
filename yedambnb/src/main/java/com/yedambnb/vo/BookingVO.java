package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class BookingVO {
    // tbl_booking 테이블의 컬럼들
    private int bookingId;
    private String userId;
    private int lodgingId;
    private String userName;
    private int pricePerNight;
    private Date checkInDate;
    private Date checkOutDate;
    private int memberCount;
    private int fee;
    private int totalPrice;
    private String bookingStatus;

    // JOIN을 통해 가져올 정보들
    private String lodgingName;   // tbl_lodging의 name
    private String commentText;   // tbl_review의 comment_text
    private Integer score;        // 리뷰가 없을 수도 있으므로 Integer
}