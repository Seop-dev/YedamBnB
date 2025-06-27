package com.yedambnb.service;

import java.util.List;
import com.yedambnb.vo.WishlistVO;

public interface WishlistService {
    // 특정 사용자의 위시리스트 목록을 가져오는 기능
    public List<WishlistVO> getWishlist(int userNo);
    public boolean removeWishlist(int wishlistId);
}