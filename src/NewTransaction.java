import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.postgresql.util.PGInterval;

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
		HttpSession session = request.getSession(false);
		String stock_company=request.getParameter("stock_company");
		String mf_company=request.getParameter("mf_company");
		String bonds_company=request.getParameter("bonds_company");
		String fd_period=request.getParameter("fd_period");
		String stock_quantity=request.getParameter("stock_quantity");
		String mf_quantity=request.getParameter("mf_quantity");
		String bonds_quantity=request.getParameter("bonds_quantity");
		String fd_amount=request.getParameter("fd_amount");
		String fd_type=request.getParameter("fd_type");
		String stock_type=request.getParameter("stock_type");
		String mf_type=request.getParameter("mf_type");
		String bonds_type=request.getParameter("bonds_type");
		String fd_string=(request.getParameter("break_fd"));
		String classify=request.getParameter("classify");
		String username=(String) session.getAttribute("username");
		String stock_price=request.getParameter("stock_price");
		String mf_price=request.getParameter("mf_price");
		String bonds_price=request.getParameter("bonds_price");
		try{
			//get variables price, balance and total cost,trans_no and fd_no
			double balance=0.0;
			PreparedStatement p = conn.prepareStatement("select balance from users where userid = ?");
			p.setString(1,username);

			ResultSet rs = p.executeQuery();
			while(rs.next())balance=rs.getInt(1);
			int fd_no=0;
			int trans_no=0;
			p = conn.prepareStatement("select value from game_params where game_param = 'trans_no'");
			rs = p.executeQuery();
			while(rs.next())trans_no=rs.getInt(1);
			p = conn.prepareStatement("select value from game_params where game_param = 'fd_no'");
			rs = p.executeQuery();
			while(rs.next())fd_no=rs.getInt(1);
			if(!classify.equals("fd"))
			{
				String val="S";
				if(classify.equals("bonds")){
					stock_company=bonds_company;
					stock_quantity=bonds_quantity;
					stock_type=bonds_type;
					stock_price=bonds_price;
					val="B";
				}
				else if(classify.equals("mf")){
					stock_company=mf_company;
					stock_quantity=mf_quantity;
					stock_type=mf_type;
					stock_price=mf_price;
					val="MF";
				}
				double price=0.0;
				p = conn.prepareStatement("select curr_stock_price from company where ticker_symbol = ?");
				p.setString(1,stock_company);
				rs = p.executeQuery();
				while(rs.next())price=rs.getDouble(1);
				int quantity=0;
				double user_price=0.0;
				if(stock_quantity.equals(""))
				{
					response.sendRedirect("Transact.jsp");
					return;
				}
				if(stock_price.equals("") && (stock_type.endsWith("offer")))
				{
					response.sendRedirect("Transact.jsp");
					return;
				}
				if(stock_type.endsWith("offer"))
				{
					user_price=Double.parseDouble(stock_price);
				}
				quantity=Integer.parseInt(stock_quantity);
				//			System.out.println("stock was clicked"); debugging
				double total_cost=price*quantity;
				double user_cost=user_price*quantity;
				if(stock_type.equals("buy") || stock_type.equals("buy_offer"))
				{
					if( balance >= user_cost && stock_type.equals("buy_offer") &&  user_price < price )
					{
						//remove balance
						p = conn.prepareStatement("update users set balance = balance - ? where userid = ?");
						p.setDouble(1, user_cost);
						p.setString(2, username);
						p.executeUpdate();

						//add transaction
						p = conn.prepareStatement("insert into curr_transact values(?,?,?,?,'B',?,?,?)");
						p.setInt(1, trans_no);
						p.setString(2,username);
						p.setString(3, stock_company);
						p.setString(4, val);
						p.setDouble(5,user_cost);
						p.setInt(6,quantity);
						java.util.Date date= new java.util.Date();
						Timestamp temp= new Timestamp(date.getTime());
						p.setTimestamp(7, temp);
						p.executeUpdate();
						response.sendRedirect("Transact.jsp?res=trans_buy");
						
					}
					else if(balance >= total_cost){
						//Update user balance
						p = conn.prepareStatement("update users set balance = balance - ? where userid = ?");
						p.setDouble(1, total_cost);
						p.setString(2, username);
						p.executeUpdate();

						//Update user stocks
						p = conn.prepareStatement("SELECT userid FROM ownership WHERE userid = ? AND ticker_symbol=? AND invest_type=?");
						p.setString(1, username);
						p.setString(2, stock_company);
						p.setString(3, val);
						rs=p.executeQuery();

						//Update Transaction History
						p = conn.prepareStatement("INSERT INTO transact_history values(?,?,?,?,'B',?,?,?,'Y')");
						p.setInt(1, trans_no);
						p.setString(2, username);
						p.setString(3, stock_company);
						p.setString(4,val);
						p.setDouble(5,price);
						p.setInt(6,quantity);
						java.util.Date date= new java.util.Date();
						Timestamp temp= new Timestamp(date.getTime());
						p.setTimestamp(7, temp);
						p.executeUpdate();



						if(!rs.next())
						{

							p = conn.prepareStatement("INSERT INTO ownership values(?,?,?,?)");
							p.setString(1, username);
							p.setString(2, stock_company);
							p.setInt(4, quantity);
							p.setString(3,val );
							p.executeUpdate();

						}
						else{

							p = conn.prepareStatement("UPDATE ownership SET quantity = quantity + ? WHERE userid = ? AND ticker_symbol = ? AND invest_type= ? ");
							p.setInt(1,quantity);
							p.setString(2, username);
							p.setString(3, stock_company );
							p.setString(4,val);
							p.executeUpdate();

						}
						response.sendRedirect("Transact.jsp?res=stock_buy");
					}
					else{
						//Insufficient Funds
						response.sendRedirect("Transact.jsp?res=funds");
					}
				}
				else// selling stocks
				{
					p = conn.prepareStatement("SELECT quantity FROM ownership WHERE userid = ? AND ticker_symbol = ? AND invest_type=?");
					p.setString(1,username);
					p.setString(2, stock_company);
					p.setString(3, val);
					rs=p.executeQuery();
					boolean check=rs.next();
					int owned_quantity=0;
					if(check)owned_quantity = rs.getInt(1);//denotes the owned shares
					check = check && (owned_quantity >= quantity);
					if(check)
					{
						if(stock_type.equals("sell_offer") && user_price > price)
						{
							//remove items
							if(owned_quantity == quantity)
							{
								p = conn.prepareStatement("DELETE FROM ownership WHERE userid = ? AND ticker_symbol = ? AND invest_type=?");
								p.setString(1,username);
								p.setString(2, stock_company);
								p.setString(3, val);
								p.executeUpdate();
							}
							else{
								p = conn.prepareStatement("UPDATE ownership SET quantity = quantity - ? WHERE userid = ? AND ticker_symbol = ? AND invest_type= ?");
								p.setInt(1,quantity);
								p.setString(2, username);
								p.setString(3, stock_company );
								p.setString(4, val);
								p.executeUpdate();
							}
							
							//add transaction
							p = conn.prepareStatement("insert into curr_transact values(?,?,?,?,'S',?,?,?)");
							p.setInt(1, trans_no);
							p.setString(2,username);
							p.setString(3, stock_company);
							p.setString(4, val);
							p.setDouble(6,user_cost);
							p.setInt(7,quantity);
							java.util.Date date= new java.util.Date();
							Timestamp temp= new Timestamp(date.getTime());
							p.setTimestamp(8, temp);
							p.executeUpdate();
							
							response.sendRedirect("Transact.jsp?res=trans_sell");
						}
						else
						{
							//Update user balance
							p = conn.prepareStatement("update users set balance = balance + ? where userid = ?");
							p.setDouble(1, total_cost);
							p.setString(2, username);
							p.executeUpdate();
							//Update transaction History
							p = conn.prepareStatement("INSERT INTO transact_history values(?,?,?,?,'S',?,?,?,'Y')");
							p.setInt(1, trans_no);
							p.setString(2, username);
							p.setString(3, stock_company);
							p.setString(4,val);
							p.setDouble(5,price);
							p.setInt(6,quantity);
							java.util.Date date= new java.util.Date();
							Timestamp temp= new Timestamp(date.getTime());
							p.setTimestamp(7, temp);
							p.executeUpdate();

							if(owned_quantity == quantity)
							{
								p = conn.prepareStatement("DELETE FROM ownership WHERE userid = ? AND ticker_symbol = ? AND invest_type=?");
								p.setString(1,username);
								p.setString(2, stock_company);
								p.setString(3, val);
								p.executeUpdate();
							}
							else{
								p = conn.prepareStatement("UPDATE ownership SET quantity = quantity - ? WHERE userid = ? AND ticker_symbol = ? AND invest_type= ?");
								p.setInt(1,quantity);
								p.setString(2, username);
								p.setString(3, stock_company );
								p.setString(4, val);
								p.executeUpdate();
							}
							response.sendRedirect("Transact.jsp?res=stock_sell");
						}
					}
					else{
						//Insufficient items to sell
						response.sendRedirect("Transact.jsp?res=stocks");
					}
				}
				p = conn.prepareStatement("update game_params set value = ? where game_param = 'trans_no'");
				trans_no++;

				p.setString(1, String.valueOf(trans_no));
				p.executeUpdate();
			}
			else if(classify.equals("fd"))
			{

				if(fd_type.equals("Buy_FD"))
				{
					double interest=0.0;
					p = conn.prepareStatement("select interest_rate from fd_rates where duration = ?");
					PGInterval d= new PGInterval(fd_period);
					p.setObject(1,d);

					rs = p.executeQuery();
					while(rs.next())interest=rs.getDouble(1);

					double amount=0.0;
					if(fd_amount.equals(""))
					{
						response.sendRedirect("Transact.jsp");
						return;
					}
					amount=Double.parseDouble(fd_amount);
					if(amount > balance)
					{
						response.sendRedirect("Transact.jsp?res=funds");
					}
					else
					{
						//remove money
						p = conn.prepareStatement("update users set balance = balance - ? where userid = ?");
						p.setDouble(1, amount);
						p.setString(2, username);
						p.executeUpdate();


						//Insert into fd
						p = conn.prepareStatement("INSERT INTO fd_table values(?,?,?,?,?,?)");
						p.setInt(1, fd_no);
						p.setString(2, username);
						p.setDouble(3,amount);
						p.setDouble(5,interest);
						Date utilDate = new Date();
						java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

						p.setDate(4,sqlDate);
						p.setObject(6, d);
						p.executeUpdate();
						response.sendRedirect("Transact.jsp?res=fd_buy");
						p = conn.prepareStatement("update game_params set value = ? where game_param = 'fd_no'");
						fd_no++;

						p.setString(1, String.valueOf(fd_no));
						p.executeUpdate();
					}
				}
				else
				{
					int fd_id=0;
					if(fd_string.equals(""))
					{
						response.sendRedirect("Transact.jsp");
						return;
					}
					fd_id=Integer.parseInt(fd_string);
					p = conn.prepareStatement("SELECT * from fd_table where fd_id= ? and userid = ?");
					p.setInt(1,fd_id);
					p.setString(2, username);
					rs=p.executeQuery();
					if(rs.next())
					{
						Double amount=rs.getDouble(3);
						Double ini_amount=amount;
						Double rate=rs.getDouble(5);
						java.sql.Date d = rs.getDate(4);
						PGInterval dur=(PGInterval) rs.getObject(6);
						p = conn.prepareStatement("SELECT * from fd_table where fd_id= ? AND day_of_issue + fd_duration > ?");
						p.setInt(1, fd_id);
						Date utilDate = new Date();
						java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

						p.setDate(2,sqlDate);
						rs=p.executeQuery();
						String suc="N";
						if(rs.next())
						{
							int months = dur.getMonths()*12 + dur.getYears(); 
							amount=amount+amount*months*rate/1200;
							suc="Y";
						}
						//remove from fd_table
						p = conn.prepareStatement("delete from fd_table where fd_id= ?");
						p.setInt(1,fd_id);
						p.executeUpdate();
						//Add to fd_history
						p = conn.prepareStatement("insert into fd_history values(?,?,?,?,?,?,?)");
						p.setInt(1,fd_id);
						p.setString(2,username);
						p.setDouble(3,ini_amount);
						p.setDate(4,d);
						p.setDouble(5, rate);
						p.setObject(6,dur);
						p.setString(7, suc);
						p.executeUpdate();
						//give money to users
						p = conn.prepareStatement("update users set balance = balance + ? where userid = ?");
						p.setDouble(1, amount);
						p.setString(2, username);
						p.executeUpdate();
						response.sendRedirect("Transact.jsp?res=fd_broken");
					}
					else
					{
						//Incorrect fd_id
						response.sendRedirect("Transact.jsp?res=invalid_id");
					}
				}
			}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
