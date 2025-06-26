package com.yedambnb.service;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.UserMapper;
import com.yedambnb.vo.UserVO;

public class UserServiceImpl implements UserService {

	SqlSession sqlsession = DataSource.getInstance().openSession();
	UserMapper mapper = sqlsession.getMapper(UserMapper.class);

	@Override
	public boolean registerUser(UserVO user) {
		int r = mapper.insertUser(user);
		if(r==1) {
			sqlsession.commit();
			return true;
		}
		return false;
	}

	@Override
	public UserVO isUserIdAvailable(String userId) {
		return mapper.checkUserId(userId);
	}

	@Override
	public UserVO login(String id, String pw) {
	    return mapper.logincheck(id, pw); // 로그인 처리 (ID, PW 일치 확인)
	}

//	@Override
//	public boolean isUserIdExist(String userId) {
//	    return mapper.selectUserById(userId) != null; // true면 이미 존재
//	}

}
