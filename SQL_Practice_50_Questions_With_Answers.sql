create database sql_practice;
use sql_practice;
create table employees(
emp_id int primary key,
emp_name varchar(50),
department varchar(30),
salary decimal(10,2),
manager_id int,
joining_date date,
foreign key(manager_id)references employees(emp_id));

create table customers(
customer_id int primary key,
customer_name varchar(50),
city varchar(50));

create table orders(
order_id int primary key,
customer_id int,
order_date date,
amount decimal(10,2),
status varchar(20),
foreign key (customer_id) references customers(customer_id));

create table products(
product_id int primary key,
product_name varchar(50),
category varchar(30),
price decimal(10,2));

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO employees VALUES
(101, 'Rahul Sharma', 'HR', 45000, NULL, '2020-01-15'),
(102, 'Priya Patel', 'IT', 75000, NULL, '2019-03-10'),
(103, 'Amit Verma', 'Finance', 65000, NULL, '2018-06-20'),
(104, 'Sneha Joshi', 'Sales', 55000, NULL, '2021-02-12'),
(105, 'Karan Mehta', 'Marketing', 60000, NULL, '2019-11-05'),
(106, 'Neha Singh', 'IT', 50000, 102, '2021-07-15'),
(107, 'Rohan Gupta', 'HR', 35000, 101, '2022-04-10'),
(108, 'Pooja Desai', 'Finance', 42000, 103, '2022-08-18'),
(109, 'Vikas Kumar', 'Sales', 38000, 104, '2023-01-20'),
(110, 'Anjali Shah', 'Marketing', 40000, 105, '2022-05-25'),
(111, 'Suresh Patil', 'IT', 58000, 102, '2020-09-12'),
(112, 'Meera Nair', 'HR', 32000, 101, '2023-06-01'),
(113, 'Arjun Rao', 'Finance', 48000, 103, '2021-12-15'),
(114, 'Kavita More', 'Sales', 45000, 104, '2022-10-08'),
(115, 'Nikhil Jain', 'Marketing', 52000, 105, '2020-04-22'),
(116, 'Divya Iyer', 'IT', 62000, 102, '2019-08-30'),
(117, 'Manish Yadav', 'HR', 38000, 101, '2024-01-10'),
(118, 'Riya Kulkarni', 'Finance', 55000, 103, '2023-03-14'),
(119, 'Akash Mishra', 'Sales', 41000, 104, '2024-05-20'),
(120, 'Simran Kaur', 'Marketing', 47000, 105, '2023-09-11');

INSERT INTO customers VALUES
(201, 'Aarav Enterprises', 'Mumbai'),
(202, 'Bright Solutions', 'Pune'),
(203, 'Global Traders', 'Delhi'),
(204, 'Smart Retail', 'Mumbai'),
(205, 'Tech World', 'Bangalore'),
(206, 'Fresh Mart', 'Pune'),
(207, 'Prime Services', 'Chennai'),
(208, 'City Electronics', 'Hyderabad'),
(209, 'Royal Stores', 'Delhi'),
(210, 'Digital Hub', 'Mumbai'),
(211, 'Green Foods', 'Nagpur'),
(212, 'Elite Fashion', 'Bangalore'),
(213, 'Quick Supplies', 'Chennai'),
(214, 'Star Enterprises', 'Pune'),
(215, 'Modern Living', 'Hyderabad');

INSERT INTO orders VALUES
(1001, 201, '2025-01-05', 15000, 'Completed'),
(1002, 202, '2025-01-08', 22000, 'Pending'),
(1003, 203, '2025-01-12', 18000, 'Completed'),
(1004, 204, '2025-01-15', 12000, 'Cancelled'),
(1005, 205, '2025-02-02', 35000, 'Completed'),
(1006, 206, '2025-02-05', 9000, 'Pending'),
(1007, 207, '2025-02-10', 27000, 'Completed'),
(1008, 208, '2025-02-14', 16000, 'Cancelled'),
(1009, 209, '2025-03-01', 42000, 'Completed'),
(1010, 210, '2025-03-05', 11000, 'Pending'),
(1011, 211, '2025-03-09', 8000, 'Completed'),
(1012, 212, '2025-03-15', 25000, 'Completed'),
(1013, 213, '2025-04-02', 19000, 'Cancelled'),
(1014, 214, '2025-04-07', 31000, 'Completed'),
(1015, 215, '2025-04-12', 14000, 'Pending'),
(1016, 201, '2025-04-18', 28000, 'Completed'),
(1017, 202, '2025-05-03', 17000, 'Completed'),
(1018, 203, '2025-05-09', 45000, 'Pending'),
(1019, 204, '2025-05-14', 13000, 'Completed'),
(1020, 205, '2025-05-20', 38000, 'Completed'),
(1021, 206, '2025-06-01', 21000, 'Cancelled'),
(1022, 207, '2025-06-08', 29000, 'Completed'),
(1023, 208, '2025-06-15', 24000, 'Pending'),
(1024, 209, '2025-06-21', 33000, 'Completed'),
(1025, 210, '2025-06-28', 12500, 'Completed');


INSERT INTO products VALUES
(301, 'Laptop', 'Electronics', 55000),
(302, 'Smartphone', 'Electronics', 25000),
(303, 'Headphones', 'Accessories', 2000),
(304, 'Keyboard', 'Accessories', 1500),
(305, 'Mouse', 'Accessories', 800),
(306, 'Office Chair', 'Furniture', 7500),
(307, 'Office Table', 'Furniture', 12000),
(308, 'Monitor', 'Electronics', 15000),
(309, 'Printer', 'Electronics', 18000),
(310, 'Water Bottle', 'Home', 500),
(311, 'Backpack', 'Accessories', 2500),
(312, 'Desk Lamp', 'Home', 1200),
(313, 'Tablet', 'Electronics', 30000),
(314, 'Bookshelf', 'Furniture', 9500),
(315, 'Smart Watch', 'Electronics', 8000);

INSERT INTO sales VALUES
(501, 301, 5, '2025-01-05'),
(502, 302, 8, '2025-01-08'),
(503, 303, 15, '2025-01-12'),
(504, 304, 20, '2025-01-15'),
(505, 305, 25, '2025-01-20'),
(506, 306, 4, '2025-02-02'),
(507, 307, 3, '2025-02-05'),
(508, 308, 7, '2025-02-10'),
(509, 309, 6, '2025-02-14'),
(510, 310, 30, '2025-02-18'),
(511, 311, 12, '2025-03-01'),
(512, 312, 18, '2025-03-05'),
(513, 313, 4, '2025-03-09'),
(514, 314, 5, '2025-03-15'),
(515, 315, 10, '2025-03-20'),
(516, 301, 3, '2025-04-02'),
(517, 302, 6, '2025-04-07'),
(518, 303, 22, '2025-04-12'),
(519, 304, 14, '2025-04-18'),
(520, 305, 35, '2025-04-22'),
(521, 306, 8, '2025-05-03'),
(522, 307, 2, '2025-05-09'),
(523, 308, 9, '2025-05-14'),
(524, 309, 4, '2025-05-20'),
(525, 310, 40, '2025-05-25'),
(526, 311, 16, '2025-06-01'),
(527, 312, 25, '2025-06-08'),
(528, 313, 7, '2025-06-15'),
(529, 314, 3, '2025-06-21'),
(530, 315, 12, '2025-06-28');


select * from employees;

SELECT * FROM customers;

SELECT * FROM orders;

SELECT * FROM products;

select * from sales;

SELECT * FROM sales;



-- Q1. Display all employees whose salary is greater than 50,000.

select * from employees where salary >50000;

-- Q3. Find the highest salary from employees.

select * from employees where department = 'sales';

-- Q3. Find the highest salary from employees.
select max(salary)as highest_salary from employees;

-- Q4. Find the average salary of each department.

select department,avg(salary)as average_salary
from  employees 
group by department;

-- Q5. Find departments having more than 3 employees.

select department,count(*) as total_employees
from employees 
group by department 
having count(*)>3;

-- Q6. Display the top 5 highest-paid employees.

select * from employees
order by salary desc limit 5;

-- Q7. Find customers from Mumbai.

select * from customers where city = "mumbai";

-- Q8. Find orders with amount greater than 10,000.
select * from orders where amount >10000;

-- Q9. Find total revenue from all orders.

select sum(amount) as total_revenue
from orders;


-- Q10. Find products whose price is between 500 and 5000.
select * from products where price between 500 and 5000;

-- Q11. Find the second-highest salary.
select max(salary) as second_highest_salary
from employees where salary<(select max(salary) from employees);

-- Q12. Find employees earning more than the average salary.
select * from employees where 
salary >(select avg(salary)from employees);

-- Q13. Find the highest-paid employee in each department.
select * from employees e
where salary = (
select max(salary)
from employees
where department = e.department);

-- Q14. Find customers who have never placed an order.
select * from customers c 
where not exists (
select 1 
from orders o 
where o.customer_id = c.customer_id); 

-- Q15. Find customers who placed more than 3 orders.

select customer_id,count(*) as total_orders
from orders
group by customer_id
having count(*)>3;

-- Q16. Display customer names with their total order amount.
select c. customer_name,
sum(o.amount)as total_amount
from customers c
join orders o 
on c.customer_id = o.customer_id 
group by c.customer_id ,c.customer_name;

-- Q17. Find products that have never been sold.

select * from products p
where not exists(
select 1
from sales s
where s. product_id = p.product_id);

-- Q18. Find the top 3 products by total sales quantity.

select p.product_name,
sum(s.quantity)as total_quantity
from products p 
join sales s
on p.product_id = s.product_id 
group by p.product_id,p.product_name
order by total_quantity desc limit 3;

-- Q19. Find employees who earn more than their department's average salary.
select * from employees e 
where salary >(
select avg(salary)
from employees
where department = e.department);

-- Q20. Find duplicate employee names.

select emp_name , count(*) as total_count 
from employees
group by emp_name
having count(*) >0;

-- Q21. Find the second-highest salary in each department.

select department,max(salary)as second_highest_salary from employees e 
where salary < (select max(salary)from employees
 where department = e.department)
group by department;

-- Q22. Find the top 3 salaries using DENSE_RANK.
select * from (select emp_name,department ,salary, dense_rank()over(order by salary desc )
as salary_rank from employees )as ranked where salary_rank <= 3;

-- Q23. Calculate running total of orders.

select order_id,order_date,amount,
sum(amount)over(order by order_date,order_id)
as runing_total from orders;

-- Q24. Find previous order amount using LAG.

select order_id,order_date,amount,
lead(amount)over(order by order_date,order_id)as previous_amount from orders;

-- Q25. Find next order amount using LEAD.
select order_id,order_date,amount,lead(amount)over(order by order_date,order_id)as next_amount from orders;

-- Q26. Find monthly revenue.
select year(order_date) AS order_year,
month(order_date)as order_month,
sum(amount)as monthly_revenue from orders
group by year (order_date),
month(order_date)
order by order_year,order_month;

-- Q27. Calculate order cancellation percentage.

SELECT ROUND (
 SUM(CASE WHEN STATUS = 'CANCELLED' THEN 1 ELSE 0 END)
 *100.0/count(*),2)as cancellation_percentage from orders;
 
 -- Q28. Find customers whose spending is above average customer spending.
 with customer_spending as (
 select
 c.customer_id,
 c.customer_name,
 sum(o.amount) as total_spending
 from customers c 
 join orders o 
 on 
 c.customer_id = o.customer_id
 group by c.customer_id, c.customer_name)
 select * from customer_spending where total_spending > (
 select avg(total_spending)
 from customer_spending);
 
 
 
 -- Q29. Find the percentage contribution of each product to total sales.
 
 
-- Q30. Find customers who placed orders on consecutive days.