package com.cool.test;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.junit.Test;

/**
 * @Author 许俊青
 * @Date: 2021-12-05 19:48
 */
public class ShiroTest {

    @Test
    public void pwdEncrypt(){
        String algorithmName="MD5";
        String source="admin";
        Object salt= ByteSource.Util.bytes(source);
        int hashIterations=1024;
        SimpleHash hash=new SimpleHash(algorithmName,  source,  salt,  hashIterations);
        System.out.println(hash);
    }
}
