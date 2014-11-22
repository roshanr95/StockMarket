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
			<li><a href="Portfolio.jsp">Portfolio</a></li>
			<li><a href="Transact.jsp">Transact</a></li>
			<li><a href="TransactionHistory.jsp">Transaction History</a></li>
			<li><a href="OrderBook.jsp">Order Book</a></li>
			<li class="active"><a href="#">Market Statistics<span
					class="sr-only">(current)</span> </a></li>
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

	<form class="form-inline" role="form">
		<select class="form-control" name="company">
			<!--<option>xyz</option> here-->
		</select>
		<button type="submit" class="btn btn-default">Check
			Statistics</button>
	</form>

	<hr>

	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>