package com.yedambnb.service;

import com.yedambnb.vo.MPReviewVO;

public interface MPReviewService {
    // 리뷰 등록 기능
   
    public boolean addReview(MPReviewVO review);
}