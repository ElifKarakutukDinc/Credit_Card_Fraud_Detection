select is_fraud, 
count (*) as unique_count,
sum (amt) as total_amount,
min (amt) as min_amount,
max (amt) as max_amount,
avg (amt) as avg_amount,
stddev(amt) as stddev_amount,
sum (date_part('year',age(dob))) as total_age,
min (date_part('year',age(dob))) as min_age,
max (date_part('year',age(dob))) as max_age,
avg (date_part('year',age(dob))) as avg_age,
stddev(date_part('year',age(dob))) as stddev_age,
sum (city_pop) as total_population,
min (city_pop) as min_population,
max (city_pop) as max_population,
avg (city_pop) as avg_population,
stddev(city_pop) as stddev_population,
sum (extract('hour' from trans_date_trans_time )) as total_time_value,
min (extract('hour' from trans_date_trans_time )) as min_time_value,
max (extract('hour' from trans_date_trans_time )) as max_time_value,
avg (extract('hour' from trans_date_trans_time )) as avg_time_value,
stddev(extract('hour' from trans_date_trans_time )) as stddev_time_value
into is_fraud_table
from fraud f 
group by 1;

