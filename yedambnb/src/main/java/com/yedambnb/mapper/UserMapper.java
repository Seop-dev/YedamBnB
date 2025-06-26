package com.yedambnb.mapper;

import org.apache.ibatis.annotations.Param;

import com.yedambnb.vo.UserVO;

public interface UserMapper {
    // 회원가입
    int insertUser(UserVO user);
    
    
    public UserVO checkUserId(String userId); //사용가능아이디
    
    // 아이디:비밀번호
    UserVO logincheck(@Param("id") String id, @Param("pw") String pw);

    
    //public UserVO selectUserById(String userId);
    
}
