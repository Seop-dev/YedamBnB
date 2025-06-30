package com.yedambnb.service;

import org.apache.ibatis.session.SqlSession;
import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.MemberMapper;
import com.yedambnb.vo.MemberVO;

public class MemberServiceImpl implements MemberService {
    @Override
    public MemberVO login(MemberVO vo) {
        try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
            MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
            return mapper.loginCheck(vo);
        }
    }
}