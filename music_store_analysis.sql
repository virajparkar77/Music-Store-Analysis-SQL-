
--Q1. write name of manger in front of each employee whome they report

select e1.employee_id,e1.first_name, e1.last_name, concat (e2.first_name, ' ',e2.last_name) as 'Manager'
from employee e1 left join employee e2
on e1.reports_to = e2.employee_id

--Q2 write name of manager that has 2 or more Team Member

with count_of_staff as (
	select reports_to , count(*) as count_of_reports_to
	from employee
	group by reports_to
	)
select concat( employee.first_name, ' ', employee.last_name) as 'Manager name', count_of_staff.reports_to as 'Number of Team Member'
from employee inner join count_of_staff
on employee.employee_id = count_of_staff.reports_to and count_of_staff.count_of_reports_to >=2


-- Q3.Write Query to show name of employee who where hired before their manager

with emplyee_table as (
	select e1.employee_id,e1.first_name, e1.last_name, concat (e2.first_name, ' ',e2.last_name) as 'Manager', 
	e1.hire_date as 'Employee_hire_date', e2.hire_date as 'Manager_hire_date'
	from employee e1 left join employee e2
	on e1.reports_to = e2.employee_id
)
select concat (emplyee_table.first_name, ' ',emplyee_table.last_name) as 'Employee_name' ,emplyee_table.Employee_hire_date , emplyee_table.Manager_hire_date 
from emplyee_table
where emplyee_table.Manager_hire_date > emplyee_table.Employee_hire_date

-- Q.4 select top 3 customer each year that have made highest purchase

with result as (
	select customer_id, year(invoice_date) as year_of_purchase, sum(total) as Total_purchase,
	rank() over (partition by  year(invoice_date) order by sum(total) desc) as Customer_rank
	from invoice 
	group by customer_id, year(invoice_date)
),
customer_data as 
(
	select result.customer_id,customer.first_name as customer_first_name, customer.last_name as customer_last_name , 
	result.year_of_purchase as Purchase_year , result.Total_purchase as Customer_total_purchase ,result.Customer_rank as customer_rank
	from customer right join result
	on customer.customer_id =  result.customer_id 
)
select * from customer_data
where customer_data.customer_rank < =3
order by customer_data.Purchase_year, customer_data.customer_rank


-- Q.5 calculate sales for each quater of each year and for every country

select billing_country as Country, round(sum(total), 2) as total_sales,
		year (invoice_date) as Sales_year, Datepart(QUARTER, invoice_date) AS Quater
from invoice
group by year (invoice_date),billing_country,year (invoice_date),Datepart(QUARTER, invoice_date)



-- Q6.Sales top 2 cities from each country with highest sales

select * from (
				select billing_country, billing_city ,
				round(sum(total), 2) as total_sales_by_state,
				rank() over (partition by billing_country order by round(sum(total), 2) desc) as city_rank
				from invoice i 
				group by  billing_country, billing_city
				) s
where s.city_rank <= 2

--Q7. Select countriees where the sales have been increasing each year

with previous_sales_table as  (
	select billing_country, year( invoice_date) as sales_year, round(sum(total),2) as Total_sales, 
	lag(round(sum(total),2)) over (partition by billing_country order by year( invoice_date)) as previous_year_sales
	from invoice
	group by billing_country, year( invoice_date)
),
tabel_with_no_null as(
	select previous_sales_table.billing_country as Billing_country,
	previous_sales_table.sales_year as Sales_Year,
	previous_sales_table.Total_sales as Total_Sales,
	 previous_sales_table.previous_year_sales as Previous_year_Sales
	from previous_sales_table
	where previous_sales_table.previous_year_sales is not null
),
table_self_join as(
	select pt.Billing_country, pt.Sales_Year, pyt.Total_Sales
	from tabel_with_no_null as pt join 
	tabel_with_no_null as pyt on 
	pt.Billing_country = pyt.Billing_country and pt.Sales_Year = pyt. Sales_Year
	where pyt.Total_Sales >  pt.Previous_year_Sales
)
select Billing_country as'Country with YOY revenue growth '
from (
select Billing_country, count(*) as count_country
from table_self_join
group by Billing_country
) a
where a.count_country =3

--Q8. Select top 2 selling Track each year


select Sales_Year,Track_Name, Count_of_track as Unit_Sold,Ranking_By_Sales
from
(
	select Sales_Year, Track_Name, rank() over(partition by Sales_Year order by Count_of_track desc) as Ranking_By_Sales,Count_of_track
	from
	(
		select year(i.invoice_date) as Sales_Year, t.name as Track_Name, count(t.name) as Count_of_track
		from invoice i join invoice_line  as il
		on i.invoice_id = il.invoice_id 
		join track t on il.track_id = t.track_id
		group by year(i.invoice_date),t.name
		
	) as a
) as b
where Ranking_By_Sales <3

-- Q9. Select top two most selling album along with its artist's name each year

select Sales_Year,Album_name,Artist_name,Ranking_By_Sales
from
(
	select Sales_Year, Album_name,Artist_name,Unit_sold,
	rank() over(partition by Sales_Year order by Unit_sold desc) as Ranking_By_Sales
	from
	(
		select year(i.invoice_date) as Sales_Year, a.title as Album_name, count(a.title) as Unit_sold, ar.name as Artist_name
		from invoice i join invoice_line  as il
		on i.invoice_id = il.invoice_id 
		join track t on il.track_id = t.track_id
		join album a on t.album_id = a.album_id
		join artist ar on a.artist_id = ar.artist_id
		group by year(i.invoice_date),a.title,ar.name
		
	) as a
) as b
where Ranking_By_Sales <3
