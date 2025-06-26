package com.yedambnb.service;

import org.apache.ibatis.session.SqlSession;
import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.UserMapper;
import com.yedambnb.vo.UserVO;

public class UserServiceImpl implements UserService {

    
    SqlSession sqlSession = DataSource.getInstance().openSession(true);
    UserMapper mapper = sqlSession.getMapper(UserMapper.class);

    @Override
    public UserVO getUser(String userId) {
        
        return mapper.selectUser(userId);
    }

    @Override
    public boolean modifyUser(UserVO user) {
      
        return mapper.updateUser(user) == 1;
    }
    
    // ============ 회원가입 및 로그인(동원) =============
    // 회원등록
    @Override
	public boolean registerUser(UserVO user) {
		int r = mapper.insertUser(user);
		if(r==1) {
			sqlSession.commit();
			return true;
		}
		return false;
	}
    //아이디 중복검사
	@Override
	public UserVO isUserIdAvailable(String userId) {
		return mapper.checkUserId(userId);
	}
	//아이디 비밀번호 검사
	@Override
	public UserVO login(String id, String pw) {
	    return mapper.logincheck(id, pw); // 로그인 처리 (ID, PW 일치 확인)
	}

}
