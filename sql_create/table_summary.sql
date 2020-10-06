SELECT * INTO table_summary FROM (
select 'index' as column_name , count (distinct "index") as unique_count, 
Sum (case when "index" is null then 1 else 0 end ) as null_count, 
min (distinct "index") as min_value,
max (distinct "index") as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select 'cc_num' as column_name , 
count (distinct cc_num ) as unique_count, 
sum (case when cc_num  is null then 1 else 0 end ) as null_count, 
min (distinct cc_num) as min_value,
max (distinct cc_num) as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'merchant' as column_name , 
count (distinct merchant  ) as unique_count, 
sum (case when merchant  is null then 1 
          when length(trim(merchant)) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'category' as column_name , 
count (distinct category ) as unique_count, 
sum (case when category  is null then 1 
          when length(trim(category)) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'amt' as column_name , 
count (distinct amt ) as unique_count, 
sum (case when amt is null then 1 else 0 end ) as null_count, 
min (distinct amt) as min_value,
max (distinct amt) as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'first' as column_name , 
count (distinct "first" ) as unique_count, 
sum (case when "first"  is null then 1 
          when length(trim("first")) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'last' as column_name , 
count (distinct "last" ) as unique_count, 
sum (case when "last"  is null then 1 
          when length(trim("last")) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'gender' as column_name , 
count (distinct gender) as unique_count, 
sum (case when gender  is null then 1 
          when length(trim(gender)) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'street' as column_name , 
count (distinct street) as unique_count, 
sum (case when street  is null then 1 
          when length(trim(street)) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'city' as column_name , 
count (distinct city) as unique_count, 
sum (case when city  is null then 1 
          when length(trim(city)) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'state' as column_name , 
count (distinct state) as unique_count, 
sum (case when state  is null then 1 
          when length(trim(state)) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'zip' as column_name , 
count (distinct zip) as unique_count, 
sum (case when zip is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'lat' as column_name , 
count (distinct lat) as unique_count, 
sum (case when lat is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'long' as column_name , 
count (distinct long) as unique_count, 
sum (case when long is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'city_pop' as column_name , 
count (distinct city_pop) as unique_count, 
sum (case when city_pop is null then 1 else 0 end ) as null_count, 
min (distinct city_pop) as min_value,
max (distinct city_pop) as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'job ' as column_name , 
count (distinct job) as unique_count, 
sum (case when job  is null then 1 
          when length(trim(job)) = 0 then 1 else 0 end) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'trans_num ' as column_name , 
count (distinct trans_num ) as unique_count, 
sum (case when trans_num  is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'merch_lat ' as column_name , 
count (distinct merch_lat ) as unique_count, 
sum (case when merch_lat is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'merch_long ' as column_name , 
count (distinct merch_long ) as unique_count, 
sum (case when merch_long  is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'is_fraud  ' as column_name , 
count (distinct is_fraud ) as unique_count, 
sum (case when is_fraud  is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
cast('9999-01-01 00:00:01' as timestamp) as min_date,
cast('9999-01-01 00:00:01' as timestamp) as max_date
from  fraud f
union
select  'trans_date_trans_time' as column_name , 
count (distinct trans_date_trans_time) as unique_count, 
Sum (case when extract(epoch from trans_date_trans_time) is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
TO_TIMESTAMP (min (extract(epoch from trans_date_trans_time))) as min_date,
TO_TIMESTAMP (max (extract(epoch from trans_date_trans_time))) as max_date
from  fraud f
union
select  'dob ' as column_name , 
count (distinct dob ) as unique_count, 
Sum (case when extract(epoch from dob ) is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
TO_TIMESTAMP (min (extract(epoch from dob ))) as min_date,
TO_TIMESTAMP (max (extract(epoch from dob ))) as max_date
from  fraud f
union
select  'unix_time ' as column_name , 
count (distinct unix_time ) as unique_count, 
Sum (case when unix_time is null then 1 else 0 end ) as null_count, 
0 as min_value,
0 as max_value,
TO_TIMESTAMP (min (unix_time)) as min_date,
TO_TIMESTAMP (max (unix_time)) as max_date
from  fraud f) as summary;

