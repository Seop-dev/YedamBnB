package com.yedambnb.service;

import java.util.List;

import com.yedambnb.vo.MPReviewVO;

public interface MPReviewService {
    // 리뷰 등록 기능
   
    public boolean addReview(MPReviewVO review);
    
    // 리뷰조회
    public List<MPReviewVO> selectReview(int accommodationId);
}