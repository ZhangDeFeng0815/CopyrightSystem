package com.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * 
 * @Package com.imooc.test
 * @Description: Just Test
 * @author Beyond
 * @date 2015-3-4 上午10:39:22
 * @version V1.0
 */
public class CreateTable {
	public static void main(String[] args) {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://172.23.0.40:3306/nrps?useUnicode=true&characterEncoding=UTF-8";
			con = DriverManager.getConnection(url, "nrps", "nrps");
			for(int i =0; i < 128; i++){
				String sql = "CREATE TABLE `content_node_"+i+"` ("
						+ "`id` bigint NOT NULL AUTO_INCREMENT,"
						+ "`nodeId` bigint DEFAULT NULL,"
						+ "`parent_nodeId` bigint DEFAULT NULL,"
						+ "`content_id` bigint DEFAULT NULL,"
						+ "`node_name` varchar(255) DEFAULT NULL,"
						+ "`metadata_id` bigint DEFAULT NULL,"
						+ "`wordcount` bigint DEFAULT NULL,"
						+ "`content` longtext DEFAULT NULL,"
						+ "`temp_node_status` varchar(2) DEFAULT NULL,"
						+ "`temp_content_status` varchar(2) DEFAULT NULL,"
						+ "`node_index` int(11) DEFAULT NULL,"
						+ "`status` varchar(2) DEFAULT NULL,"
						+ "`version` varchar(2) DEFAULT NULL,"
						+ "`create_date` char(17) DEFAULT NULL,"
						+ "`update_date` char(17) DEFAULT NULL,"
						+ "`create_userid` bigint DEFAULT NULL,"
						+ "`update_userid` bigint DEFAULT NULL,"
						+ "PRIMARY KEY (`id`),"
						+ "UNIQUE KEY `id_UNIQUE` (`id`)"
						+ ") ENGINE=InnoDB DEFAULT CHARSET=utf8";
				java.sql.Statement stmt = con.createStatement();
				stmt.executeUpdate(sql);
			}
               System.out.println("!!!!!!!!!!!");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
