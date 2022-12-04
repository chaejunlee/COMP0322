package businfo;

import java.sql.*;
import java.util.ArrayList;
import config.Properties;

public class BusDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public BusDAO() {
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
	
	public ArrayList<Businfo> getList(Businfo info){		
		String sql = "SELECT * "
				+ "FROM TIMETABLE T, ROUTE R "
				+ "WHERE T.TDATE = TO_DATE(?, 'yy/mm/dd') "
				+ "AND T.DEPART_TIME >= TO_DATE(?, 'yy/mm/dd HH24:MI') "
				+ "AND T.TRID = R.RID "
				+ "AND R.DSTATION = ? AND R.ASTATION = ?";
		ArrayList<Businfo> list = new ArrayList<Businfo>();
				
		try {
			pstmt = conn.prepareStatement(sql);
			String dtime = info.getDdate() + " " + info.getTime();
			pstmt.setString(1, info.getDdate());
			pstmt.setString(2, dtime);
			pstmt.setString(3, info.getDstation());
			pstmt.setString(4, info.getAstation());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Businfo businfo = new Businfo();
				businfo.setDdate(rs.getString(3).substring(0, 10));
				businfo.setTime(rs.getString(3).substring(11, 16));
				businfo.setDstation(rs.getString(8));
				businfo.setAstation(rs.getString(9));
				businfo.setTid(rs.getString(1));
				list.add(businfo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
			return list;
		}
}
