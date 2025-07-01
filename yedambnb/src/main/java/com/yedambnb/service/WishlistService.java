package com.yedambnb.service;

import java.util.List;
import com.yedambnb.vo.WishlistVO;

public interface WishlistService {
    // [수정] 파라미터를 다시 int userNo로 되돌립니다.
    public List<WishlistVO> getWishlist(int userNo);

    public boolean removeWishlist(int wishlistId);
}