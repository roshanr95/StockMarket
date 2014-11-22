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
	<br>
	<br>
	<br>
	<legend>
		<h1>
			Virtual Stock Market <small>Your Guide to the Wall Street</small>
		</h1>
	</legend>


	<%
		if (request.getParameter("res") == null) ;
		else if (request.getParameter("res").equals("warning")) out.println("<div class=\"alert alert-warning\" role=\"alert\">Username has been taken.</div>");
		else if (request.getParameter("res").equals("success")) out.println("<div class=\"alert alert-success\" role=\"alert\"><strong>User created!</strong></div>");
		else if (request.getParameter("res").equals("error")) out.println("<div class=\"alert alert-danger\" role=\"alert\">User does not exist!</div>");
		else if (request.getParameter("res").equals("error2")) out.println("<div class=\"alert alert-danger\" role=\"alert\">User/Password does not match!</div>");
	%>

	<div>
		<div style="display: inline-block; width: 45%">
			<h2>Login</h2>
			<form class="form-horizontal" role="form" action="Logger"
				method="get">
				<input type="hidden" name="action" value="login" />
				<div class="form-group">
					<label class="col-sm-2 control-label">Username</label>
					<div class="col-sm-6">
						<input name="username" type="text" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Password</label>
					<div class="col-sm-6">
						<input name="password" type="password" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</div>
			</form>
		</div>

		<div style="display: inline-block; width: 45%">
			<h2>Register</h2>
			<form class="form-horizontal" role="form" action="Logger"
				method="post">
				<div class="form-group">
					<label class="col-sm-2 control-label">Name</label>
					<div class="col-sm-6">
						<input name="name" type="text" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Email</label>
					<div class="col-sm-6">
						<input name="email" type="email" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Username</label>
					<div class="col-sm-6">
						<input name="username" type="text" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Password</label>
					<div class="col-sm-6">
						<input name="password" type="password" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-primary">Register</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<script src="jquery.js"></script>
	<script src="bootstrap.js"></script>
</body>
</html>