import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//This java file will serve get requests for both logging in, logging out and registering

public class Logger extends HttpServlet {
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
		
		String action = request.getParameter("action");
		HttpSession session = request.getSession(false);
		
		if(action.equals("login")){
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			PreparedStatement p;
			try {
				p = conn.prepareStatement("select password from users where userid = ?");
				p.setString(1,username);
				ResultSet rs = p.executeQuery();
				if(rs.next()) {
					if(rs.getString(1).equals(password)) {
						
						String str="";
						p=conn.prepareStatement("select ticker_symbol,name from company");
						ResultSet rs2 = p.executeQuery();
						while(rs2.next()) str+="<option value='"+rs2.getString(1)+"'>"+rs2.getString(2)+"</option>";
						session.setAttribute("companies",str);
						
						session.setAttribute("username", username);
						response.sendRedirect("Profile.jsp");
					}
					else response.sendRedirect("Home.jsp?res=error2");
				}
				else response.sendRedirect("Home.jsp?res=error");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		else if(action.equals("logout")){
			session.setAttribute("username",null);
			session.setAttribute("stock",null);
			session.setAttribute("mf",null);
			session.setAttribute("bond",null);
			session.setAttribute("fd",null);
			session.setAttribute("stock_prices",null);
			session.setAttribute("company_stat_name",null);
			session.setAttribute("companies", null);
			response.sendRedirect("Home.jsp");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name=request.getParameter("name");
		String username=request.getParameter("username");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		
		try {
			PreparedStatement p = conn.prepareStatement("select * from users where userid = ?");
			p.setString(1,username);
			ResultSet rs = p.executeQuery();
			String result;
			
			if(!rs.next()){
				PreparedStatement p2 = conn.prepareStatement("insert into users values(?,?,10000,?,?)");
				p2.setString(1,username);
				p2.setString(2,name);
				p2.setString(3,email);
				p2.setString(4, password);
				p2.executeUpdate();
				result="success";
			}
			else result="warning";
			response.sendRedirect("Home.jsp?res="+result);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
