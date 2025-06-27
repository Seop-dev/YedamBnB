package com.yedambnb.mapper;

import java.util.List;
import com.yedambnb.vo.WishlistVO;

public interface WishlistMapper {
    // 특정 사용자의 위시리스트 목록을 조회하는 메소드
    public List<WishlistVO> selectWishlist(int userNo);
    
    public int deleteWishlist(int wishlistId);
    
}