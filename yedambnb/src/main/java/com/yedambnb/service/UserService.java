package com.yedambnb.service;

import com.yedambnb.vo.UserVO;

public interface UserService {
    boolean registerUser(UserVO user); //등록
    
    public UserVO isUserIdAvailable(String userId); //아이디 중복검사
    
    public UserVO login(String id, String pw); //아이디 비밀번호 검사
    
    //public boolean isUserIdExist(String userId); //아이디 중복검사
    
    
}
