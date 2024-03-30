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

SELECT 
    product_name, year, price
FROM
    Sales s
        INNER JOIN
    Product p ON s.product_id = p.product_id;

#Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

SELECT 
    v.customer_id, COUNT(v.visit_id) AS count_no_trans
FROM
    Visits v
        LEFT OUTER JOIN
    Transactions t ON v.visit_id = t.visit_id
WHERE
    v.visit_id NOT IN (SELECT 
            visit_id
        FROM
            Transactions)
GROUP BY v.customer_id;

#Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).Return the result table in any order.

SELECT 
    b.id
FROM
    Weather a
        JOIN
    Weather b ON ADDDATE(a.recordDate, 1) = b.recordDate
WHERE
    a.temperature < b.temperature;

#Write a solution to find the average time each machine takes to complete a process.
#The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
#The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places. 
#Return the result table in any order.

SELECT 
    machine_id,
    ROUND(AVG(processing_time), 3) AS processing_time
FROM
    (SELECT 
        machine_id,
            process_id,
            MAX(timestamp) - MIN(timestamp) AS processing_time
    FROM
        Activity
    GROUP BY machine_id , process_id) AS t
GROUP BY machine_id;

#Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
#Return the result table in any order.

SELECT 
    e.name, b.bonus
FROM
    Employee e
        LEFT JOIN
    Bonus b ON e.empId = b.empId
WHERE
    b.bonus < 1000 OR b.bonus IS NULL;

#Write a solution to find the number of times each student attended each exam. Return the result table ordered by student_id and subject_name.

SELECT 
    p.*, IFNULL(ex, 0) AS attended_exams
FROM
    (SELECT 
        *, COUNT(student_id) AS ex
    FROM
        Examinations
    GROUP BY student_id , subject_name) e
        RIGHT JOIN
    (SELECT 
        *
    FROM
        Students s, Subjects sub) AS p ON p.student_id = e.student_id
        AND e.subject_name = p.subject_name
ORDER BY student_id , subject_name;

#Write a solution to find managers with at least five direct reports. Return the result table in any order.

# Write a solution to find managers with at leastÊfive direct reports.
#Return the result table inÊany order.

select e.name from Employee e join (select managerId from Employee  
group by managerId having count(managerId)>=5) as e1 on e.id=e1.managerId

# The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.
#Write a solution to find the confirmation rate of each user.
#Return the result table in any order.

SELECT 
    s.user_id,
    round(ifnull((
        SELECT COUNT(action) 
        FROM Confirmations 
        WHERE action = 'confirmed' AND user_id = s.user_id
        GROUP BY user_id
    ) / COUNT(c.action),0),2) AS confirmation_rate
FROM 
    Signups s
LEFT JOIN 
    Confirmations c ON s.user_id = c.user_id
GROUP BY 
    s.user_id;

#Write a solution to report the movies with an odd-numbered ID and a description that is #notÊ"boring". Return the result table ordered byÊratingÊin descending order.

SELECT 
    id, movie, description, rating
FROM
    Cinema
WHERE
    description != 'boring' AND id % 2
ORDER BY rating DESC;

#Write a solution to find the average selling price for each product.Êaverage_priceÊshould #beÊrounded to 2 decimal places. Return the result table inÊany order.

SELECT 
    p.product_id,
    COALESCE(ROUND(SUM(price * units) / SUM(units), 2),
            0) AS average_price
FROM
    Prices p
        LEFT JOIN
    UnitsSold us ON p.product_id = us.product_id
        AND us.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

#Write an SQL query that reports theÊaverageÊexperience years of all the #employees for each project,Êrounded to 2 digits. Return the result table #inÊany order.

SELECT 
    project_id, ROUND(AVG(experience_years), 2) AS average_years
FROM
    Employee e
        JOIN
    project p ON e.employee_id = p.employee_id
GROUP BY p.project_id;

#Write a solution to find the percentage of the users registered in each #contest rounded toÊtwo decimals. Return the result table ordered #byÊpercentageÊinÊdescending order. 
#In case of a tie, order it byÊcontest_idÊinÊascending order.

SELECT 
    contest_id,
    ROUND((COUNT(r.user_id) / (SELECT 
                    COUNT(user_id)
                FROM
                    Users)) * 100,
            2) AS percentage
FROM
    Users u
        JOIN
    Register r ON u.user_id = r.user_id
GROUP BY r.contest_id
ORDER BY percentage DESC , contest_id ASC;

#Write a solution to find eachÊquery_name, #theÊqualityÊandÊpoor_query_percentage.
#BothÊqualityÊandÊpoor_query_percentageÊshould beÊrounded to 2 decimal #places. Return the result table inÊany order.

select query_name,
round(sum(rating/position)/count(*),2)as quality,
ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS poor_query_percentage
from Queries
where query_name is not null
group by query_name

#Write an SQL query to find for each month and country, the number of #transactions and their total amount, the number of approved transactions and #their total amount. Return the result table inÊany order.

SELECT DATE_FORMAT(trans_date, "%Y-%m") as month, country, count(state) as trans_count, Sum(if (state="approved", 1,0)) as approved_count ,sum(amount) as trans_total_amount,
SUM(Case 
    When state="approved" then amount 
    when state="declined" then 0
END) as approved_total_amount
from Transactions
group by month ,country


#Write a solution to find the percentage of immediate orders in the first #orders of all customers,Êrounded to 2 decimal places.

Select 
    round(avg(order_date = customer_pref_delivery_date)*100, 2) as immediate_percentage
from Delivery
where (customer_id, order_date) in (
  Select customer_id, min(order_date) 
  from Delivery
  group by customer_id
);

# Write aÊsolutionÊto report theÊfractionÊof players that logged in again on #the day after the day they first logged in,Êrounded to 2 decimal places. In #other words, you need to count the number of players that logged in for at #least two consecutive days starting from their first login date, then divide #that number by the total number of players.

SELECT ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) as fraction
FROM Activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY))
IN (SELECT player_id, MIN(event_date) AS first_login FROM ACTIVITY GROUP BY player_id)

#Write a solution to calculateÊthe number of unique subjects each teacher #teaches in the university. Return the result table inÊany order.

select teacher_id,count(Distinct subject_id) as cnt from Teacher
group by teacher_id

#Write a solution to find the daily active user count for a period ofÊ30Êdays #endingÊ2019-07-27Êinclusively. A user was active on someday if they made at #least one activity on that day. Return the result table inÊany order.

select activity_date as day, count(distinct user_id) as active_users from Activity
where activity_date >'2019-06-27' AND activity_date <= '2019-07-27'
group by activity_date


#Write a solution to selectÊtheÊproduct id,Êyear,Êquantity, andÊpriceÊfor #theÊfirst yearÊof every product sold. 
#Return the resulting table inÊany order.

SELECT 
    s.product_id, 
    s.year AS first_year,
    s.quantity,
    s.price
FROM 
    Sales s
JOIN 
    (SELECT product_id, MIN(year) AS min_year FROM Sales GROUP BY product_id) min_year_per_product
ON 
    s.product_id = min_year_per_product.product_id AND s.year = min_year_per_product.min_year;

#Write a solution to find all the classes that haveÊat least five students.
#Return the result table inÊany order.

SELECT 
    class
FROM
    Courses
GROUP BY class
HAVING COUNT(student) >= 5;

#Write a solution that will, for each user, return the number of followers.
#Return the result table ordered byÊuser_idÊin ascending order.

select user_id, count(follower_id) as followers_count from Followers
group by user_id
order by user_id

#AÊsingle numberÊis a number that appeared only once in theÊMyNumbersÊtable.
#Find the largestÊsingle number. If there is noÊsingle number, reportÊnull.

Select MAX(num) as num from MyNumbers
WHERE num IN (SELECT num FROM MyNumbers GROUP BY num HAVING COUNT(num) = 1)

# Write a solution to report the customer ids from theÊCustomerÊtable that #bought all the products in theÊProductÊtable.
#Return the result table inÊany order.

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(DISTINCT product_key) FROM Product);

#Write a solution to report the ids and the names of allÊmanagers, the number #of employees who reportÊdirectlyÊto them, and the average age of the reports #rounded to the nearest integer.
#Return the result table ordered byÊemployee_id.

select  e1.employee_id,e1.name,
        Count(e2.reports_to) as reports_count,
        ROUND(AVG(e2.age)) AS average_age
from Employees e1 
join Employees e2 on e1.employee_id = e2.reports_to
GROUP BY e1.employee_id
ORDER BY e1.employee_id

#Write a solution to report all the employees with their primary department. #For employees who belong to one department, report their only department.
#Return the result table inÊany order.

select employee_id, department_id from Employee
where primary_flag = 'Y' or employee_id in
(select employee_id from Employee 
group by employee_id
having count(department_id) = 1)

#Report for every three line segments whether they can form a triangle.
#Return the result table inÊany order.

select *,
    CASE 
    WHEN x+y>z AND y+z>x AND x+z>y then 'Yes'
    Else 'No'
    END AS triangle
from Triangle

#Find all numbers that appear at least three times consecutively.
#Return the result table inÊany order.

select DISTINCT l1.num as ConsecutiveNums from Logs l1
join Logs l2 on l1.num=l2.num AND l1.id=l2.id-1
join Logs l3 on l1.num=l3.num AND l1.id=l3.id-2
where l1.num=l2.num AND l1.num=l3.num

#Write a solution to find the prices of all products onÊ2019-08-16. Assume #the price of all products before any change isÊ10.
#Return the result table inÊany order.

SELECT product_id, 
new_price AS price 
FROM Products 
WHERE (product_id, change_date) IN 
(SELECT product_id, max(change_date) 
FROM Products 
WHERE change_date <= '2019-08-16' 
GROUP BY product_id)
UNION
SELECT product_id, 10 AS price 
FROM Products 
WHERE product_id NOT IN 
(SELECT product_id 
FROM Products 
WHERE change_date <= '2019-08-16');
















