package com.yedambnb.service;

import com.yedambnb.vo.UserVO;

public interface UserService {
    
    // 사용자 정보 상세 조회
    public UserVO getUser(String userId);
    
    // 사용자 정보 수정
    public boolean modifyUser(UserVO user);
    
}
