package com.mrding.zxkc.web;

import java.util.*;

import com.mrding.common.CommonUtils;
import com.mrding.zxkc.utils.Authority;
import com.opensymphony.xwork2.ActionContext;

public class LoginAction {
        
    private String username;
    private String password;

    //用于返回json到前台
    private Map<String, Object> jsonMap = new HashMap<String, Object>();

    public Map<String, Object> getJsonMap() {
        return jsonMap;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String execute() {
        String username = getUsername();
        String password = getPassword();
        if (!CommonUtils.isNotBlank(username) && !CommonUtils.isNotBlank(password)) {
            return "login";
        } else {
            if (!CommonUtils.isNotBlank(username) || !username.equals("Admin")) {
                jsonMap.put("loginErrorMsg", "您输入的用户名不正确！");
            } else if (!CommonUtils.isNotBlank(password) || !password.equals("580231")) {
                jsonMap.put("loginErrorMsg", "您输入的密码不正确！");
            } else {
                    jsonMap.put("success", true);
            }
            return "success";
        }
    }
	
}
