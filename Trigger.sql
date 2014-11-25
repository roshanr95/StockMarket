create or replace function matchorder() returns trigger as $stockupdate$
declare
	singleorder record;
begin
	for singleorder in select * from curr_transact 
	where ticker_symbol=new.ticker_symbol
	loop
		if singleorder.trans_type = 'B' and singleorder.price > new.curr_stock_price then
			update ownership set quantity = quantity + singleorder.quantity
			where userid = singleorder.userid and ticker_symbol = singleorder.ticker_symbol;

			insert into ownership (userid, ticker_symbol, invest_type, quantity)
			select singleorder.userid, singleorder.ticker_symbol, singleorder.invest_type, singleorder.quantity
			where not exists(select * from ownership where userid = singleorder.userid and ticker_symbol = singleorder.ticker_symbol);

			insert into transact_history values(singleorder.trans_id, singleorder.userid, singleorder.ticker_symbol, singleorder.invest_type, singleorder.trans_type, singleorder.price, singleorder.quantity, singleorder.time, 'Y');
			
			delete from curr_transact where trans_id = singleorder.trans_id;
		elsif singleorder.trans_type = 'S' and singleorder.price < new.curr_stock_price then
			update users set balance = balance + singleorder.price*singleorder.quantity
			where userid = singleorder.userid;
			
			insert into transact_history values(singleorder.trans_id, singleorder.userid, singleorder.ticker_symbol, singleorder.invest_type, singleorder.trans_type, singleorder.price, singleorder.quantity, singleorder.time, 'Y');

			delete from curr_transact where trans_id = singleorder.trans_id;
		end if;
	end loop;
	return new;
end;
$stockupdate$ language plpgsql;

drop trigger if exists stockupdate on company;

create trigger stockupdate after update
on company
for each row
execute procedure matchorder();
