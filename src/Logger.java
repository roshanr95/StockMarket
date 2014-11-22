import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		// TODO Auto-generated method stub
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
				PreparedStatement p2 = conn.prepareStatement("insert into users values(?,?,10000,10000,?,?)");
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
