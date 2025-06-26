package com.yedambnb.mapper;

import java.util.List;

import com.yedambnb.vo.BookingVO;
/**
 * 예약(Booking) 관련 데이터베이스 작업을 위한 Mapper 인터페이스
 */
public interface BookingMapper {
 
    public List<BookingVO> getBookingsByUserId(String userId);

}