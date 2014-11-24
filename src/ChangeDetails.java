import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//This will handle requests coming from Profile page to change personal details

public class ChangeDetails extends HttpServlet {
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
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("username");
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("with balance(amt) as (select balance from users where userid=? union select price*quantity from curr_transact where trans_type='B' and userid=? union select amount from fd_table where userid=? union select quantity*curr_stock_price from company natural join ownership where userid=?) select sum(amt) from balance;");
			stmt.setString(1, user);
			stmt.setString(2, user);
			stmt.setString(3, user);
			stmt.setString(4, user);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) session.setAttribute("networth", rs.getString(1));
			stmt = conn.prepareStatement("select balance from users where userid=?");
			stmt.setString(1,user);
			rs = stmt.executeQuery();
			if (rs.next()) session.setAttribute("balance", rs.getString(1));
			stmt = conn.prepareStatement("select name,ticker_symbol,invest_type,quantity,curr_stock_price from ownership natural join company where userid=?");
			stmt.setString(1, user);
			rs = stmt.executeQuery();
			String result="";
			while(rs.next()){
				String status=rs.getString(3);
				if (status.equals("S")) status="success";
				else if (status.equals("B")) status="info";
				else status="warning";
				result+="<tr class=\""+status+"\"><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getInt(4)+"</td><td>"+rs.getString(5)+"</td></tr>";
			}
			session.setAttribute("ownage",result);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("Portfolio.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("username");

		String oldpw = request.getParameter("oldpw");
		String newpw = request.getParameter("newpw");
		String confpw = request.getParameter("confpw");
		
		if(oldpw!=null) {
			String s = "success";
			try {
				PreparedStatement stmt = conn.prepareStatement("select password from users where userid = ?;");
				stmt.setString(1, user);
				ResultSet rs = stmt.executeQuery();
				rs.next();
				String pw = rs.getString(1);
				if(oldpw.equals(pw))
					if(newpw.equals(confpw)) {
						stmt = conn.prepareStatement("update users set password = ? where userid = ?;");
						stmt.setString(1, newpw);
						stmt.setString(2, user);
						stmt.execute();
					} else
						s="nomatch";
				else
					s="invpw";
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			response.sendRedirect("Profile.jsp?res2="+s);
			return;
		}
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		System.out.println(name + " " + email + " " + user);
		
		try {
			PreparedStatement stmt = conn.prepareStatement("update users set name = ?, email_addr = ? where userid = ?;");
			stmt.setString(1, name);
			stmt.setString(2, email);
			stmt.setString(3, user);
			stmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("Profile.jsp?res1=success");
	}

}
