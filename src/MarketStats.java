import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.xml.internal.ws.util.StringUtils;

//This will handle new transact operations

public class MarketStats extends HttpServlet {
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
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ticker = request.getParameter("company");
		HttpSession session = request.getSession(false);
		
		try {
			PreparedStatement p = conn.prepareStatement("select name from company where ticker_symbol = ?");
			p.setString(1,ticker);
			ResultSet rs = p.executeQuery();
			while(rs.next()) session.setAttribute("company_stat_name",rs.getString(1)+"   <small>"+ticker+"</small>");
			p = conn.prepareStatement("select * from stock_history where ticker_symbol = ?");
			p.setString(1,ticker);
			rs = p.executeQuery();
			String str = "";
			while(rs.next()) str+=rs.getString(2)+","+rs.getString(3)+";";
			session.setAttribute("stock_prices", str);
			response.sendRedirect("Market.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
