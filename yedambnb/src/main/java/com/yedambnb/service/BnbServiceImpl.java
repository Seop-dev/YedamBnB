package com.yedambnb.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource; // MyBatis SqlSession을 가져오는 클래스
import com.yedambnb.mapper.BnbMapper;
import com.yedambnb.vo.BnbVO;

public class BnbServiceImpl implements BnbService {

    // try-with-resources 구문을 사용하여 SqlSession을 자동으로 닫아줍니다.
    @Override
    public List<BnbVO> searchBnbList(String keyword) {
        try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
            BnbMapper mapper = sqlSession.getMapper(BnbMapper.class);
            return mapper.searchBnbList(keyword);
        }
    }
}