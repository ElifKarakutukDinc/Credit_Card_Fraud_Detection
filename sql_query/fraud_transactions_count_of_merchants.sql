--fraud transactions count of merchants 
select merchant, sum(fraud_count )
from merchant 
group by 1
order by 2 desc;