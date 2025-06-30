package com.yedambnb.mapper;

import org.apache.ibatis.annotations.Param;

import com.yedambnb.vo.UserVO;

public interface UserMapper {
    // 사용자 정보 한 건 조회 (로그인 또는 마이페이지 정보 로딩 시 사용)
    public UserVO selectUser(String userId);

    // 사용자 정보 수정 (마이페이지에서 이름, 연락처, 생년월일 등 수정)
    public int updateUser(UserVO user);

    // ========== 회원가입 및 로그인(동원) =============
    // 회원가입
    int insertUser(UserVO user);
    //사용가능아이디
    public UserVO checkUserId(String userId); 
    // 아이디:비밀번호
    UserVO logincheck(@Param("id") String id, @Param("pw") String pw);

    public int deleteUser(int userNo);

}