package Bus;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Menu {
	static Scanner sc = new Scanner(System.in);	
	static ResultSet rs;
	
	public static void menu(Connection conn, Statement stmt) {
		
		System.out.println("----------------------- KNU BUS SERVICE -----------------------");
		
		while(true) {
			
			System.out.println("----------------------- MENU -----------------------");
			System.out.println("<Login stage>");
			System.out.println(" 1. Login");	
			System.out.println(" 2. Find ID(email)\n");
			
			System.out.println("<Search bus information>");
			System.out.println(" 3. Query possible arrivals (arriving station) with departure (departing station)");	// document에서 11번 query
			System.out.println(" 4. Query bus type with departing/arriving station");	
			System.out.println(" 5. Query detailed bus information with departing/arriving station");	// document에서 6번 query
			System.out.println(" 6. Query bus seat information with departing/arriving station, date and time\n");	// document에서 5번 query
			
			System.out.println("<Find my reservation information>");
			System.out.println(" 7. Create reservation");	
			System.out.println(" 8. Update reservation ");
			System.out.println(" 9. Delete reservation ");
			System.out.println("10. Find my reservation information");	// document에서 3번 query
			System.out.println("11. Show detailed information of my ticket\n");	// document에서 10번 query
			
			System.out.println("12. Exit BUS SERVICE");
			System.out.println("----------------------------------------------------");
			
			System.out.print("Select menu and input a number of menu: ");
			
			switch(sc.nextInt()) {
				case 1:
					funct1(conn, stmt);
					break;
				case 2:
					funct2(conn, stmt);
					break;
				case 3:
					funct3(conn, stmt);
					break;
				case 4:
					funct4(conn, stmt);
					break;
				case 5:
					funct5(conn, stmt);
					break;
				case 6:
					funct6(conn, stmt);
					break;
				case 7:
					funct7(conn, stmt);
					break;
				case 8:
					funct8(conn, stmt);
					break;
				case 9:
					funct9(conn, stmt);
					break;
				case 10:
					funct10(conn, stmt);
					break;
				case 11:
					funct11(conn, stmt);
					break;
				case 12:
					System.exit(0);
					break;
			}

		}
	}
	
	public static void funct1(Connection conn, Statement stmt) {
		System.out.print("Email: ");
		String email = sc.next();
		System.out.print("Password: ");
		String password = sc.next();
		
		String query = "SELECT AID" +
		" FROM ACCOUNT" + 
		" WHERE EMAIL='" + email + "'" + 
		" AND PW='" + password + "'";
		
		try {
			String AID = "";
			rs = stmt.executeQuery(query);
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			for (int i =1;i<=cnt;i++){
				System.out.println(rsmd.getColumnName(i));
			}
			if (rs.next()){
				AID = rs.getString(1);
			}
			System.out.println(!AID.isEmpty() ? AID : "Login Failed");
			
		} catch (SQLException e) {
			System.err.println("sql error = " + e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	public static void funct2(Connection conn, Statement stmt) {
		System.out.print("First Name: ");
		String Fname = sc.next();
		System.out.print("Last Name: ");
		String Lname = sc.next();
		System.out.print("Phone Number (without hyphens): ");
		String phoneNumber = sc.next();
		
		String query = "SELECT EMAIL" +
		" FROM ACCOUNT" + 
		" WHERE FNAME='" + Fname + "'" + 
		" AND LNAME='" + Lname + "'" +
		" AND PHONE='" + phoneNumber + "'";
		
		try {
			String Email = "";
			rs = stmt.executeQuery(query);
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			for (int i =1;i<=cnt;i++){
				System.out.println(rsmd.getColumnName(i));
			}
			if (rs.next()){
				Email = rs.getString(1);
			}
			System.out.println(!Email.isEmpty() ? Email : "Couldn't find the account");
			
		} catch (SQLException e) {
			System.err.println("sql error = " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public static void funct3(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func3\n\n");
	}
	
	public static void funct4(Connection conn, Statement stmt) {
		System.out.print("Departure: ");
		String departure = sc.next();
		System.out.print("Arrival: ");
		String arrival = sc.next();
		System.out.print("Date (YY/MM/DD): ");
		String date = sc.next();
		
		String query = "SELECT" +
	    " B.BID AS BUS_ID," +
	    " B.BCOMPANY AS BUS_COMPANY," +
	    " B.BTYPE AS BUS_TYPE" +
	    " FROM ROUTE RO, TIMETABLE T, BUS B" +
	    " WHERE RO.DSTATION = '" + departure + "'" +
	    " AND RO.ASTATION = '" + arrival + "'" +
	    " AND T.TRID = RO.RID" +
	    " AND T.TDATE = TO_DATE('" + date + "', 'yy/mm/dd')" +
	    " AND B.BID = T.TBID";
		
		try {
			StringBuffer Buses = new StringBuffer();
			rs = stmt.executeQuery(query);
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			for (int i =1;i<=cnt;i++){
				System.out.print(rsmd.getColumnName(i) + "    ");
			}
			System.out.print("\n");
			if (rs.next()){
				String BusId = rs.getString(1);
				String Company = rs.getString(2);
				String Type = rs.getString(3);
				Buses.append(BusId + "    " + Company + "    " + Type);
			}
			System.out.println(!Buses.isEmpty() ? Buses.toString() : "Couldn't find any bus");
		} catch (SQLException e) {
			System.err.println("sql error = " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public static void funct5(Connection conn, Statement stmt) {
		System.out.println("1. Find a default fee of a route with departure and arrival");
		System.out.println("2. Find a detailed fee of a route with departure and arrival");
		System.out.println("3. Find a detailed fee of a route with timetable ID");
		
		String mode = sc.next();
		
		String query = "";
		String departure = "", arrival = "", Tid = "";
		
		switch (mode) {
		case "2":
			System.out.print("Departure: ");
			departure = sc.next();
			System.out.print("Arrival: ");
			arrival = sc.next();
			
			query = "select BUS_ID, BUS_TYPE, AGE, FEE "
					+ "from "
					+ "(SELECT "
					+ "    B.BID AS BUS_ID, "
					+ "    B.BCOMPANY AS BUS_COMPANY, "
					+ "    B.BTYPE AS BUS_TYPE "
					+ "FROM ROUTE RO, TIMETABLE T, BUS B "
					+ "WHERE RO.DSTATION = '" + departure + "' AND RO.ASTATION = '" + arrival + "' "
					+ "AND T.TRID = RO.RID "
					+ "AND B.BID = T.TBID) "
					+ "left join  "
					+ "(SELECT distinct P.AGE AS AGE, "
					+ "    P.BUSTYPE as BUS_TYPE2, "
					+ "    P.FEE as FEE "
					+ "FROM PRICE P, ROUTE RO "
					+ "WHERE RO.DSTATION = '" + departure + "' AND RO.ASTATION = '" + arrival + "' "
					+ "AND RO.RID = P.PRID "
					+ "ORDER BY AGE DESC, BUSTYPE DESC) "
					+ "ON (BUS_TYPE = BUS_TYPE2) "
					+ "ORDER BY BUS_ID ASC, AGE DESC";
			break;
			
		case "3":
			System.out.print("TID: ");
			Tid = sc.next();
			query = "SELECT P.AGE, P.BUSTYPE, P.FEE "
					+ "FROM TIMETABLE T, PRICE P, BUS B "
					+ "WHERE T.TID = " + Tid + " "
					+ "AND T.TBID = B.BID "
					+ "AND T.TRID = P.PRID "
					+ "AND B.BTYPE = P.BUSTYPE "
					+ "ORDER BY AGE DESC";
			break;
			
		default: // including 1
			System.out.print("Departure: ");
			departure = sc.next();
			System.out.print("Arrival: ");
			arrival = sc.next();
			
			query = "SELECT distinct P.AGE AS AGE, "
					+ "    P.BUSTYPE as BUS_TYPE, "
					+ "    P.FEE as FEE "
					+ "FROM PRICE P, ROUTE RO "
					+ "WHERE RO.DSTATION = '" + departure +"' AND RO.ASTATION = '" + arrival + "' "
					+ "AND RO.RID = P.PRID "
					+ "ORDER BY AGE DESC, BUSTYPE DESC";
		}
		
		try {
			StringBuffer Prices = new StringBuffer();
			rs = stmt.executeQuery(query);
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			for (int i =1;i<=cnt;i++){
				System.out.print(rsmd.getColumnName(i) + "    ");
			}
			System.out.print("\n");
			
			if (mode.equals("2")) {
				while (rs.next()){
					String BusId = rs.getString(1);
					String BusType = rs.getString(2);
					String Age = rs.getString(3);
					int Fee = rs.getInt(4);
					Prices.append(BusId + "    " + BusType + "    " + Age + "    " + Fee + "\n");
				}
			} else {
				while (rs.next()){
					String Age = rs.getString(1);
					String BusType = rs.getString(2);
					Integer Fee = rs.getInt(3);
					Prices.append(Age + "    " + BusType + "    " + Fee.toString() + "\n");
				}
			}
			System.out.println(!Prices.isEmpty() ? Prices.toString() : "Couldn't find any prices");
			
		} catch (SQLException e) {
			System.err.println("sql error = " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public static void funct6(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func6\n\n");
	}
	
	public static void funct7(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func7\n\n");
	}
	
	public static void funct8(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func8\n\n");
	}
	
	public static void funct9(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func9\n\n");
	}
	
	public static void funct10(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func10\n\n");
	}
	
	public static void funct11(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func11\n\n");
	}
}
