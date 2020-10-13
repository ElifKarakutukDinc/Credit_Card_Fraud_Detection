drop table if exists merchant;

with merchant_main as (
select distinct merchant, merch_lat, merch_long, category, trans_date_trans_time,
rank() over (partition by merchant order by trans_date_trans_time desc) as rank
from fraud f), 

fraud_transaction_count as (
--Fraud transaction count of Merchant
select 
	merchant, 
	count(*) fraud_transaction_count
from fraud f 
where is_fraud = 1
group by 1), 

non_fraud_transaction_count as (
--Non-Fraud transaction count of Merchant
select 
	merchant, 
	count(*) non_fraud_transaction_count
from fraud f 
where is_fraud = 0
group by 1),

--Are Merchants Fraud? If Fraud transaction count of Merchant >0 merchant is Fraud
who_fraud as (
select 
	 merchant,
	 case when Sum(is_fraud) >0  then 'Fraud' 
          when Sum(is_fraud)= 0 then 'Not_Fraud' else 'Other' end,
          Sum(is_fraud) as fraud_count
from fraud f 
group by 1),

--Total transaction count of merchant at weekday.
weekday_groups_count as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
count (*) as weekday_groups_count
from fraud f 
where extract(isodow from trans_date_trans_time) in (1,2,3,4,5)
group by 1,2),

--Total transaction count of merchant at weekend
weekend_groups_count as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
count (*) as weekend_groups_count
from fraud f 
where extract(isodow from trans_date_trans_time) in (6,7)
group by 1,2),

--Total fraud transaction count of merchant at weekday
weekday_fraud_groups_count as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum (is_fraud) as weekday_fraud_groups_count 
from fraud f 
where is_fraud=1 and extract(isodow from trans_date_trans_time) in (1,2,3,4,5)
group by 1,2),

--Total fraud transaction count of merchant at weekend
weekend_fraud_groups_count as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum (is_fraud) as weekend_fraud_groups_count 
from fraud f 
where is_fraud=1 and extract(isodow from trans_date_trans_time) in (6,7)
group by 1,2),

--Total non-fraud transaction count of merchant at weekday
weekday_non_fraud_groups_count as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum (is_fraud) as weekday_non_fraud_groups_count 
from fraud f 
where is_fraud=0 and extract(isodow from trans_date_trans_time) in (1,2,3,4,5)
group by 1,2),

--Total non-fraud transaction count of merchant at weekend
weekend_non_fraud_groups_count as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum (is_fraud) as weekend_non_fraud_groups_count 
from fraud f 
where is_fraud=0 and extract(isodow from trans_date_trans_time) in (6,7)
group by 1,2),

--Total fraud amount of Merchant 
total_fraud_amount as(
select merchant,
sum(amt) as total_fraud_amount
from fraud f 
where is_fraud=1
group by 1),

--Total non-fraud amount of Merchant 
total_non_fraud_amount as(
select merchant, 
sum(amt) as total_non_fraud_amount
from fraud f 
where is_fraud=0
group by 1),

--Total fraud amount of Merchant at weekday 
total_weekday_fraud_amount as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum(amt) as total_weekday_fraud_amount
from fraud f 
where is_fraud=1 and extract(isodow from trans_date_trans_time) in (1,2,3,4,5)
group by 1,2),

--Total non-fraud amount of Merchant at weekday
total_weekday_non_fraud_amount as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum(amt) as  total_weekday_non_fraud_amount
from fraud f 
where is_fraud=0 and extract(isodow from trans_date_trans_time) in (1,2,3,4,5)
group by 1,2),

--Total fraud amount of Merchant at weekend
total_weekend_fraud_amount as (
select merchant, 
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum(amt) as total_weekend_fraud_amount
from fraud f 
where is_fraud=1 and extract(isodow from trans_date_trans_time) in (6,7)
group by 1,2),

--Total non-fraud amount of Merchant at weekend
total_weekend_non_fraud_amount as (
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum(amt) as total_weekend_non_fraud_amount
from fraud f 
where is_fraud=0 and extract(isodow from trans_date_trans_time) in (6,7)
group by 1,2),

--Avg age of credit card holders who shopping from merchant
avg_holder_age as (
select merchant, 
avg(date_part('year',age(dob))) as avg_holder_age
from fraud f 
group by 1),

--Avg age of credit card holders who shopping from at fraud transactions of merchant 
avg_holder_age_fraud as (
select merchant, 
avg(date_part('year',age(dob))) as avg_holder_age_fraud
from fraud f 
where is_fraud = 1 
group by 1),

--Avg age of credit card holders who shopping from at non-fraud transactions of merchant 
avg_holder_age_non_fraud as (
select merchant, 
avg(date_part('year',age(dob))) as avg_holder_age_non_fraud
from fraud f 
where is_fraud = 0 
group by 1)

select 
	replace(mm.merchant, 'fraud_', '') as merchant,
	merch_lat as last_transaction_lat, 
	merch_long as last_transaction_long, 
	category as last_transaction_category, 
	trans_date_trans_time as last_transaction_timestamp,
	coalesce (fraud_transaction_count,0) as fraud_transaction_count,
	coalesce (non_fraud_transaction_count,0) as non_fraud_transaction_count,
	coalesce (fraud_count,0) as fraud_count,
	coalesce (weekday_groups_count,0) as weekday_groups_count, 
	coalesce (weekend_groups_count,0) as weekend_groups_count, 
	coalesce (weekday_fraud_groups_count,0) as weekday_fraud_groups_count,
	coalesce (weekend_fraud_groups_count,0) as weekend_fraud_groups_count,
	coalesce (weekday_non_fraud_groups_count,0) as weekday_non_fraud_groups_count,
	coalesce (weekend_non_fraud_groups_count,0) as weekend_non_fraud_groups_count,
	coalesce (total_fraud_amount,0) ::numeric (18,2) as total_fraud_amount,
	coalesce (total_non_fraud_amount,0)::numeric (18,2) as total_non_fraud_amount,
	coalesce (total_weekday_fraud_amount,0)::numeric (18,2)  as total_weekday_fraud_amount,
	coalesce (total_weekday_non_fraud_amount,0)::numeric (18,2)  as total_weekday_non_fraud_amount,
	coalesce (total_weekend_fraud_amount,0) ::numeric (18,2) as total_weekend_fraud_amount,
	coalesce (total_weekend_non_fraud_amount,0) ::numeric (18,2) as total_weekend_non_fraud_amount,
	coalesce (avg_holder_age,0) ::numeric (18,2) as avg_holder_age,
	coalesce (avg_holder_age_fraud,0) ::numeric (18,2) as avg_holder_age_fraud,
	coalesce (avg_holder_age_non_fraud,0)::numeric (18,2)  as avg_holder_age_non_fraud
into 
	merchant 
from merchant_main as mm
left join fraud_transaction_count ftc
	on (mm.merchant = ftc.merchant)
left join non_fraud_transaction_count nftc
	on (mm.merchant = nftc.merchant)
left join who_fraud wf
	on (mm.merchant = wf.merchant)
left join weekday_groups_count wgc
	on (mm.merchant = wgc.merchant)
left join weekend_groups_count wegc
	on (mm.merchant = wegc.merchant)
left join weekday_fraud_groups_count wfgc
	on (mm.merchant = wfgc.merchant)
left join weekend_fraud_groups_count wefgc
	on (mm.merchant = wefgc.merchant)
left join weekday_non_fraud_groups_count wnfgc
	on (mm.merchant = wnfgc.merchant)
left join weekend_non_fraud_groups_count wenfgc
	on (mm.merchant = wenfgc.merchant)
left join total_fraud_amount tfa
	on (mm.merchant = tfa.merchant)
left join total_non_fraud_amount tnfa
	on (mm.merchant = tnfa.merchant)
left join total_weekday_fraud_amount twfa
	on (mm.merchant = twfa.merchant)
left join total_weekday_non_fraud_amount twnfa
	on (mm.merchant = twnfa.merchant)
left join total_weekend_fraud_amount twefa
	on (mm.merchant = twefa.merchant)
left join total_weekend_non_fraud_amount twenfa
	on (mm.merchant = twenfa.merchant)
left join avg_holder_age aha
	on (mm.merchant = aha.merchant)
left join avg_holder_age_fraud ahaf
	on (mm.merchant = ahaf.merchant)
left join avg_holder_age_non_fraud ahanf
	on (mm.merchant = ahanf.merchant)
where rank=1;

