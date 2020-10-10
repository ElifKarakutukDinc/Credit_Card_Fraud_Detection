drop table if exists merchant;

with merchant_main as (
select distinct merchant, merch_lat, merch_long, category, trans_date_trans_time,
rank() over (partition by merchant order by trans_date_trans_time desc) as rank
from fraud f), 

fraud_transaction_count as (
--1)Kisinin fraud islem hareketi sayisi 
select 
	merchant, 
	count(*) fraud_transaction_count
from fraud f 
where is_fraud = 1
group by 1), 

non_fraud_transaction_count as (
--2)Kisinin fraud olmayan islem hareket sayisi
select 
	merchant, 
	count(*) non_fraud_transaction_count
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
	coalesce (non_fraud_transaction_count,0) as non_fraud_transaction_count
into 
	merchant 
from merchant_main as mm
left join fraud_transaction_count ftc
	on (mm.merchant = ftc.merchant)
left join non_fraud_transaction_count nftc
	on (mm.merchant = nftc.merchant)
where rank= 1 


;

--3)Kisi fraud mu? eger fraud islem hareketi >  0 ise fraud degilse fraud degil
select merchant,
case when Sum(is_fraud) >0  then 'Fraud' 
          when Sum(is_fraud)= 0 then 'Not_Fraud' else 'Other' end,
          Sum(is_fraud)
from fraud f 
group by 1;

--4-5)Kisinin hafta ici ve hafta sonu toplam islem hareketi
select merchant,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
count (*) as weekday_groups_count
from fraud f 
group by 1,2;

--6-7-8-9)Kisinin hafta ici ve haftasonu toplam fraud islem hareketi ve Kisinin hafta ici ve haftasonu toplam fraud olmayan islem hareketi
select merchant, is_fraud,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum (is_fraud) as weekday_groups_count 
from fraud f 
group by 1,2,3;

--10-11)Kisinin fraud islemlerdeki toplam tutari ve Kisinin fraud olmayan islemlerdeki toplam tutari
select merchant, is_fraud, sum(amt) as total_amount
from fraud f 
group by 1,2;

--12-13-14-15) Kisinin hafta ici toplam tutari fraud islem hareketi/ Kisinin hafta ici toplam tutari fraud olmayan islem hareketi /Kisinin hafta sonu toplam tutari fraud islem hareketi /Kisinin hafta sonu toplam tutari fraud olmayan islem hareketi
select merchant, is_fraud,
 	   case 
       when extract(isodow from trans_date_trans_time) in (1,2,3,4,5) then 'Weekday'
       when extract(isodow from trans_date_trans_time) in (6,7) then 'Weekend'
END weekday_groups, 
sum(amt) total_amount_weekday
from fraud f 
group by 1,2,3;

--16)Kisinin islem yaptigi musterilerinin yani credit card holder larin yas ortalamalari
select merchant, avg(date_part('year',age(dob))) as avg_age_holders
from fraud f 
group by 1;

--17-18) Kisinin fraud islemlerindeki  musterilerinin yani credit card holder larin yas ortalamalari / Kisinin fraud olmayan islemlerindeki  musterilerinin yani credit card holder larin yas ortalamalari
select merchant,is_fraud, avg(date_part('year',age(dob))) as avg_age_holders
from fraud f 
group by 1,2;