package com.yedambnb.mapper;

import java.util.List;
import com.yedambnb.vo.BnbVO;

public interface BnbMapper {
	// BnbMapper.xml의 select id와 메소드 이름이 같아야 합니다.
	List<BnbVO> searchBnbList(String keyword);
}