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
		else if (request.getParameter("res").equals("invalid_id"))
			out.println("<div class=\"alert alert-warning\" role=\"alert\">You have entered an invalid FD ID.</div>");
		else if (request.getParameter("res").equals("stock_buy"))
			out.println("<div class=\"alert alert-success\" role=\"alert\">The stock has been purchased. Check Transaction History for details</div>");
		else if (request.getParameter("res").equals("stock_sell"))
			out.println("<div class=\"alert alert-success\" role=\"alert\">The stock has been sold. Check Transaction History for details</div>");
		else if (request.getParameter("res").equals("fd_buy"))
			out.println("<div class=\"alert alert-success\" role=\"alert\">Your FD has been created. Check OrderBook for details</div>");
		else if (request.getParameter("res").equals("fd_broken"))
			out.println("<div class=\"alert alert-success\" role=\"alert\">Your FD has been broken. Check OrderBook for details</div>");
		else if (request.getParameter("res").equals("trans_buy"))
			out.println("<div class=\"alert alert-success\" role=\"alert\">Your buy order has been processed. Check OrderBook for details</div>");
		else if (request.getParameter("res").equals("trans_sell"))
			out.println("<div class=\"alert alert-success\" role=\"alert\">Your sell order has been processed. Check OrderBook for details</div>");
		else if (request.getParameter("res").equals("inpinv"))
			out.println("<div class=\"alert alert-warning\" role=\"alert\">Insufficient Input!</div>");
	%>

	<div role="tabpanel">
		<!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#Stocks" aria-controls="Stocks" role="tab" data-toggle="tab">Stocks</a></li>
			<li role="presentation"><a href="#MF" aria-controls="MF" role="tab" data-toggle="tab">Mutual Funds</a></li>
			<li role="presentation"><a href="#Bonds" aria-controls="Bonds" role="tab" data-toggle="tab">Bonds</a></li>
			<li role="presentation"><a href="#FD" aria-controls="FD" role="tab" data-toggle="tab">Fixed Deposits</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane fade in active" id="Stocks">
				<br> 
				<form class="form-horizontal" role="form" action="NewTransaction" method="post">
					<input type="hidden" name="classify" value="stock">
					<div class="form-group">
						<label for="stock_company" class="col-sm-2 control-label">Choose the Stock</label>
						<div class="col-sm-10">
							<select class="form-control" name="stock_company" id="stock_company">
								<%
									if (session.getAttribute("username") != null)
										out.print(session.getAttribute("companiesstock"));
								%>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="stock_type" class="col-sm-2 control-label">Action</label>
						<div class="col-sm-10">
							<select class="form-control" name="stock_type" id="stock_type">
								<option value="buy">Quick Buy (at Market Price)</option>
								<option value="sell">Quick Sell (at Market Price)</option>
								<option value="buy_offer">Buy Order</option>
								<option value="sell_offer">Sell Order</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="stock_quantity" class="col-sm-2 control-label">Quantity</label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="stock_quantity" id="stock_quantity">
						</div>
					</div>
					<div class="form-group">
						<label for="stock_price" class="col-sm-2 control-label">Price</label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="stock_price" id="stock_price">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-default">Submit Order</button>
						</div>
					</div>
				</form> 
			</div>

			<div role="tabpanel" class="tab-pane fade" id="MF">
				<br> 
				<form class="form-horizontal" role="form" action="NewTransaction" method="post">
					<input type="hidden" name="classify" value="mf">
					<div class="form-group">
						<label for="mf_company" class="col-sm-2 control-label">Choose the Mutual Fund</label>
						<div class="col-sm-10">
							<select class="form-control" name="mf_company" id="mf_company">
								<%
									if (session.getAttribute("username") != null)
										out.print(session.getAttribute("companiesmf"));
								%>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="mf_type" class="col-sm-2 control-label">Action</label>
						<div class="col-sm-10">
							<select class="form-control" name="mf_type" id="mf_type">
								<option value="buy">Quick Buy (at Market Price)</option>
								<option value="sell">Quick Sell (at Market Price)</option>
								<option value="buy_offer">Buy Order</option>
								<option value="sell_offer">Sell Order</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="mf_quantity" class="col-sm-2 control-label">Quantity</label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="mf_quantity" id="mf_quantity">
						</div>
					</div>
					<div class="form-group">
						<label for="mf_price" class="col-sm-2 control-label">Price</label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="mf_price" id="mf_price">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-default">Submit Order</button>
						</div>
					</div>
				</form> 
			</div>


			<div role="tabpanel" class="tab-pane fade" id="Bonds">
				<br> 
				<form class="form-horizontal" role="form" action="NewTransaction" method="post">
					<input type="hidden" name="classify" value="bonds">
					<div class="form-group">
						<label for="bonds_company" class="col-sm-2 control-label">Choose the Bond</label>
						<div class="col-sm-10">
							<select class="form-control" name="bonds_company" id="bonds_company">
								<%
									if (session.getAttribute("username") != null)
										out.print(session.getAttribute("companiesstock"));
								%>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="bonds_type" class="col-sm-2 control-label">Action</label>
						<div class="col-sm-10">
							<select class="form-control" name="bonds_type" id="bonds_type">
								<option value="buy">Quick Buy (at Market Price)</option>
								<option value="sell">Quick Sell (at Market Price)</option>
								<option value="buy_offer">Buy Order</option>
								<option value="sell_offer">Sell Order</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="bonds_quantity" class="col-sm-2 control-label">Quantity</label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="bonds_quantity" id="bonds_quantity">
						</div>
					</div>
					<div class="form-group">
						<label for="bonds_price" class="col-sm-2 control-label">Price</label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="bonds_price" id="bonds_price">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-default">Submit Order</button>
						</div>
					</div>
				</form> 
			</div>

			<div role="tabpanel" class="tab-pane fade" id="FD">
				<br> 
				<form class="form-horizontal" role="form" action="NewTransaction" method="post">
					<input type="hidden" name="classify" value="fd">
					<div class="form-group">
						<label for="fd_period" class="col-sm-2 control-label">Investment Period</label>
						<div class="col-sm-10">
							<select class="form-control" name="fd_period" id="fd_period">
								<!-- Take values from FD table-->
								<option>1 year</option>
								<option value="6 mons">6 months</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="fd_amount" class="col-sm-2 control-label">FD amount</label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="fd_amount" id="fd_amount">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-default">Create FD</button>
						</div>
					</div>
				</form> 
			</div>

		</div>
	</div>
	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>