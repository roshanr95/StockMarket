import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.postgresql.util.PGInterval;

/**
 * Servlet implementation class CancelOrder
 */
public class CancelOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	Connection conn = null;

	public void init() throws ServletException {
		// Open the connection here

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");

		String fd_string = request.getParameter("no");
		int fd_id = Integer.parseInt(fd_string);
		try {
			PreparedStatement p = conn
					.prepareStatement("SELECT * from fd_table where fd_id= ?");
			p.setInt(1, fd_id);
			ResultSet rs = p.executeQuery();
			rs.next();
			Double amount = rs.getDouble(3);
			Double ini_amount = amount;
			Double rate = rs.getDouble(5);
			java.sql.Date d = rs.getDate(4);
			PGInterval dur = (PGInterval) rs.getObject(6);
			p = conn.prepareStatement("SELECT * from fd_table where fd_id= ? AND day_of_issue + fd_duration > ?");
			p.setInt(1, fd_id);
			Date utilDate = new Date();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

			p.setDate(2, sqlDate);
			rs = p.executeQuery();
			String suc = "N";
			if (rs.next()) {
				int months = dur.getYears() * 12 + dur.getMonths();
				amount = amount + amount * months * rate / 1200;
				suc = "Y";
			}
			// remove from fd_table
			p = conn.prepareStatement("delete from fd_table where fd_id= ?");
			p.setInt(1, fd_id);
			p.executeUpdate();
			// Add to fd_history
			p = conn.prepareStatement("insert into fd_history values(?,?,?,?,?,?,?)");
			p.setInt(1, fd_id);
			p.setString(2, username);
			p.setDouble(3, ini_amount);
			p.setDate(4, d);
			p.setDouble(5, rate);
			p.setObject(6, dur);
			p.setString(7, suc);
			p.executeUpdate();
			// give money to users
			p = conn.prepareStatement("update users set balance = balance + ? where userid = ?");
			p.setDouble(1, amount);
			p.setString(2, username);
			p.executeUpdate();
			Utils.setOrderBook(conn, session);
			response.sendRedirect("OrderBook.jsp?res=break");
			
			return;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("OrderBook.jsp?res=error");		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("username");

		String idstr = request.getParameter("no");
		int id = Integer.parseInt(idstr);
		try {
			PreparedStatement p = conn
					.prepareStatement("select * from curr_transact where trans_id=?");
			p.setInt(1, id);
			ResultSet rs = p.executeQuery();
			rs.next();
			
			String type = rs.getString(5);
			double price = rs.getDouble(6);
			int quantity = rs.getInt(7);
			
			p = conn.prepareStatement("insert into transact_history values(?,?,?,?,?,?,?,?,?)");
			p.setInt(1, rs.getInt(1));
			p.setString(2, rs.getString(2));
			p.setString(3, rs.getString(3));
			p.setString(4, rs.getString(4));
			p.setString(5, rs.getString(5));
			p.setDouble(6, rs.getDouble(6));
			p.setInt(7, rs.getInt(7));
			p.setObject(8, rs.getObject(8));
			p.setString(9, "N");
			p.executeUpdate();
			
			p = conn.prepareStatement("delete from curr_transact where trans_id=?");
			p.setInt(1, id);
			p.executeUpdate();
			
			if(type.equals("B")) {
				p = conn.prepareStatement("update users set balance = balance + ? where userid = ?");
				p.setDouble(1, price*quantity);
				p.setString(2, user);
				p.executeUpdate();
			} else {
				p = conn.prepareStatement("update ownership set quantity = quantity + ? where userid = ?; " +
						"insert into ownership (userid, ticker_symbol, invest_type, quantity) " +
						"select ?,?,?,? where not exists(select * from ownership where userid=? and ticker_symbol=? and invest_type=? and quantity=?)");
				p.setInt(1, quantity);
				p.setString(2, user);
				p.setString(3, user);
				p.setString(7, user);
				p.setString(4, rs.getString(3));
				p.setString(8, rs.getString(3));
				p.setString(5, rs.getString(4));
				p.setString(9, rs.getString(4));
				p.setInt(6, quantity);
				p.setInt(10, quantity);
				
				p.executeUpdate();
				
//				p = conn.prepareStatement("update ownership set quantity = quantity + ? where userid = ?");
//				p.setInt(1, quantity);
//				p.setString(2, user);
//				p.executeUpdate();
				
			}
			Utils.setOrderBook(conn, session);
			response.sendRedirect("OrderBook.jsp?res=cancel");
			
			return;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("OrderBook.jsp?res=error");
	}

}
