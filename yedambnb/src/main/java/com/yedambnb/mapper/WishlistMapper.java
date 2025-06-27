package com.yedambnb.mapper;

import java.util.List;
import com.yedambnb.vo.WishlistVO;

public interface WishlistMapper {
    // [수정] 파라미터를 다시 int userNo로 되돌립니다.
    public List<WishlistVO> selectWishlist(int userNo);

    public int deleteWishlist(int wishlistId);
}