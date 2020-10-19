--total fraud transactions amount of merchants 
select merchant, sum(total_fraud_amount)
from merchant 
group by 1
order by 2 desc;