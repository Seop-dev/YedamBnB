package com.yedambnb.service;

import java.util.List;
import com.yedambnb.vo.BnbVO;

public interface BnbService {
    List<BnbVO> searchBnbList(String keyword);
}