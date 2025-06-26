package com.yedambnb.service;

import com.yedambnb.vo.UserVO;

public interface UserService {
    
    // 사용자 정보 상세 조회
    public UserVO getUser(String userId);
    
    // 사용자 정보 수정
    public boolean modifyUser(UserVO user);
    
    //=========== 회원등록 및 로그인(동원) ===============
    // 회원등록
    boolean registerUser(UserVO user); 
    //아이디 중복검사
    public UserVO isUserIdAvailable(String userId); 
    //아이디 비밀번호 검사
    public UserVO login(String id, String pw);
}
