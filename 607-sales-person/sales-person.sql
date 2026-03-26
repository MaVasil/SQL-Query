/* Write your PL/SQL query statement below */
select s.name from salesperson  s where s.sales_id not in(
    select o.sales_id from orders o inner join company c on o.com_id=c.com_id where o.com_id=(select com_id from company where name='RED')
)