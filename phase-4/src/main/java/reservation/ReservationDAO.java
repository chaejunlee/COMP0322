package reservation;

import java.sql.*;
import java.util.ArrayList;

import businfo.Businfo;

public class ReservationDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Statement stmt = null;
	private String sql;

	public ReservationDAO() {
		try {
			String serverIP = "localhost";
			String strSID = "orcl";
			String portNum = "1521";
			String user = "BUS";
			String pass = "comp322";
			String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			conn.setAutoCommit(false);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Reservation> getSeat(String tid, String dstation, String astation, String ddate, String dtime){		
		
		sql = "SELECT SID FROM SEAT WHERE SID NOT IN (SELECT DISTINCT RE.RSID"
				+ " FROM ROUTE RO, TIMETABLE T, RESERVATION RE"
				+ " WHERE RO.DSTATION='"+ dstation + "' AND RO.ASTATION='" + astation 
				+ "' AND T.TRID=RO.RID AND T.TDATE = TO_DATE('" + ddate + "', 'yy/mm/dd')"
				+ " AND T.DEPART_TIME=TO_DATE('" + ddate + " " + dtime + "', 'yy/mm/dd HH24:MI')"
				+ " AND T.TID = RE.RTID) ORDER BY SID ASC";
		
		ArrayList<Reservation> list = new ArrayList<Reservation>();
				
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);			
			while(rs.next()) {
				Reservation reserve = new Reservation();
				reserve.setRtid(tid);
				reserve.setRsid(rs.getString(1));
				list.add(reserve);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
			return list;
		}
	
	public int completeReserve(Reservation reservation, String userAID, String tid, String sid, int fee) {
		
		int price = 0;
		sql = "SELECT POINT FROM ACCOUNT WHERE AID = '" + userAID + "'";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);			
			while(rs.next()) {
				price = rs.getInt(1) - fee;
				if(price < 0) {
					return 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
		
		sql = "UPDATE ACCOUNT SET POINT = " + price + " WHERE AID = '" + userAID + "'"; 
		try {
			stmt = conn.createStatement();
			int count = stmt.executeUpdate(sql);			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
		
		sql = "INSERT INTO RESERVATION VALUES(?, ?, ?)";
		reservation.setRaid(userAID);
		reservation.setRtid(tid);
		
		String[] list = sid.split(",");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userAID);
			pstmt.setString(3, tid);
			
			for(int i = 0; i < list.length; i++) {
				pstmt.setString(2,  list[i]);
				int cnt = pstmt.executeUpdate();
			}
			conn.commit();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}

	}
	

}
