package com.yedambnb.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.WishlistMapper;
import com.yedambnb.vo.WishlistVO;

public class WishlistServiceImpl implements WishlistService {

    private SqlSession sqlSession = DataSource.getInstance().openSession(true);
    private WishlistMapper mapper = sqlSession.getMapper(WishlistMapper.class);

    // [수정] 인터페이스와 동일하게 파라미터 타입을 String userId로 변경합니다.
    @Override
    public List<WishlistVO> getWishlist(int userNo) {
        return mapper.selectWishlist(userNo);
    }

    @Override
    public boolean removeWishlist(int wishlistId) {
        return mapper.deleteWishlist(wishlistId) == 1;
    }
}