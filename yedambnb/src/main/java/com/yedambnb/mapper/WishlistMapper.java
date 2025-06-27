package com.yedambnb.mapper;

import java.util.List;
import com.yedambnb.vo.WishlistVO;

public interface WishlistMapper {
    // 파라미터 타입을 int userNo로 그대로 유지합니다 (tbl_wishlist는 user_no를 사용).
    public List<WishlistVO> selectWishlist(int userNo);

    // 찜 해제 기능은 그대로 유지합니다.
    public int deleteWishlist(int wishlistId);
}