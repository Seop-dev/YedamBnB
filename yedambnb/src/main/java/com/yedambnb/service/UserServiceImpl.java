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
    @Override
    public boolean removeUser(int userNo) {
        // Mapper의 deleteUser를 호출하고,
        // 성공적으로 1개의 행이 삭제되었으면 true를, 아니면 false를 반환합니다.
        return mapper.deleteUser(userNo) == 1;
    }
}
