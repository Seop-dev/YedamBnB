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
}
