package com.hyeontae.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	static {
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		
		try (Connection con = 
				DriverManager.getConnection(
						"jdbc:mariadb://localhost:3306/lsnwan",
						"root",
						"1234")) {
			
			log.info("마리아DB 접속 성공");
			
		} catch (Exception e) {
			fail(e.getMessage());
			log.info("마리아DB 접속 실패");
		}
		
	}
}
