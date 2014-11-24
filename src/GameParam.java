

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GameParam
 */
public class GameParam extends HttpServlet {
	private static final long serialVersionUID = 1L;

	Connection conn = null;

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
		double rate = Double.parseDouble(request.getParameter("rate"));
		
		try {
			Statement stmt = conn.createStatement();
			stmt.executeUpdate("update fd_rates set interest_rate = " + String.valueOf(rate) + " where duration='6 mons'");
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		Utils.gameParams(conn, request.getSession());
		response.sendRedirect("Profile.jsp?res3=success");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		double rate = Double.parseDouble(request.getParameter("rate"));
		
		try {
			Statement stmt = conn.createStatement();
			stmt.executeUpdate("update fd_rates set interest_rate = " + String.valueOf(rate) + " where duration='1 year'");
		} catch(SQLException e) {
			e.printStackTrace();
		}

		Utils.gameParams(conn, request.getSession());
		response.sendRedirect("Profile.jsp?res3=success");
	}

}
