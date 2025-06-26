package com.yedambnb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class UserVO {
	public int userNo;
	public String userId;
	public String userPw;
	public String userName;
	public Date birthDate;
	public String telephone;
	public String userAuthority;
}
