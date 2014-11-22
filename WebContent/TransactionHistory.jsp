<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Virtual Stock Market</title>
  <link rel="stylesheet" href="bootstrap.css">
</head>
<body style="margin-left:5%;margin-right:5%">
  <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="navbar-header">
    <p class="navbar-text"><b>Virtual Stock Market</b></p>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="Profile.jsp">Profile</a></li>
        <li><a href="Portfolio.jsp">Portfolio</a></li>
        <li><a href="Transact.jsp">Transact</a></li>
        <li class="active"><a href="#">Transaction History <span class="sr-only">(current)</span></a></li>
        <li><a href="OrderBook.jsp">Order Book</a></li>
        <li><a href="Market.jsp">Market Statistics</a></li>
      </ul>

      <ul class="nav navbar-nav navbar-right">
        <button style="margin-right:30%" type="button" class="btn btn-default navbar-btn">Logout</button>
      </ul>
    </div>
  </nav>
  <br><br><br><br>
  <!--Rest of the content down here-->

  <legend>Transaction History</legend>

  <form class="form-inline" role="form" style="text-align:center">
    <div class="form-group">
      <div class="input-group">
        <div class="input-group-addon">Start Date</div>
        <input type="date" class="form-control" placeholder="dd/mm/yyyy">
      </div>
    </div>
    
    <div class="form-group">
      <div class="input-group">
        <div class="input-group-addon">End Date</div>
        <input type="date" class="form-control" placeholder="dd/mm/yyyy">
      </div>
    </div>

    <button type="submit" class="btn btn-default">Check History</button>
  </form>
   
   <hr>
   <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headStocks">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#Stocks" aria-expanded="true" aria-controls="Stocks">
            Stocks
          </a>
        </h4>
      </div>
      <div id="Stocks" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headStocks">
        <div class="panel-body">
          <!--history here -->
        </div>
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headBonds">
        <h4 class="panel-title">
          <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#Bonds" aria-expanded="false" aria-controls="Bonds">
            Bonds
          </a>
        </h4>
      </div>
      <div id="Bonds" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headBonds">
        <div class="panel-body">
          <!--history here -->
        </div>
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headMFunds">
        <h4 class="panel-title">
          <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#MFunds" aria-expanded="false" aria-controls="MFunds">
            Mutual Funds
          </a>
        </h4>
      </div>
      <div id="MFunds" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headMFunds">
        <div class="panel-body">
          <!--history here -->
        </div>
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headFD">
        <h4 class="panel-title">
          <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#FDs" aria-expanded="false" aria-controls="FDs">
            Fixed Deposits
          </a>
        </h4>
      </div>
      <div id="FDs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headFD">
        <div class="panel-body">
          <!--history here -->
        </div>
      </div>
    </div>
  </div>

  <script src="jquery.js"></script>
  <script src="bootstrap.js"></script>
  </body>
</html>