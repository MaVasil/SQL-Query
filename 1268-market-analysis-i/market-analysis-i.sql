/* Write your PL/SQL query statement below */
select u.user_id as buyer_id,to_char(u.join_date,'yyyy-mm-dd') as join_date,sum(case when to_char(o.order_date,'yyyy')=2019 then 1 else 0 end) as orders_in_2019 from users u left join Orders o on u.user_id=o.buyer_id
group by u.user_id,u.join_date,o.buyer_id
order by user_id;