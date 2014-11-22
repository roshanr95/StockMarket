#! /bin/bash

DATERM=2014-11-16
DATE=2014-11-21

for company in BOM500410 BOM500103 BOM532454 BOM532868 BOM500300 BOM500180 BOM500010 BOM500440 BOM500696 BOM532174 BOM500209 BOM500875 BOM532532 BOM500510 BOM500520 BOM532500 BOM532555 BOM500312 BOM500359 BOM532712 BOM500325 BOM500390 BOM532540 BOM500570 BOM500400 BOM500470 BOM507685 
do
  OUTPUT=$(curl "https://www.quandl.com/api/v1/datasets/BSE/"$company".csv?auth_token=JHQyG_i9y_7Rzagi_E8N&exclude_headers=true&column=5&sort_order=asc&collapse=daily&trim_start=$DATE&trim_end=$DATE")
  IFS=',' read -a array <<< "$OUTPUT"
  psql -U karan -d stockmarket -c "insert into stock_history values('$company','${array[0]}',${array[1]})"
done

psql -U karan -d stockmarket -c "delete from stock_history where day='$DATERM'"