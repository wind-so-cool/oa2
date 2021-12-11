package com.cool.realm;

import com.cool.entity.Menu;
import com.cool.entity.User;
import com.cool.service.MenuService;
import com.cool.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 安全数据源
 */
public class UserRealm extends AuthorizingRealm{

	@Autowired
	private UserService userService;

	@Autowired
	private MenuService menuService;



	/**
	 * 给用户授权
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		User user= (User) SecurityUtils.getSubject().getPrincipal();
		List<Menu> menuList=menuService.getMenuListByUserId(user.getUserId());
		Set<String> permissions=menuList.stream().map(Menu::getPermissionCode).filter(p-> StringUtils.isNotBlank(p)).collect(Collectors.toSet());
		SimpleAuthorizationInfo authorizationInfo=new SimpleAuthorizationInfo();
		authorizationInfo.setStringPermissions(permissions);
		return authorizationInfo;
	}

	/**
	 *认证用户
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		Object username=token.getPrincipal();
		User user=userService.getUserByUsername(username);
		Object credentials=token.getCredentials();
		SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(user, user.getUserPassword(), ByteSource.Util.bytes(username), getName());
		return info;
	}

}
