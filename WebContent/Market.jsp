<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Virtual Stock Market</title>
<link rel="stylesheet" href="bootstrap.css">
</head>
<body style="margin-left: 5%; margin-right: 5%">
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="navbar-header">
		<p class="navbar-text">
			<b>Virtual Stock Market</b>
		</p>
	</div>

	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<%
			if (session.getAttribute("username") != null)
				out.println("<p class=\"navbar-text\"><strong>Hello "
						+ session.getAttribute("username") + "</strong></p>");
		%>
		<ul class="nav navbar-nav">
			<li><a href="Profile.jsp">Profile</a>
			</li>
			<li><a href="Portfolio.jsp">Portfolio</a>
			</li>
			<li><a href="Transact.jsp">Transact</a>
			</li>
			<li><a href="TransactionHistory.jsp">Transaction History</a>
			</li>
			<li><a href="OrderBook.jsp">Order Book</a>
			</li>
			<li class="active"><a href="#">Market Statistics<span
					class="sr-only">(current)</span> </a>
			</li>
		</ul>

		<ul class="nav navbar-nav navbar-right" style="margin-right: 1%">
			<form method="get" action="Logger">
				<input type="hidden" name="action" value="logout" />
				<button type="submit" class="btn btn-default navbar-btn">Logout</button>
			</form>
		</ul>
	</div>
	</nav>
	<br>
	<br>
	<br>
	<br>
	<!--Rest of the content down here-->

	<legend>Market Statistics</legend>

	<form class="form-inline" role="form" action="MarketStats"
		method="post">
		<select class="form-control" name="company">
			<%
				out.print(session.getAttribute("companies"));
			%>
		</select>
		<button type="submit" class="btn btn-default">Check
			Statistics</button>
	</form>

	<hr>

	<%
		if (session.getAttribute("company_stat_name") == null)
			out.print("<!--");
		else{
			out.print("<legend><h2>"+session.getAttribute("company_stat_name")+"</h2></legend><br>");
		}
	%>

	<table class="table table-condensed table-hover">
		<tr>
			<th>Date</th>
			<th>Price</th>
			<th>Percentage Growth</th>
		</tr>
		<%
			if (session.getAttribute("company_stat_name") != null) {
				String res = (String) session.getAttribute("stock_prices");
				String[] toparr = res.split(";");
				String[] date = new String[5];
				String[] style = "default,success,info,warning,danger"
						.split(",");
				Double[] price = new Double[5];
				double maxi = 0;
				Double mini = null;
				for (int j = 0; j < 5; j++) {
					String[] resArr = toparr[j].split(",");
					date[j] = resArr[0];
					price[j] = Double.parseDouble(resArr[1]);
					maxi = Math.max(maxi, price[j]);
					if (mini==null) mini=price[j];
					else mini=Math.min(mini,price[j]);
				}
				double range=maxi-mini;
				for (int i = 0; i < 5; i++) {
					String html="<tr><td>"+date[i]+"</td><td>"+price[i]+"</td><td><div class=\"progress\"><div class=\"progress-bar progress-bar-"+style[i]+" progress-bar-striped\" role=\"progressbar\" aria-valuenow=\""+(10+80*(price[i]-mini)/range)+"\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: "+(10+80*(price[i]-mini)/range)+"%\"></div></td></tr>";
					System.out.println(html);
					out.print(html);
				}
			}
			session.setAttribute("stock_prices", null);
		%>
	</table>
	<%
		if (session.getAttribute("company_stat_name") == null)
			out.print("-->");
		else session.setAttribute("company_stat_name", null);
	%>

	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>