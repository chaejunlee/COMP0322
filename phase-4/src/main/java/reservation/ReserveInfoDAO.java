package reservation;

import java.sql.*;

public class ReserveInfoDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Statement stmt = null;
	private String sql;

	public ReserveInfoDAO() {
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
	
	public ReservationInfo getReserve(ReservationInfo reserve, String[] sidList){		
			
			String[] priceList = {"18+", "18-", "9-"};
			String str = "";
			int[] price = {0, 0, 0};
			int[] arr = {Integer.valueOf(reserve.getAdult()), Integer.valueOf(reserve.getTeenager()), Integer.valueOf(reserve.getChild())};
			int total = 0;
			
			sql = "SELECT T.TRID, B.BTYPE FROM TIMETABLE T, BUS B WHERE TID = ? AND T.TBID = B.BID";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, reserve.getTid());
				rs = pstmt.executeQuery();

				if (rs.next()) {
					String rid = rs.getString(1);
					String btype = rs.getString(2);
				
					pstmt = conn.prepareStatement(sql);
					try {
						stmt = conn.createStatement();			
						for(int i = 0; i < arr.length; i++) {
							if(arr[i] != 0) {
								sql = "SELECT FEE FROM PRICE WHERE AGE = '" + priceList[i] + "' AND BUSTYPE = '"
										+ btype + "' AND PRID = '" + rid + "'";
								rs = stmt.executeQuery(sql);
								
								while(rs.next()) {
									price[i] = rs.getInt(1);
								}
							}
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				for(int i = 0; i < arr.length; i++) {
					total += price[i] * arr[i];
				}
				
				for(int i = 0; i < sidList.length; i++) {
					str += sidList[i];
					if(i != (sidList.length -1)) {
						str += ", ";
					}
				}
				
				reserve.setPrice(total);
				reserve.setSid(str);
			}catch (Exception e) {
				e.printStackTrace();
			}
			return reserve;
	}
}
