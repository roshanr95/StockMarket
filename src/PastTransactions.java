import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.postgresql.util.PGInterval;

//This will handle all requests from OrderBook and TransactionHistory

public class PastTransactions extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Connection conn =null;

	public void init() throws ServletException {
		//Open the connection here

		String db = "jdbc:postgresql://localhost/stockmarket";
		String user = "karan";
		String pass = "balr()ck94";

		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection(db, user, pass);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("username");
		
		String startDate = request.getParameter("startdate");
		String endDate = request.getParameter("enddate");
		
		Date start, end;
		
		try {
			start = Date.valueOf(startDate);
			end = Date.valueOf(endDate);
		} catch (IllegalArgumentException e) {
			response.sendRedirect("TransactionHistory.jsp?res=format");
			return;
		}
		
		if(start.compareTo(end) >= 0) {
			response.sendRedirect("TransactionHistory.jsp?res=range");
			return;
		}
		
		Timestamp startt = new Timestamp(start.getTime());
		Timestamp endt = new Timestamp(end.getTime());
		
		try {
			PreparedStatement stmt = conn.prepareStatement("select * from transact_history where userid = ? and invest_type='S' and time between ? and ?;");
			stmt.setString(1, user);
			stmt.setTimestamp(2, startt);
			stmt.setTimestamp(3, endt);
			ResultSet rs = stmt.executeQuery();
			String res="";
			
			while(rs.next()) {
				String r = String.valueOf(rs.getInt(1)) + "," + rs.getString(3) + "," + 
							rs.getString(5) + "," + String.valueOf(rs.getFloat(6)) + "," + String.valueOf(rs.getInt(7)) + "," +
							rs.getTimestamp(8) + "," + rs.getString(9);
				res = res + r + ";";
			}
//			System.out.println(res);
			if(!res.equals(""))
			session.setAttribute("stock", res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			PreparedStatement stmt = conn.prepareStatement("select * from transact_history where userid = ? and invest_type='MF' and time between ? and ?;");
			stmt.setString(1, user);
			stmt.setTimestamp(2, startt);
			stmt.setTimestamp(3, endt);
			ResultSet rs = stmt.executeQuery();
			String res="";
			
			while(rs.next()) {
				String r = String.valueOf(rs.getInt(1)) + "," + rs.getString(3) + "," + 
							rs.getString(5) + "," + String.valueOf(rs.getFloat(6)) + "," + String.valueOf(rs.getInt(7)) + "," +
							rs.getTimestamp(8) + "," + rs.getString(9);
				res = res + r + ";";
			}
//			System.out.println(res);
			if(!res.equals(""))
			session.setAttribute("mf", res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			PreparedStatement stmt = conn.prepareStatement("select * from transact_history where userid = ? and invest_type='B' and time between ? and ?;");
			stmt.setString(1, user);
			stmt.setTimestamp(2, startt);
			stmt.setTimestamp(3, endt);
			ResultSet rs = stmt.executeQuery();
			String res="";
			
			while(rs.next()) {
				String r = String.valueOf(rs.getInt(1)) + "," + rs.getString(3) + "," + 
							rs.getString(5) + "," + String.valueOf(rs.getFloat(6)) + "," + String.valueOf(rs.getInt(7)) + "," +
							rs.getTimestamp(8) + "," + rs.getString(9);
				res = res + r + ";";
			}
//			System.out.println(res);
			if(!res.equals(""))
			session.setAttribute("bond", res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			PreparedStatement stmt = conn.prepareStatement("select * from fd_history where userid = ? and day_of_issue between ? and ?;");
			stmt.setString(1, user);
			stmt.setTimestamp(2, startt);
			stmt.setTimestamp(3, endt);
			ResultSet rs = stmt.executeQuery();
			String res="";
			
			while(rs.next()) {
				String r = String.valueOf(rs.getInt(1)) + "," + String.valueOf(rs.getFloat(3)) + "," + rs.getDate(4) + "," +
							String.valueOf(rs.getFloat(5)) + "," + ((PGInterval) rs.getObject(6)).getValue() + "," + rs.getString(7);
				res = res + r + ";";
			}
//			System.out.println(res);
			if(!res.equals(""))
			session.setAttribute("fd", res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		response.sendRedirect("TransactionHistory.jsp?res=success");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("username");
		
		try {
			PreparedStatement stmt = conn.prepareStatement("select * from curr_transact where userid = ? and invest_type='S';");
			stmt.setString(1, user);
			ResultSet rs = stmt.executeQuery();
			String res="";
			
			while(rs.next()) {
				String r = String.valueOf(rs.getInt(1)) + "," + rs.getString(3) + "," + 
							rs.getString(5) + "," + String.valueOf(rs.getFloat(6)) + "," + String.valueOf(rs.getInt(7)) + "," +
							rs.getTimestamp(8);
				res = res + r + ";";
			}
//			System.out.println(res);
			if(!res.equals(""))
			session.setAttribute("stock2", res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			PreparedStatement stmt = conn.prepareStatement("select * from curr_transact where userid = ? and invest_type='MF';");
			stmt.setString(1, user);
			ResultSet rs = stmt.executeQuery();
			String res="";
			
			while(rs.next()) {
				String r = String.valueOf(rs.getInt(1)) + "," + rs.getString(3) + "," + 
							rs.getString(5) + "," + String.valueOf(rs.getFloat(6)) + "," + String.valueOf(rs.getInt(7)) + "," +
							rs.getTimestamp(8);
				res = res + r + ";";
			}
//			System.out.println(res);
			if(!res.equals(""))
			session.setAttribute("mf2", res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			PreparedStatement stmt = conn.prepareStatement("select * from curr_transact where userid = ? and invest_type='B';");
			stmt.setString(1, user);
			ResultSet rs = stmt.executeQuery();
			String res="";
			
			while(rs.next()) {
				String r = String.valueOf(rs.getInt(1)) + "," + rs.getString(3) + "," + 
							rs.getString(5) + "," + String.valueOf(rs.getFloat(6)) + "," + String.valueOf(rs.getInt(7)) + "," +
							rs.getTimestamp(8);
				res = res + r + ";";
			}
//			System.out.println(res);
			if(!res.equals(""))
			session.setAttribute("bond2", res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			PreparedStatement stmt = conn.prepareStatement("select * from fd_table where userid = ?;");
			stmt.setString(1, user);
			ResultSet rs = stmt.executeQuery();
			String res="";
			
			while(rs.next()) {
				String r = String.valueOf(rs.getInt(1)) + "," + String.valueOf(rs.getFloat(3)) + "," + rs.getDate(4) + "," +
							String.valueOf(rs.getFloat(5)) + "," + ((PGInterval) rs.getObject(6)).getValue();
				res = res + r + ";";
			}
//			System.out.println(res);
			if(!res.equals(""))
			session.setAttribute("fd2", res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		response.sendRedirect("OrderBook.jsp?res=success");
	}

}
