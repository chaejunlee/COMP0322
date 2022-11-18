package Bus;

import java.sql.Connection;
import java.sql.Statement;
import java.util.Scanner;

public class Menu {
	public static void menu(Connection conn, Statement stmt) {
		
		System.out.println("----------------------- KNU BUS SERVICE -----------------------");
		
		while(true) {
			Scanner sc = new Scanner(System.in);	
			
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
		// input your code
		System.out.println("func1\n\n");
	}
	
	public static void funct2(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func2\n\n");
	}
	
	public static void funct3(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func3\n\n");
	}
	
	public static void funct4(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func4\n\n");
	}
	
	public static void funct5(Connection conn, Statement stmt) {
		// input your code
		System.out.println("func5\n\n");
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
