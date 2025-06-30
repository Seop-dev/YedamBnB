package com.yedambnb.service;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.MPReviewMapper;
import com.yedambnb.vo.MPReviewVO;

public class MPReviewServiceImpl implements MPReviewService {

    private SqlSession sqlSession = DataSource.getInstance().openSession(true);
    private MPReviewMapper mapper = sqlSession.getMapper(MPReviewMapper.class);

    @Override
    public boolean addReview(MPReviewVO review) {
        // 수정된 Mapper의 insertReview를 호출합니다.
        return mapper.insertReview(review) == 1;
    }
}