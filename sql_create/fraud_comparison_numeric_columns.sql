drop table if exists numeric_comparison;

select *
into
	numeric_comparison
from 
(
select 
   is_fraud,
   'amount'::varchar as numeric_column,
   sum (amt)::numeric(18, 2) as total,
   avg (amt)::numeric(18, 2) as "avg",
   stddev(amt)::numeric(18, 2) as "stddev",
   min (amt)::numeric(18, 2) as "min",
   max (amt)::numeric(18, 2) as "max"
   from
   fraud f
   group by 1
   union
   select
   is_fraud,
   'age'::varchar as numeric_column,
   sum (date_part('year', age(dob)))::numeric(18, 2) as total,
   avg (date_part('year', age(dob)))::numeric(18, 2) as "avg",
   stddev(date_part('year', age(dob)))::numeric(18, 2) as "stddev",
   min (date_part('year', age(dob)))::numeric(18, 2) as "min",
   max (date_part('year', age(dob)))::numeric(18, 2) as "max"
   from
   fraud f
   group by 1
   union 
   select
   is_fraud,
   'population'::varchar as numeric_column,
   sum (city_pop)::numeric(18, 2) as total,
   avg (city_pop)::numeric(18, 2) as "avg",
   stddev(city_pop)::numeric(18, 2) as "stddev",
   min (city_pop)::numeric(18, 2) as "min",
   max (city_pop)::numeric(18, 2) as "max"
   from
   fraud f
   group by 1
   union
   select
   is_fraud,
   'transaction_hour'::varchar as numeric_column,
   sum (extract('hour' 
from
   trans_date_trans_time ))::numeric(18, 2) as total,
   avg (extract('hour' 
from
   trans_date_trans_time ))::numeric(18, 2) as "avg",
   stddev(extract('hour' 
from
   trans_date_trans_time ))::numeric(18, 2) as "stddev",
   min (extract('hour' 
from
   trans_date_trans_time ))::numeric(18, 2) as "min",
   max (extract('hour' 
from
   trans_date_trans_time ))::numeric(18, 2) as "max"
   from
   fraud f
   group by 1) A