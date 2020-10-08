select is_fraud, 
count (*) as unique_count,
sum (amt) as total_amount,
min (amt) as min_amount,
max (amt) as max_amount,
avg (amt) as avg_amount,
stddev(amt) as stddev_amount,
avg(date_part('year',age(dob))) as avg_age,
avg (city_pop) as avg_population,
avg( extract('hour' from trans_date_trans_time )) as time_groups
from fraud f 
group by 1;

