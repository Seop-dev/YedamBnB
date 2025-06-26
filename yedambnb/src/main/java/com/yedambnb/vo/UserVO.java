package com.yedambnb.vo;

import lombok.Data;
import java.util.Date;

@Data

public class UserVO {
    private int userNo;           // 회원번호
    private String userId;        // 아이디
    private String userPw;        // 비밀번호
    private String userName;      // 이름
    private String birthDate;     // 생년월일 (문자열 또는 java.sql.Date 사용 가능)
    private String telephone;     // 전화번호
    private String userAuthority; // 유저 권한 (user 또는 admin)
}
