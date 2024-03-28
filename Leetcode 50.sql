#Write a solution to find the ids of products that are both low fat and recyclable. Return the result table in any order.

Select product_id 
from Products
where low_fats = "Y" 
AND
recyclable = "Y";

#Find the names of the customer that are not referred by the customer with id = 2. Return the result table in any order.

Select name 
from Customer
where referee_id != "2" 
OR referee_id is NULL;

#A country is big if: it has an area of at least three million (i.e., 3000000 km2), or it has a population of at least twenty-five million (i.e., 25000000).
#Write a solution to find the name, population, and area of the big countries. Return the result table in any order.

Select name, population, area from World
where population >= 25000000 
OR
area >= 3000000;

#Write a solution to find all the authors that viewed at least one of their own articles. Return the result table sorted by id in ascending order.

Select DISTINCT(author_id) as id 
From Views
Where author_id = viewer_id
Order by id ASC;

#Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
#Return the result table in any order.

select tweet_id from Tweets
where LENGTH(content)>15;

#Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null. Return the result table in any order.

Select unique_id, name from Employees e
LEFT JOIN EmployeeUNI eu on e.id=eu.id;

#Write a solution to report the product_name, year, and price for each sale_id in the Sales table. Return the resulting table in any order.

select product_name,year,price  from Sales s
INNER JOIN Product p ON s.product_id = p.product_id;

#Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Select v.customer_id, COUNT(v.visit_id) as count_no_trans 
from Visits v
LEFT OUTER JOIN Transactions t ON v.visit_id = t.visit_id
where v.visit_id NOT IN (select visit_id from Transactions)
GROUP BY v.customer_id;

#Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).Return the result table in any order.

select b.id from Weather a join Weather b 
on adddate(a.recordDate ,1) = b.recordDate 
where a.temperature < b.temperature;

#Write a solution to find the average time each machine takes to complete a process.
#The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
#The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places. 
#Return the result table in any order.

select machine_id, round(avg(processing_time),3) as processing_time
from (select machine_id, process_id,  MAX(timestamp)-MIN(timestamp) as processing_time   from Activity
group by machine_id, process_id) as t group by  machine_id;

#Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
#Return the result table in any order.

select e.name, b.bonus from Employee e
left join Bonus b on e.empId = b.empId
where b.bonus<1000 OR b.bonus is null;

#Write a solution to find the number of times each student attended each exam. Return the result table ordered by student_id and subject_name.

select p.*,ifnull(ex,0) as  attended_exams 
from 
(select *, count(student_id) as ex from Examinations  group by student_id, subject_name ) e
right join 
(select * from Students s, Subjects sub)  as p
on p.student_id  = e.student_id AND e.subject_name=p.subject_name
order by student_id , subject_name;

#Write a solution to find managers with at least five direct reports. Return the result table in any order.







