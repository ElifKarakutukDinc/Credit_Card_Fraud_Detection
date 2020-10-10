drop table if exists fraud_t_test;

select
   is_fraud,
   count (*) as unique_count,
   sum (amt)::numeric(18, 2) as total_amount,
   min (amt)::numeric(18, 2) as min_amount,
   max (amt)::numeric(18, 2) as max_amount,
   avg (amt)::numeric(18, 2) as avg_amount,
   stddev(amt)::numeric(18, 2) as stddev_amount,
   avg(date_part('year', age(dob)))::numeric(18, 2) as avg_age,
   min(date_part('year', age(dob)))::numeric(18, 2) as min_age,
   max(date_part('year', age(dob)))::numeric(18, 2) as max_age,
   avg (city_pop)::numeric(18, 2) as avg_population,
   avg( extract('hour' 
from
   trans_date_trans_time ))::numeric(18, 2) as transaction_hour 
into
	fraud_t_test
from
   fraud f 
group by
   1;