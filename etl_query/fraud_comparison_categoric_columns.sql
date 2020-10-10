drop table if exists categoric_comparison;

select *
into categoric_comparison
from (
--count of fraud and non fraud count by gender. 
select 
	is_fraud,
	'gender'::varchar as categoric_column,
	gender as categories,
	count (*) as "count"
from 
	fraud f
group by 
	1,3
union
--count of fraud and non fraud by weekday and weekend. 
select is_fraud, 
	   'day_of_week' as categoric_column,
	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END as categories, 
count (*) as "count"
from fraud 
group by 1,3 
union
--count of fraud and non fraud by time periods. 
select is_fraud, 
'hour_of_day' as categoric_column,
CASE 
      WHEN extract('hour' from trans_date_trans_time) between 0 and 6 THEN 'night'
      WHEN extract('hour' from trans_date_trans_time) between 7 and 12 THEN 'morning'
      WHEN extract('hour' from trans_date_trans_time) between 13 and 18 THEN 'noon'
      WHEN extract('hour' from trans_date_trans_time) between 19 and 23 THEN 'evening'
end categories , 
count(*) as "count"
from fraud
group by 1,3
union
--count of fraud and non fraud count by category. 
select 
	is_fraud, 
	'merchant_category' as categoric_column,
	category as categories,
	count (*) as "count"
from 
	fraud f
group by 
	1,3) A