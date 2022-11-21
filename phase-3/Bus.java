// Team5-phase 3-BUS in Console 

package Bus;

import java.sql.*;

public class Bus {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_ID = "BUS";	// id: BUS
	public static final String USER_PASSWD = "comp322";	// pw: comp322
	
	public static void main(String[] args) {
		Connection conn = null;	// Connection object
		Statement stmt = null; // Statement object

		try {
			// Load a JDBC driver for Oracle DMBS
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//	Get a Connection object
			System.out.println("Driver Loading: Success!");
		}catch(ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}
		
		//	Make a connection
		try {
			conn = DriverManager.getConnection(URL, USER_ID, USER_PASSWD);
			System.out.println("Oracle Connected.");
		}catch(SQLException ex) {
			ex.printStackTrace();
			System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
			System.err.println("Cannot get a connection: " + ex.getMessage());
			System.exit(1);
		}
		
		//	Create statement object and auto commit false
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
		}catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
		
		// execute code and query
		Menu.menu(conn, stmt);
		
		// close stmt and conn
		try {
			stmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
