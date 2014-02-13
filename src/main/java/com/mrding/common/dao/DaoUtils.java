package com.mrding.common.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DaoUtils {

    public static List<Object[]> queryBySql(String sql, DataSource ds) {
	List<Object[]> list = new ArrayList<Object[]>();
	Connection conn = ds.getConn();
	Statement stmt = null;
	ResultSet rs = null;
	try {
	    stmt = conn.createStatement();
	    rs = stmt.executeQuery(sql);
	    ResultSetMetaData rsmd = rs.getMetaData();
	    int colCount = rsmd.getColumnCount();
	    while (rs.next()) {
		Object[] objs = new Object[colCount];
		for (int i = 0; i < colCount; i++) {
		    objs[i] = rs.getObject(i + 1);
		}
		list.add(objs);
	    }
	} catch(Exception e) {
	} finally {
	    close(conn, stmt, rs);
	}
	return list;
    }

    public static void close(Connection conn, Statement stmt, ResultSet rs) {
	try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
	} catch(Exception e) {
	}
    }

    public static void updateBySql(String sql, DataSource ds) throws SQLException {
	Connection conn = ds.getConn();
	Statement stmt = null;
	try {
	    stmt = conn.createStatement();
	    stmt.executeUpdate(sql);
	} finally {
	    DaoUtils.close(conn, stmt, null);
	}
    }

}
