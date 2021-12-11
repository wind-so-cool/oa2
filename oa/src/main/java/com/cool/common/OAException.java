package com.cool.common;

/**
 * @Author 许俊青
 * @Date: 2021-09-20 21:08
 */
public class OAException extends RuntimeException {

    public OAException() {
    }

    public OAException(String message) {
        super(message);
    }
}
