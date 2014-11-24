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
			<li class="active"><a href="#">Profile <span class="sr-only">(current)</span></a></li>
			<li style="height: 50px; padding: 15px;"><form style="height:20px" method="get" action="ChangeDetails"><button style="padding:0px" class="btn btn-link" type=submit>Portfolio</button></form></li>
			<li><a href="Transact.jsp">Transact</a></li>
			<li><a href="TransactionHistory.jsp">Transaction History</a></li>
			<li style="height: 50px; padding: 15px;"><form style="height:20px" method="post" action="PastTransactions"><button style="padding:0px" class="btn btn-link" type=submit>Order Book</button></form></li>
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

	<legend>Profile</legend>
	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
	<h1>
		<small>Welcome <%=session.getAttribute("username")%></small>
	</h1>
	<br />

	<div style="display: inline-block; width: 49%">
		<h3 style="margin-left: 20%">Edit Personal Details</h3>
		<br />
		<form action="ChangeDetails" method="post" class="form-horizontal"
			role="form">
			<div class="form-group">
				<label class="col-sm-2 control-label">Name</label>
				<div class="col-sm-6">
					<input type="text" name="name" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Email</label>
				<div class="col-sm-6">
					<input type="email" name="email" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
			</div>
		</form>
	</div>



	<div style="display: inline-block; width: 49%">
		<h3 style="margin-left: 20%">Change Password</h3>
		<br />
		<form action="ChangeDetails" method="post" class="form-horizontal"
			role="form">
			<div
				class="form-group <%if (request.getParameter("res2") == null)
				;
			else if (request.getParameter("res2").equals("invpw"))
				out.println("has-error");%> ">
				<label class="col-sm-2 control-label">Old Password</label>
				<div class="col-sm-6">
					<input type="password" name="oldpw" class="form-control">
				</div>
			</div>
			<div
				class="form-group <%if (request.getParameter("res2") == null)
				;
			else if (request.getParameter("res2").equals("nomatch"))
				out.println("has-warning");%> ">
				<label class="col-sm-2 control-label">New Password</label>
				<div class="col-sm-6">
					<input type="password" name="newpw" class="form-control">
				</div>
			</div>
			<div
				class="form-group <%if (request.getParameter("res2") == null)
				;
			else if (request.getParameter("res2").equals("nomatch"))
				out.println("has-warning");%> ">
				<label class="col-sm-2 control-label">Confirm Password</label>
				<div class="col-sm-6">
					<input type="password" name="confpw" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
			</div>
		</form>
	</div>
	<%
		if (request.getParameter("res1") == null)
			out.println("<div style=\"display: inline-block; width: 45%\" class=\"alert\" role=\"alert\"></div>");
		else if (request.getParameter("res1").equals("success"))
			out.println("<div style=\"display: inline-block; width: 45%\" class=\"alert alert-success\" role=\"alert\"><strong>Done!</strong></div>");
	%>
	<%
		if (request.getParameter("res2") == null)
			out.println("<div style=\"display: inline-block; width: 45%\" class=\"alert\" role=\"alert\"></div>");
		else if (request.getParameter("res2").equals("invpw"))
			out.println("<div style=\"display: inline-block; width: 45%\" class=\"alert alert-danger\" role=\"alert\">Invalid Password</div>");
		else if (request.getParameter("res2").equals("success"))
			out.println("<div style=\"display: inline-block; width: 45%\" class=\"alert alert-success\" role=\"alert\"><strong>Done!</strong></div>");
		else if (request.getParameter("res2").equals("nomatch"))
			out.println("<div style=\"display: inline-block; width: 45%\" class=\"alert alert-warning\" role=\"alert\">Passwords do not match</div>");
	%>


	<div
		<%-- <%if (session.getAttribute("username") != null
					&& session.getAttribute("username").equals("admin")) {
				out.println("");
			} else {
				out.println("class=\"hide\"");
			}%> --%>
		style="display: inline-block; width: 45%">
		<%if (session.getAttribute("username") != null
					&& session.getAttribute("username").equals("admin")) {
				out.println("<h3 style=\"margin-left: 10%\">Change Game Parameters</h3>");
			} else {
				out.println("<h3 style=\"margin-left: 10%\">Game Parameters</h3>");
			}%>
		
		<br />
		<form method="post" action="GameParam" class="form-horizontal" role="form">
			<div class="form-group">
				<label class="col-sm-2 control-label">FD Rates</label>
				<div class="col-4">
					<label class="col-sm-2 control-label">1 year</label>
					<div class="col-sm-2">
						<input name="rate" type="number" class="form-control" value=<%out.println(session.getAttribute("fdrate1"));
						if (session.getAttribute("username") != null
							&& session.getAttribute("username").equals("admin")) {
						out.println("");
					} else out.println("disabled");%>>
					</div>
					<%if (session.getAttribute("username") != null
							&& session.getAttribute("username").equals("admin")) {
						out.println("<button type=\"submit\" class=\"btn btn-primary\">Change</button>");
					}%>
				</div>
			</div>
		</form>
		<form method="get" action="GameParam" class="form-horizontal" role="form">
			<div class="form-group">
				<label class="col-sm-2 control-label"></label>
				<div class="col-4">
					<label class="col-sm-2 control-label">6 mons</label>
					<div class="col-sm-2">
						<input name="rate" type="number" class="form-control" value=<%out.println(session.getAttribute("fdrate2"));
						if (session.getAttribute("username") != null
							&& session.getAttribute("username").equals("admin")) {
						out.println("");
					} else out.println("disabled");%>>
					</div>
					<%if (session.getAttribute("username") != null
							&& session.getAttribute("username").equals("admin")) {
						out.println("<button type=\"submit\" class=\"btn btn-primary\">Change</button>");
					}%>
				</div>
			</div>
		</form>
		<%
		if (request.getParameter("res3") == null)
			out.println("<div style=\"display: inline-block; width: 45%\" class=\"alert\" role=\"alert\"></div>");
		else if (request.getParameter("res3").equals("success"))
			out.println("<div style=\"display: inline-block; width: 75%\" class=\"alert alert-success\" role=\"alert\"><strong>Done!</strong></div>");
	%>
	</div>
	
</body>
</html>
