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

//Handles all Transact operations

public class NewTransaction extends HttpServlet {
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
		// TODO Auto-generated method stub
		String stock_company=request.getParameter("stock_company");
		String mf_company=request.getParameter("mf_company");
		String bonds_company=request.getParameter("bonds_company");
		String fd_period=request.getParameter("fd_period");
		String stock_quantity=request.getParameter("stock_quantity");
		String mf_quantity=request.getParameter("mf_quantity");
		String bonds_quantity=request.getParameter("bonds_quantity");
		String fd_amount=request.getParameter("fd_aomunt");
		String fd_type=request.getParameter("fd_type");
		String stock_type=request.getParameter("stock_type");
		String mf_type=request.getParameter("mf_type");
		String bonds_type=request.getParameter("bonds_type");
		String fd_id=request.getParameter("break_fd");
		String classify=request.getParameter("classify");
		String username="";
		try{
			double balance=0.0;
			PreparedStatement p = conn.prepareStatement("select balance from users where userid = ?");
			p.setString(1,username);
			ResultSet rs = p.executeQuery();
			balance=rs.getInt(1);
			rs.close();
		if(classify.equals("stock"))
		{
//			System.out.println("stock was clicked"); debugging
			if(stock_type.equals("buy"))
			{
				double price=0.0;
				p = conn.prepareStatement("select curr_stock_price from company where ticker_symbol = ?");
				p.setString(1,stock_company);
				rs = p.executeQuery();
				price=rs.getDouble(1);
				rs.close();
				double total_cost=price*Integer.parseInt(stock_quantity);
				if(balance >= total_cost){
					System.out.println("you can proceed");
				}
				else{
					System.out.println("Can't proceed further");
				}
			}
			else
			{
				
			}
		}
		else if(classify.equals("mf"))
		{
//			System.out.println("mf was clicked"); debugging
		}
		else if(classify.equals("bonds"))
		{
//			System.out.println("bonds was clicked"); debugging
		}
		else if(classify.equals("fd"))
		{
//			System.out.println("fd was clicked");debugging
		}
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
}
