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
	

}
