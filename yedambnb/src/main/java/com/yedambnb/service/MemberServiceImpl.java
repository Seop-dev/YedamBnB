package com.yedambnb.service;

import org.apache.ibatis.session.SqlSession;
import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.MemberMapper;
import com.yedambnb.vo.UserVO;

public class MemberServiceImpl implements MemberService {
    @Override
    public UserVO login(UserVO vo) {
        try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
            MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
            return mapper.loginCheck(vo);
        }
    }
}
