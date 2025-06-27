package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class MPReviewVO {
    // 최종 확정된 tbl_review 테이블의 컬럼과 1:1로 대응되는 필드들입니다.
    private int reviewId;
    private String userId;
    private String userName;
    private int lodgingNo; // accommodation_id -> lodging_no 로 변경
    private int score;
    private String commentText;
    // review_date는 테이블에 없으므로 삭제합니다.
}