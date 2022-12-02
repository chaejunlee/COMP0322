package busdetails;

import java.sql.*;
import java.util.ArrayList;

public class BusDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public BusDAO() {
		try {
			String serverIP = "localhost";
			String strSID = "xe";
			String portNum = "1600";
			String user = "BUS_25";
			String pass = "qwe123";
			String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Busdetails> getDetails(String tid) {
		String sql = "SELECT B.BID, B.BCOMPANY, B.BTYPE, E.FNAME, E.LNAME, round((cast(arrive_time as date)-cast(depart_time as date))*24*60,2) as diff_MI "
				+ "FROM TIMETABLE T, BUS B, DRIVES D, EMPLOYEE E " + "WHERE T.TID = ? "
				+ "AND B.BID = T.TBID AND D.DBID = T.TBID AND D.DSSN = E.SSN";
		ArrayList<Busdetails> list = new ArrayList<Busdetails>();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tid);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Busdetails busdetails = new Busdetails();
				busdetails.setBid(rs.getString(1));
				busdetails.setBcompany(rs.getString(2));
				busdetails.setBtype(rs.getString(3));
				busdetails.setFname(rs.getString(4));
				busdetails.setLname(rs.getString(5));
				busdetails.setDiff_mi(rs.getString(6));
				list.add(busdetails);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Busfee> getFee(String tid) {
		String sql = "SELECT P.AGE, P.FEE " + "FROM TIMETABLE T, PRICE P, BUS B " + "WHERE T.TID = ? "
				+ "AND P.PRID = TRID AND T.TBID = B.BID AND B.BTYPE = P.BUSTYPE";
		ArrayList<Busfee> list = new ArrayList<Busfee>();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tid);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Busfee busfee = new Busfee();
				busfee.setAge(rs.getString(1));
				busfee.setFee(rs.getString(2));
				list.add(busfee);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
