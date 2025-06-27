package com.yedambnb.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.WishlistMapper;
import com.yedambnb.vo.WishlistVO;

// WishlistService 인터페이스를 '구현'하는 클래스입니다.
public class WishlistServiceImpl implements WishlistService {

    private SqlSession sqlSession = DataSource.getInstance().openSession(true);
    private WishlistMapper mapper = sqlSession.getMapper(WishlistMapper.class);

    @Override
    public List<WishlistVO> getWishlist(int userNo) {

        return mapper.selectWishlist(userNo);
    }
    @Override
    public boolean removeWishlist(int wishlistId) {
        // Mapper의 deleteWishlist를 호출하고,
        // 성공적으로 1개의 행이 삭제되었으면 true를, 아니면 false를 반환합니다.
        return mapper.deleteWishlist(wishlistId) == 1;
    }
}