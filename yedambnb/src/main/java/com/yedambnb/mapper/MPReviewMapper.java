package com.yedambnb.mapper;

import java.util.List;

import com.yedambnb.vo.MPReviewVO;

public interface MPReviewMapper {
    // 최종 확정된 테이블 구조에 맞게 리뷰를 등록하는 메소드
    public int insertReview(MPReviewVO review);
    
    // 리뷰조회
    public List<MPReviewVO> selectReview(int lodgingId);
}