package com.yedambnb.mapper;

import com.yedambnb.vo.MemberVO;

public interface MemberMapper {
    MemberVO loginCheck(MemberVO vo);
}