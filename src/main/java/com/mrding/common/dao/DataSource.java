package com.mrding.common.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DataSource {
    
    private String driver;
    private String url;
    private String user;
    private String password;
    
    public DataSource(String driver, String url, String user, String password) {
	this.driver = driver;
	this.url = url;
	this.user = user;
	this.password = password;
    }

    /**
     * 获取连接
     * @return
     */
    public Connection getConn() {
	try {
            Class.forName(driver);
            return DriverManager.getConnection(url, user, password);
	} catch(Exception e) {
	   System.out.println("获取数据库连接失败...");
	   return null;
	} 
    }

}
