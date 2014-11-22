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
		<ul class="nav navbar-nav">
			<li><a href="Profile.jsp">Profile</a>
			</li>
			<li><a href="Portfolio.jsp">Portfolio</a>
			</li>
			<li class="active"><a href="#">Transact <span
					class="sr-only">(current)</span> </a>
			</li>
			<li><a href="TransactionHistory.jsp">Transaction History</a>
			</li>
			<li><a href="OrderBook.jsp">Order Book</a>
			</li>
			<li><a href="Market.jsp">Market Statistics</a>
			</li>
		</ul>

		<ul class="nav navbar-nav navbar-right" style="margin-right: 1%">
			<button type="button" class="btn btn-default navbar-btn">Logout</button>
		</ul>
	</div>
	</nav>
	<br>
	<br>
	<br>
	<br>
	<!--Rest of the content down here-->

	<legend>Transact</legend>

	<br><b>Stock investments</b>
	<form class="form-inline" role="form">
	<br>Choose the company where you wish to invest<br>
		<select class="form-control" name="stock_company">
			<!--<option>xyz</option> here-->
		</select> 
		<br>Choose the quantity you wish to invest<br>
		 <input type="text"
			name="stock_quantity">
		<button type="submit" class="btn btn-default">Submit</button>
	</form>
	
		<br><b>Mutual Funds</b>
	<form class="form-inline" role="form">
	<br>Choose the company where you wish to invest<br>
		<select class="form-control" name="mf_company">
			<!--<option>xyz</option> here-->
		</select> 
		<br>Choose the quantity you wish to invest<br>
		 <input type="text"
			name="mf_quantity">
		<button type="submit" class="btn btn-default">Submit</button>
	</form>
	
		<br><b>Bonds</b>
	<form class="form-inline" role="form">
	<br>Choose the company where you wish to invest<br>
		<select class="form-control" name="bonds_company">
			<!--<option>xyz</option> here-->
		</select> 
		<br>Choose the quantity you wish to invest<br>
		 <input type="text"
			name="bonds_quantity">
		<button type="submit" class="btn btn-default">Submit</button>
	</form>
	
	
	<br><b>Fixed deposit</b>
	<form class="form-inline" role="form">
	<br>Choose the investment period<br>
		<select class="form-control" name="fd_period">
			<!--<option>xyz</option> here-->
		</select> 
		<br>Choose the amount you wish to invest<br>
		 <input type="text"
			name="fd_amount">
		<button type="submit" class="btn btn-default">Submit</button>
	</form>

	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>