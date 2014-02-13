package com.mrding.common.dao;

public class DSFactory {
    
    public static final DataSource CURRENT = new DataSource("org.mariadb.jdbc.Driver", "jdbc:mariadb://localhost:3306/zxkc", "root", "root");

}
