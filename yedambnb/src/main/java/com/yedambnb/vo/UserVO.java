package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class UserVO {
    private int userNo;
    private String userId;
    private String userPw;
    private String userName;
    private Date birthDate;
    private String telephone;
    private String userAuthority;
}

