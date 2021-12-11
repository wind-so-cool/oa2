package com.cool.service;

import com.cool.entity.Page;
import com.cool.entity.User;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @Author 许俊青
 * @Date: 2021-07-06 11:20
 */
public interface UserService extends BaseService<User> {
    int getUserCountByOrgId(Long id);

    int getUserCountByOrgIds(Long[] ids);

    PageInfo<User> getAuthorizedUserListByRoleId(String roleId, Page<User> page);

    void delUserRole(Long userId, Long roleId);

    PageInfo<User> getToBeAuthorizedUserPage(Page<User> page, User user, String roleId);

    void authorizeUser(List<Long> userIds, Long roleId);

    User getMgrByUserId(Long userId);

    User getUserByUsername(Object username);
}
