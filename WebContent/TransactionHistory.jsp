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
			<li class="active"><a href="#">Transaction History <span
					class="sr-only">(current)</span>
			</a></li>
			<li><a href="OrderBook.jsp">Order Book</a></li>
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

	<legend>Transaction History</legend>

	<form action="PastTransactions" method="get" class="form-inline"
		role="form" style="text-align: center">
		<div class="form-group">
			<div class="input-group">
				<div class="input-group-addon">Start Date</div>
				<input type="date" name="startdate" class="form-control"
					placeholder="yyyy-[m]m-[d]d">
			</div>
		</div>

		<div class="form-group">
			<div class="input-group">
				<div class="input-group-addon">End Date</div>
				<input type="date" name="enddate" class="form-control"
					placeholder="yyyy-[m]m-[d]d">
			</div>
		</div>

		<button type="submit" class="btn btn-default">Check History</button>
	</form>
	<%
		if (request.getParameter("res") == null)
			;
		else if (request.getParameter("res").equals("format"))
			out.println("<br/><div class=\"alert alert-danger\" role=\"alert\">Incorrect Date Format</div>");
		else if (request.getParameter("res").equals("range"))
			out.println("<br/><div class=\"alert alert-danger\" role=\"alert\">Invalid Range</div>");
	%>
	<hr>

	<div class="panel-group" id="accordion" role="tablist"
		aria-multiselectable="true">
		<%
			if (session.getAttribute("stock") == null) {
				out.println("<!--");
			}
		%>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headStocks">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#Stocks"
						aria-expanded="true" aria-controls="Stocks"> Stocks <span
						class="badge badge-inverse" style="margin-left: 1%"> <%
								if (session.getAttribute("stock") != null) {
									String res = (String) session.getAttribute("stock");
									String[] toparr = res.split(";");
									out.println(toparr.length);
								}
							%>
					</span>
					</a>
				</h4>
			</div>
			<div id="Stocks" class="panel-collapse collapse in" role="tabpanel"
				aria-labelledby="headStocks">
				<div class="panel-body">
					<button type="button" class="btn btn-danger">Failed
						Transaction</button>
					<button type="button" class="btn btn-success">Successful
						Sell</button>
					<button type="button" class="btn btn-info">Successful Buy</button>
					<table class="table" style="margin-top: 1%">
						<tr>
							<th>ID</th>
							<th>Ticker</th>
							<th>Kind</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Time Stamp</th>
							<th>Successful</th>
						</tr>
						<%
							if (session.getAttribute("stock") != null) {
								String res = (String) session.getAttribute("stock");
								String[] toparr = res.split(";");
								for (int j = 0; j < toparr.length; j++) {
									String[] resArr = toparr[j].split(",");
									out.println("<tr " + (resArr[6].equals("N") ? "class=\"danger\"" : (resArr[2].equals("B") ? "class=\"info\"" : "class=\"success\"")) + ">");
									for (int i = 0; i < resArr.length; i++) {
										out.println("<td>" + resArr[i] + "</td>");
									}
									out.println("</tr>");
								}
							}
						%>
					</table>
				</div>
			</div>
		</div>
		<%
			if (session.getAttribute("stock") == null) {
				out.println("-->");
			} else {
				session.removeAttribute("stock");
			}
		%>
		<%
			if (session.getAttribute("bond") == null) {
				out.println("<!--");
			}
		%>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headBonds">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#Bonds"
						aria-expanded="false" aria-controls="Bonds"> Bonds <span
						class="badge badge-inverse" style="margin-left: 1%"> <%
								if (session.getAttribute("bond") != null) {
									String res = (String) session.getAttribute("bond");
									String[] toparr = res.split(";");
									out.println(toparr.length);
								}
							%>
					</span>
					</a>
				</h4>
			</div>
			<div id="Bonds" class="panel-collapse collapse" role="tabpanel"
				aria-labelledby="headBonds">
				<div class="panel-body">
					<button type="button" class="btn btn-danger">Failed
						Transaction</button>
					<button type="button" class="btn btn-success">Successful
						Sell</button>
					<button type="button" class="btn btn-info">Successful Buy</button>
					<table class="table" style="margin-top: 1%">
						<tr>
							<th>ID</th>
							<th>Ticker</th>
							<th>Kind</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Time Stamp</th>
							<th>Successful</th>
						</tr>
						<%
							if (session.getAttribute("bond") != null) {
								String res = (String) session.getAttribute("bond");
								String[] toparr = res.split(";");
								for (int j = 0; j < toparr.length; j++) {
									String[] resArr = toparr[j].split(",");
									out.println("<tr " + (resArr[6].equals("N") ? "class=\"danger\"" : (resArr[2].equals("B") ? "class=\"info\"" : "class=\"success\"")) + ">");
									for (int i = 0; i < resArr.length; i++) {
										out.println("<td>" + resArr[i] + "</td>");
									}
									out.println("</tr>");
								}
							}
						%>
					</table>
				</div>
			</div>
		</div>
		<%
			if (session.getAttribute("bond") == null) {
				out.println("-->");
			} else {
				session.removeAttribute("bond");
			}
		%>
		<%
			if (session.getAttribute("mf") == null) {
				out.println("<!--");
			}
		%>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headMFunds">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#MFunds"
						aria-expanded="false" aria-controls="MFunds"> Mutual Funds <span
						class="badge badge-inverse" style="align: right"> <%
								if (session.getAttribute("mf") != null) {
									String res = (String) session.getAttribute("mf");
									String[] toparr = res.split(";");
									out.println(toparr.length);
								}
							%>
					</span>
					</a>
				</h4>
			</div>
			<div id="MFunds" class="panel-collapse collapse" role="tabpanel"
				aria-labelledby="headMFunds">
				<div class="panel-body">
					<button type="button" class="btn btn-danger">Failed
						Transaction</button>
					<button type="button" class="btn btn-success">Successful
						Sell</button>
					<button type="button" class="btn btn-info">Successful Buy</button>
					<table class="table" style="margin-top: 1%">
						<tr>
							<th>ID</th>
							<th>Ticker</th>
							<th>Kind</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Time Stamp</th>
							<th>Successful</th>
						</tr>
						<%
							if (session.getAttribute("mf") != null) {
								String res = (String) session.getAttribute("mf");
								String[] toparr = res.split(";");
								for (int j = 0; j < toparr.length; j++) {
									String[] resArr = toparr[j].split(",");
									out.println("<tr " + (resArr[6].equals("N") ? "class=\"danger\"" : (resArr[2].equals("B") ? "class=\"info\"" : "class=\"success\"")) + ">");
									for (int i = 0; i < resArr.length; i++) {
										out.println("<td>" + resArr[i] + "</td>");
									}
									out.println("</tr>");
								}
							}
						%>
					</table>
				</div>
			</div>
		</div>
		<%
			if (session.getAttribute("mf") == null) {
				out.println("-->");
			} else {
				session.removeAttribute("mf");
			}
		%>
		<%
			if (session.getAttribute("fd") == null) {
				out.println("<!--");
			}
		%>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headFD">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#FD"
						aria-expanded="false" aria-controls="FD"> Fixed Deposits <span
						class="badge badge-inverse" style="align: right"> <%
								if (session.getAttribute("fd") != null) {
									String res = (String) session.getAttribute("fd");
									String[] toparr = res.split(";");
									out.println(toparr.length);
								}
							%>
					</span>
					</a>
				</h4>
			</div>
			<div id="FD" class="panel-collapse collapse" role="tabpanel"
				aria-labelledby="headFD">
				<div class="panel-body">
					<button type="button" class="btn btn-danger">Broken Fixed
						Deposit</button>
					<table class="table" style="margin-top: 1%">
						<tr>
							<th>ID</th>
							<th>Amount</th>
							<th>Day of Issue</th>
							<th>Interest Rate</th>
							<th>Duration</th>
							<th>Broken</th>
						</tr>
						<%
							if (session.getAttribute("fd") != null) {
								String res = (String) session.getAttribute("fd");
								String[] toparr = res.split(";");
								for (int j = 0; j < toparr.length; j++) {
									String[] resArr = toparr[j].split(",");
									out.println("<tr " + (resArr[5].equals("N") ? "class=\"danger\"" : "") + ">");
									for (int i = 0; i < resArr.length; i++) {
										out.println("<td>" + resArr[i] + "</td>");
									}
									out.println("</tr>");
								}
							}
						%>
					</table>
				</div>
			</div>
		</div>
		<%
			if (session.getAttribute("fd") == null) {
				out.println("-->");
			} else {
				session.removeAttribute("fd");
			}
		%>
	</div>

	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>