package com.yedambnb.service;

import java.util.List;

import com.yedambnb.vo.BookingVO;

public interface BookingService {

   
    public List<BookingVO> getBookingsByUserId(String userId);

}