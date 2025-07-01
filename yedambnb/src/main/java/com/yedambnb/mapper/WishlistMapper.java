// WishlistMapper.java
package com.yedambnb.mapper;

import java.util.List;
import com.yedambnb.vo.WishlistVO;

public interface WishlistMapper {
    // ▼▼▼ 메소드 이름을 getWishlist로 수정합니다 ▼▼▼
    public List<WishlistVO> getWishlist(int userNo);
    

    // 찜 해제 기능은 그대로 유지합니다.
    public int deleteWishlist(int wishlistId);
}