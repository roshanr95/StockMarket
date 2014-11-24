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
		<% if(session.getAttribute("username") != null) out.println("<p class=\"navbar-text\"><strong>Hello "+session.getAttribute("username")+"</strong></p>");%>
		<ul class="nav navbar-nav">
			<li><a href="Profile.jsp">Profile</a></li>
			<li style="height: 50px; padding: 15px;"><form style="height:20px" method="get" action="ChangeDetails"><button style="padding:0px" class="btn btn-link" type=submit>Portfolio</button></form></li>
			<li><a href="Transact.jsp">Transact</a></li>
			<li><a href="TransactionHistory.jsp">Transaction History</a></li>
			<li class="active"><a href="#">Order Book <span class="sr-only">(current)</span> </a></li>
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

	<legend>Order Book</legend>

	<div class="panel-group" id="accordion" role="tablist"
		aria-multiselectable="true">
		<%
			if (session.getAttribute("stock2") == null) {
				out.println("<!--");
			}
		%>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headStocks">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#Stocks"
						aria-expanded="true" aria-controls="Stocks"> Stocks <span
						class="badge badge-inverse" style="float:right"> <%
								if (session.getAttribute("stock2") != null) {
									String res = (String) session.getAttribute("stock2");
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
					<table class="table" style="margin-top: 1%">
						<tr>
							<th>ID</th>
							<th>Ticker</th>
							<th>Kind</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Time Stamp</th>
						</tr>
						<%
							if (session.getAttribute("stock2") != null) {
								String res = (String) session.getAttribute("stock2");
								String[] toparr = res.split(";");
								for (int j = 0; j < toparr.length; j++) {
									String[] resArr = toparr[j].split(",");
									out.println("<tr>");
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
			if (session.getAttribute("stock2") == null) {
				out.println("-->");
			}
		%>
		<%
			if (session.getAttribute("bond2") == null) {
				out.println("<!--");
			}
		%>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headBonds">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#Bonds"
						aria-expanded="false" aria-controls="Bonds"> Bonds <span
						class="badge badge-inverse" style="float:right"> <%
								if (session.getAttribute("bond2") != null) {
									String res = (String) session.getAttribute("bond2");
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
					<table class="table" style="margin-top: 1%">
						<tr>
							<th>ID</th>
							<th>Ticker</th>
							<th>Kind</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Time Stamp</th>
						</tr>
						<%
							if (session.getAttribute("bond2") != null) {
								String res = (String) session.getAttribute("bond2");
								String[] toparr = res.split(";");
								for (int j = 0; j < toparr.length; j++) {
									String[] resArr = toparr[j].split(",");
									out.println("<tr>");
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
			if (session.getAttribute("bond2") == null) {
				out.println("-->");
			}
		%>
		<%
			if (session.getAttribute("mf2") == null) {
				out.println("<!--");
			}
		%>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headMFunds">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#MFunds"
						aria-expanded="false" aria-controls="MFunds"> Mutual Funds <span
						class="badge badge-inverse" style="float:right"> <%
								if (session.getAttribute("mf2") != null) {
									String res = (String) session.getAttribute("mf2");
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
					<table class="table" style="margin-top: 1%">
						<tr>
							<th>ID</th>
							<th>Ticker</th>
							<th>Kind</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Time Stamp</th>
						</tr>
						<%
							if (session.getAttribute("mf2") != null) {
								String res = (String) session.getAttribute("mf2");
								String[] toparr = res.split(";");
								for (int j = 0; j < toparr.length; j++) {
									String[] resArr = toparr[j].split(",");
									out.println("<tr>");
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
			if (session.getAttribute("mf2") == null) {
				out.println("-->");
			}
		%>
		<%
			if (session.getAttribute("fd2") == null) {
				out.println("<!--");
			}
		%>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headFD">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#FD"
						aria-expanded="false" aria-controls="FD"> Fixed Deposits <span
						class="badge badge-inverse" style="float:right"> <%
								if (session.getAttribute("fd2") != null) {
									String res = (String) session.getAttribute("fd2");
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
					<table class="table" style="margin-top: 1%">
						<tr>
							<th>ID</th>
							<th>Amount</th>
							<th>Day of Issue</th>
							<th>Interest Rate</th>
							<th>Duration</th>
						</tr>
						<%
							if (session.getAttribute("fd2") != null) {
								String res = (String) session.getAttribute("fd2");
								String[] toparr = res.split(";");
								for (int j = 0; j < toparr.length; j++) {
									String[] resArr = toparr[j].split(",");
									out.println("<tr>");
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
			if (session.getAttribute("fd2") == null) {
				out.println("-->");
			}
		%>
	</div>

	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>