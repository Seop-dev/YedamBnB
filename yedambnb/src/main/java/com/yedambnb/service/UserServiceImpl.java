package com.yedambnb.service;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.UserMapper;
import com.yedambnb.vo.UserVO;

public class UserServiceImpl implements UserService {
	  private MemberService service = new MemberServiceImpl();
    
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


    @Override
    public boolean removeUser(int userNo) {
        // Mapper의 deleteUser를 호출하고,
        // 성공적으로 1개의 행이 삭제되었으면 true를, 아니면 false를 반환합니다.
        return mapper.deleteUser(userNo) == 1;
    }

    @Override
    public UserVO login(UserVO vo) {
        return service.login(vo);
    }

}
