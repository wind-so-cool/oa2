package com.cool.dao;

import com.cool.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper extends BaseMapper<User>{

    int getUserCountByOrgId();

    int getUserCountByOrgIds(Long[] ids);

    List<User> getAuthorizedUserListByRoleId(String roleId);


    void deleteUserRole(@Param("userId")Long userId,@Param("roleId") Long roleId);


    List<User> getToBeAuthorizedUser(@Param("user")User user, @Param("roleId")String roleId);

    void authorizeUser(@Param("userIds") List<Long> userIds, @Param("roleId") Long roleId);

    User getMgrByUserId(Long userId);

    User getUserByUsername(Object username);
}