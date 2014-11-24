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
			<li><a href="Profile.jsp">Profile</a></li>
			<li style="height: 50px; padding: 15px;"><form style="height:20px" method="get" action="ChangeDetails"><button style="padding:0px" class="btn btn-link" type=submit>Portfolio</button></form></li>
			<li class="active"><a href="#">Transact <span class="sr-only">(current)</span> </a></li>
			<li><a href="TransactionHistory.jsp">Transaction History</a></li>
			<li style="height: 50px; padding: 15px;">
				<form style="height: 20px" method="post" action="PastTransactions">
					<button style="padding: 0px" class="btn btn-link" type=submit>Order	Book</button>
				</form>
			</li>
			<li><a href="Market.jsp">Market Statistics</a></li>
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

	<legend>Transact</legend>
	<%
		if (request.getParameter("res") == null)
			;
		else if (request.getParameter("res").equals("funds"))
			out.println("<div class=\"alert alert-warning\" role=\"alert\">You don't have sufficent funds!.</div>");
		else if (request.getParameter("res").equals("stocks"))
			out.println("<div class=\"alert alert-warning\" role=\"alert\">You don't posses the required amount of shares!</div>");
	%>
	<br>
	<b>Stock investments</b>
	<form class="form-inline" role="form" action="NewTransaction"
		method="post">
		<br>Choose the company where you wish to invest<br> <select
			class="form-control" name="stock_company">
			<%
				if (session.getAttribute("username") != null)
					out.print(session.getAttribute("companiesstock"));
			%>
		</select> <select class="form-control" name="stock_type">
			<option>buy</option>
			<option>sell</option>
		</select> <br>Choose the quantity you wish to invest<br> <input
			type="text" name="stock_quantity">
		<button type="submit" class="btn btn-default">Submit</button>
		<input type="hidden" name="classify" value="stock">
	</form>

	<br>
	<b>Mutual Funds</b>
	<form class="form-inline" role="form" action="NewTransaction"
		method="post">
		<br>Choose the company where you wish to invest<br> <select
			class="form-control" name="mf_company">
			<%
				if (session.getAttribute("username") != null)
					out.print(session.getAttribute("companiesmf"));
			%>
		</select> <select class="form-control" name="mf_type">
			<option>buy</option>
			<option>sell</option>
		</select> <br>Choose the quantity you wish to invest<br> <input
			type="text" name="mf_quantity">
		<button type="submit" class="btn btn-default">Submit</button>
		<input type="hidden" name="classify" value="mf">
	</form>

	<br>
	<b>Bonds</b>
	<form class="form-inline" role="form" action="NewTransaction"
		method="post">
		<br>Choose the company where you wish to invest<br> <select
			class="form-control" name="bonds_type">
			<option>buy</option>
			<option>sell</option>
		</select> <select class="form-control" name="bonds_company">
		</select> <br>Choose the quantity you wish to invest<br> <input
			type="text" name="bonds_quantity">
		<button type="submit" class="btn btn-default">Submit</button>
		<input type="hidden" name="classify" value="bonds">
	</form>


	<br>
	<b>Fixed deposit</b>
	<form class="form-inline" role="form" action="NewTransaction"
		method="post">
		<select class="form-control" name="fd_type">
			<option>Buy FD</option>
			<option>Break FD</option>
		</select> <br>Enter your FD ID if you wish to break it<br> <input
			type="text" name="break_fd"> <br>Choose the investment
		period<br> <select class="form-control" name="fd_period">
		</select> <br>Choose the amount you wish to invest<br> <input
			type="text" name="fd_amount">
		<button type="submit" class="btn btn-default">Submit</button>
		<input type="hidden" name="classify" value="fd">
	</form>

	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>