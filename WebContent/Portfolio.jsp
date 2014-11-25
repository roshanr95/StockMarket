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
			<li class="active"><a href="#">Portfolio <span
					class="sr-only">(current)</span> </a></li>
			<li><a href="Transact.jsp">Transact</a></li>
			<li><a href="TransactionHistory.jsp">Transaction History</a></li>
			<li style="height: 50px; padding: 15px;"><form
					style="height: 20px" method="post" action="PastTransactions">
					<button style="padding: 0px" class="btn btn-link" type=submit>Order
						Book</button>
				</form></li>
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

	<legend>Portfolio</legend>
	<div style="display:inline-block;width:100%">
	<div style="float:left;margin-left:10%"><h4>Balance : <small><% if(session.getAttribute("username")!=null) out.print(session.getAttribute("balance")); %></small></h4></div>
	<div style="float:right;margin-right:10%"><h4>Networth : <small><% if(session.getAttribute("username")!=null) out.print(session.getAttribute("networth")); %></small></h4></div>
	</div>
	<br><br>
	<div style="display:inline-block;width:100%">
		<div style="float:left"><h3>Currently Held Assets</h3></div>
		<div class="btn-group" role="group" style="float:right">
			<button type="button" class="btn btn-success" disabled="disabled">Stocks</button>
			<button type="button" class="btn btn-warning" disabled="disabled">Mutual Funds</button>
			<button type="button" class="btn btn-info" disabled="disabled">Bonds</button>
		</div>
	</div>
	<br>
	<table class="table table-hover table-condensed" style="margin-top: 1%">
		<tr>
			<th>Company</th>
			<th>Ticker Symbol</th>
			<th>Quantity</th>
			<th>Current Market Price</th>
		</tr>
		<%
			if (session.getAttribute("username") != null) out.print(session.getAttribute("ownage"));
		%>
	</table>

	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>