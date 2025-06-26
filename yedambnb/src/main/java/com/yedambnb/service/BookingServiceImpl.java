package com.yedambnb.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.BookingMapper;
import com.yedambnb.vo.BookingVO;

public class BookingServiceImpl implements BookingService {

    // DB 커넥션과 SQL 실행을 위한 세션 객체를 DataSource로부터 얻어옵니다.
    // openSession(true)는 자동 커밋(auto-commit)을 의미합니다.
	public SqlSession sqlSession = DataSource.getInstance().openSession(true);
    
    // sqlSession을 통해 BookingMapper 인터페이스의 구현체를 얻어옵니다.
    // 이 mapper 객체를 통해 XML에 정의된 SQL을 실행할 수 있습니다.
	public BookingMapper mapper = sqlSession.getMapper(BookingMapper.class);

    @Override
    public List<BookingVO> getBookingsByUserId(String userId) {
        // Controller로부터 받은 userId를 Mapper에게 그대로 전달하고
        // Mapper가 DB에서 조회한 결과를 Controller에게 그대로 반환합니다.
        return mapper.getBookingsByUserId(userId);
    }

}