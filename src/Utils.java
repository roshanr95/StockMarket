import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.postgresql.util.PGInterval;


public class Utils {
	static public void setOrderBook(Connection conn, HttpSession session) {
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
			else session.removeAttribute("stock2");
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
			else session.removeAttribute("mf2");
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
			else session.removeAttribute("bond2");
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
			else session.removeAttribute("fd2");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
