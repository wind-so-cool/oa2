package com.cool.service.impl;

import com.cool.dao.UserMapper;
import com.cool.entity.Page;
import com.cool.entity.User;
import com.cool.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-07-06 11:21
 */
@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public int getUserCountByOrgId(Long id) {
        return userMapper.getUserCountByOrgId();
    }

    @Override
    public int getUserCountByOrgIds(Long[] ids) {
        return userMapper.getUserCountByOrgIds(ids);
    }

    @Override
    public PageInfo<User> getAuthorizedUserListByRoleId(String roleId, Page<User> page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<User> userList= userMapper.getAuthorizedUserListByRoleId(roleId);
        return new PageInfo<User>(userList);
    }
    @Transactional
    @Override
    public void delUserRole(Long userId, Long roleId) {
        userMapper.deleteUserRole(userId,roleId);
    }

    @Override
    public PageInfo<User> getToBeAuthorizedUserPage(Page<User> page, User user, String roleId) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<User> userList= userMapper.getToBeAuthorizedUser(user,roleId);
        return new PageInfo<User>(userList);
    }

    @Override
    public void authorizeUser(List<Long> userIds, Long roleId) {
        userMapper.authorizeUser(userIds,roleId);

    }

    @Override
    public User getMgrByUserId(Long userId) {
        return userMapper.getMgrByUserId(userId);
    }

    @Override
    public User getUserByUsername(Object username) {
        return userMapper.getUserByUsername(username);
    }
}
