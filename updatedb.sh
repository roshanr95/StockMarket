#! /bin/bash

#DATE=`date +%Y-%m-%d`
for DATE in 2014-11-21 2014-11-20 2014-11-19 2014-11-18 2014-11-17
do
	for company in BOM500410 BOM500103 BOM532454 BOM532868 BOM500300 BOM500180 BOM500010 BOM500440 BOM500696 BOM532174 BOM500209 BOM500875 BOM532532 BOM500510 BOM500520 BOM532500 BOM532555 BOM500312 BOM500359 BOM532712 BOM500325 BOM500390 BOM532540 BOM500570 BOM500400 BOM500470 BOM507685
	do
	  OUTPUT=$(curl "https://www.quandl.com/api/v1/datasets/BSE/"$company".csv?auth_token=JHQyG_i9y_7Rzagi_E8N&exclude_headers=true&column=5&sort_order=asc&collapse=daily&trim_start=$DATE&trim_end=$DATE")
	  IFS=',' read -a array <<< "$OUTPUT"
	  /Applications/Postgres.app/Contents/Versions/9.3/bin/psql -p5432 -dstockmarket -U karan -c "insert into stock_history values('$company','${array[0]}',${array[1]})"
	  /Applications/Postgres.app/Contents/Versions/9.3/bin/psql -p5432 -dstockmarket -U karan -c "update company set curr_stock_price=${array[1]} where ticker_symbol='$company'"
	done

	for company in CPSEETF RELCNX100 BSLNIFTY M100 INFRABEES M50 QNIFTY RELBANK KOTAKPSUBK SHARIABEES PSUBNKBEES BANKBEES JUNIORBEES NIFTYBEES
	do
	  OUTPUT=$(curl "https://www.quandl.com/api/v1/datasets/NSE/"$company".csv?auth_token=JHQyG_i9y_7Rzagi_E8N&exclude_headers=true&column=5&sort_order=asc&collapse=daily&trim_start=$DATE&trim_end=$DATE")
	  IFS=',' read -a array <<< "$OUTPUT"
	  /Applications/Postgres.app/Contents/Versions/9.3/bin/psql -p5432 -dstockmarket -U karan -c "insert into stock_history values('$company','${array[0]}',${array[1]})"
	  /Applications/Postgres.app/Contents/Versions/9.3/bin/psql -p5432 -dstockmarket -U karan -c "update company set curr_stock_price=${array[1]} where ticker_symbol='$company'"
	done
done