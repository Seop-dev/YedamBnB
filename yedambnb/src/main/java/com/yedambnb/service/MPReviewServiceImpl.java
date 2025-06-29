package com.yedambnb.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.MPReviewMapper;
import com.yedambnb.vo.MPReviewVO;

// MPReviewService 인터페이스를 '구현'하는 클래스.
public class MPReviewServiceImpl implements MPReviewService {

    private SqlSession sqlSession = DataSource.getInstance().openSession(true);
    private MPReviewMapper mapper = sqlSession.getMapper(MPReviewMapper.class);

    @Override
    public boolean addReview(MPReviewVO review) {
        // MPReviewMapper의 insertReview를 호출하고,
      
        return mapper.insertReview(review) == 1;
    }

    // 리뷰조회
	@Override
	public List<MPReviewVO> selectReview(int accommodationId) {
		return mapper.selectReview(accommodationId);
	}
    
    
}