package user;

import java.sql.*;
import config.Properties;

public class UserDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Statement stmt = null;
	private String sql;
	private String aid;

	public UserDAO() {
		try {
			String serverIP = Properties.serverIP;
			String strSID = Properties.strSID;
			String portNum = Properties.portNum;
			String user = Properties.user;
			String pass = Properties.pass;
			String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			conn.setAutoCommit(false);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(User user) {
		sql = "SELECT PW FROM ACCOUNT WHERE EMAIL = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserEmail());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString(1).equals(user.getUserPassword())) {
					sql = "SELECT A.AID FROM ACCOUNT A WHERE A.EMAIL = '" + user.getUserEmail() + "'";
					 try { 
						 stmt = conn.createStatement(); 
						 rs = stmt.executeQuery(sql);
						 
						 if(rs.next()) {
							 String Aid = rs.getString(1);
							 user.setUserAid(Aid);
						 }
						 return 1; // success login
					
					 }catch(Exception e) { 
						 e.printStackTrace(); 
						 return -2; //error 
					 }

				} else {
					return 0; // no match password
				}
			}

			rs.close();
			pstmt.close();
			return -1; // no id
		} catch (Exception e) {
			e.printStackTrace();
			return -2; // error
		}
	}

	public int signup(User user) {
		sql = "SELECT COUNT(AID) FROM ACCOUNT";
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				int cnt = rs.getInt(1);
				aid = String.format("%09d", cnt);
				 user.setUserAid(aid); 
				 user.setUserPoint(0); 
			}
			 
		} catch (Exception e) {
			e.printStackTrace();
			return -2;
		}

		sql = "INSERT INTO ACCOUNT VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserAid());
			pstmt.setString(2, user.getUserFname());
			pstmt.setString(3, user.getUserLname());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserPassword());
			pstmt.setString(6, user.getUserPhone());
			pstmt.setInt(7, user.getUserPoint());
			pstmt.executeUpdate();
			pstmt.close();

			conn.commit();
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return -1; // error
		}
	}
	
	public int getPoint(String aid) {
		int point = 0;
		sql = "SELECT POINT FROM ACCOUNT WHERE AID ='" + aid + "'";
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				point = rs.getInt(1);
			}
			 return point;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
}
