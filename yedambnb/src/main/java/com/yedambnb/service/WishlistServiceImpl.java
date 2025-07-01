package com.yedambnb.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.WishlistMapper;
import com.yedambnb.vo.WishlistVO;

public class WishlistServiceImpl implements WishlistService {

    private SqlSession sqlSession = DataSource.getInstance().openSession(true);
    private WishlistMapper mapper = sqlSession.getMapper(WishlistMapper.class);

    @Override
    public List<WishlistVO> getWishlist(int userNo) {
        // ▼▼▼ 여기를 mapper.getWishlist(userNo)로 수정합니다 ▼▼▼
        return mapper.getWishlist(userNo);
    }

    @Override
    public boolean removeWishlist(int wishlistId) {
        return mapper.deleteWishlist(wishlistId) == 1;
    }
}