DROP INDEX day_fdhist; --ON fd_history;
DROP INDEX userid_currtrans;-- ON curr_transact;
DROP INDEX userid_transhist;--ON transact_history;
DROP INDEX time_transhist;--ON transact_history;
DROP INDEX userid_fd;-- ON fd_table;
DROP INDEX userid_fdhist;-- ON fd_history;

DROP TABLE transact_history;
DROP TABLE stock_history;
DROP TABLE curr_transact;
DROP TABLE game_params;
DROP TABLE fd_rates;
DROP TABLE fd_history;
DROP TABLE fd_table;
DROP TABLE ownership;
DROP TABLE company;
DROP TABLE users;
create table users
	(userid        varchar(20),
	 name		varchar(50) not null,
	 networth	numeric(20,5) check(networth >=0),
	 balance	numeric(20,5) check(balance>=0),	
	 email_addr varchar(50),
	 password	varchar(50),
	 primary key (userid)
	);

create table company
	(ticker_symbol 		varchar(10) not null, 
	 name		   		varchar(50), 
	 curr_stock_price   numeric(20,5) check (curr_stock_price > 0),
	 primary key (ticker_symbol)
	);
create table stock_history
	(ticker_symbol 		varchar(10) not null, 
	 day		   		Date, 
	 stock_price   numeric(20,5) check (stock_price > 0),
	 primary key (ticker_symbol,day),
	 foreign key (ticker_symbol) references company on delete set null
	);
create table ownership
	(userid		varchar(20),
	 ticker_symbol varchar(10) not null, 
	 invest_type  varchar(2) check(ticker_symbol in ('B','S','MF')),
	 quantity  numeric(12,0) check (quantity >= 0),
	 primary key (userid,ticker_symbol,invest_type),
	 foreign key (userid) references users on delete set null,
	 foreign key (ticker_symbol) references company on delete set null
	);


create table fd_table
	(fd_id 	numeric(20,0) not null,
	 userid  varchar(20) not null,
	 amount numeric(20,5) not null, 
	 day_of_issue  Date not null,
	 interest_rate numeric(4,2),
	 fd_duration interval,	
	 primary key (fd_id),
	 foreign key (userid) references users
		on delete set null
	);

create table fd_history
	(fd_id 	numeric(20,0) not null,
	 userid  varchar(20) not null,
	 amount numeric(20,5) not null, 
	 day_of_issue  Date not null,
	 interest_rate numeric(4,2),
	 fd_duration interval,
	 broken_fd   varchar(1) check (broken_fd in ('Y','N')),
	 primary key (fd_id),
	 foreign key (userid) references users
		on delete set null
	);
create table curr_transact
	(trans_id 	numeric(20,0) not null,
	 userid  varchar(20) not null,
	 ticker_symbol varchar(10),
	 invest_type varchar(2) check(ticker_symbol in ('B','S','MF')),
	 trans_type varchar(1) check(trans_type in ('B','S')),
	 price numeric(10,2),
	 quantity numeric(12,0),
	 time timestamp, 
	 primary key (trans_id),
	 foreign key (userid) references users
		on delete set null,
	 foreign key (ticker_symbol) references company on delete set null
	);
create table transact_history
	(trans_id 	numeric(20,0) not null,
	 userid  varchar(20) not null,
	 ticker_symbol varchar(10),
	 invest_type varchar(2) check(ticker_symbol in ('B','S','MF')),
	 trans_type varchar(1) check(trans_type in ('B','S')),
	 price numeric(10,2),
	 quantity numeric(12,0),
	 time timestamp,
	 success_trans varchar(1) check (success_trans in ('y','n')),
	 primary key (trans_id),
	 foreign key (userid) references users
		on delete set null,
	 foreign key (ticker_symbol) references company on delete set null
	);
 create table game_params
 	( game_param varchar(20),
 	  value numeric(10,3),
 	  primary key (game_param)
 	);
 create table fd_rates
 	( duration interval,
 	  interest_rate numeric(4,2),
 	  primary key (duration)
 	);
 CREATE INDEX userid_currtrans ON curr_transact (userid);
 CREATE INDEX userid_transhist ON transact_history (userid);
 CREATE INDEX time_transhist ON transact_history (time);
 CREATE INDEX userid_fd ON fd_table (userid);
 CREATE INDEX userid_fdhist ON fd_history (userid);
 CREATE INDEX day_fdhist ON fd_history (day_of_issue);
 insert into users values('admin','admin','99999999999','9999999999','admin@gmail.com','admin');