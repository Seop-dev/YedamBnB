package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class MPReviewVO {
  
    private int reviewId;
    private int userNo;
    private String userName;
    private int accommodationId;
    private int score;
    private String commentText;
    private Date reviewDate;
}