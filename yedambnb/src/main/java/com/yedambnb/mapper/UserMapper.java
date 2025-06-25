package com.yedambnb.mapper;

import com.yedambnb.vo.UserVO;

/*
 * UserMapper.java - UserMapper.xml과 매칭되는 인터페이스
 * 사용자 정보 조회 및 수정을 위한 메소드 정의
 */
public interface UserMapper {
    // 사용자 정보 한 건 조회 (로그인 또는 마이페이지 정보 로딩 시 사용)
    public UserVO selectUser(String userId);

    // 사용자 정보 수정 (마이페이지에서 이름, 연락처, 생년월일 등 수정)
    public int updateUser(UserVO user);
}