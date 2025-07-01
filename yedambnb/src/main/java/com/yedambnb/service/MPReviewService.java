package com.yedambnb.service;

import java.util.List;

import com.yedambnb.vo.MPReviewVO;

public interface MPReviewService {
    // 최종 확정된 테이블 구조에 맞게 리뷰를 등록하는 기능
    public boolean addReview(MPReviewVO review);
    
    // 리뷰조회
    public List<MPReviewVO> selectReview(int accommodationId);
}