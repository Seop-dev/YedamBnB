package com.yedambnb.mapper;
import com.yedambnb.vo.UserVO;

public interface MemberMapper {
    UserVO loginCheck(UserVO vo);
}
