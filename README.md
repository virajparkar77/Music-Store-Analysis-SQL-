# Music-Store-Analysis-SQL-
SQL Music Store Analysis Project
Project Overview
This project involves a series of SQL queries designed to analyze various business datasets, focusing on sales data, customer transactions, employee-manager relationships, and product trends. The queries extract meaningful insights such as top customers, sales growth, employee hiring trends, and top-selling tracks and albums. The project uses window functions, aggregation, and filtering techniques to achieve these insights.
Queries Included
1. Employee-Manager Relationship
   
  •	Query: Displays the name of the manager for each employee.
  •	Purpose: To understand the reporting structure of employees by associating each employee with their respective manager.
3. Managers with 2 or More Team Members
•	Query: Identifies managers who have two or more direct reports.
•	Purpose: To list managers who are leading larger teams.
4. Employees Hired Before Their Manager
•	Query: Finds employees who were hired before their managers.
•	Purpose: To check for cases where an employee's tenure predates that of their manager.
5. Top 3 Customers by Year
•	Query: Retrieves the top 3 customers for each year based on the highest total purchases.
•	Purpose: To identify the most valuable customers annually.
6. Quarterly Sales by Country
•	Query: Calculates total sales for each quarter, grouped by country.
•	Purpose: To analyze seasonal sales trends in different countries.
7. Top 2 Cities by Sales for Each Country
•	Query: Lists the top 2 cities with the highest sales in each country.
•	Purpose: To pinpoint cities contributing the most to sales revenue.
8. Countries with Increasing Sales Every Year
•	Query: Identifies countries where sales have consistently increased year-over-year.
•	Purpose: To track continuous sales growth by country.
9. Top 2 Selling Tracks Each Year
•	Query: Retrieves the top 2 selling tracks for each year.
•	Purpose: To identify the most popular tracks annually.
10. Top 2 Selling Albums Each Year (with Artist Names)
•	Query: Shows the top 2 selling albums each year, along with the associated artist names.
•	Purpose: To determine which albums and artists drove the most sales each year.

SQL Techniques Used
•	Window Functions: RANK(), LAG() for ranking and comparing rows within partitions.
•	Aggregations: SUM(), COUNT() to calculate total sales, track sales volume, and number of reports.
•	JOINs: Various types of joins (INNER JOIN, LEFT JOIN, RIGHT JOIN) to merge tables such as employee, invoice, customer, and track.
•	Subqueries: Both inline and Common Table Expressions (CTEs) for modular and readable query structures.
•	Filters: WHERE, HAVING clauses to filter records based on specific conditions.

Conclusion
This project offers valuable insights into business operations, including customer behavior, sales trends, and employee management. It leverages powerful SQL techniques to perform advanced data analysis, helping organizations make data-driven decisions.

