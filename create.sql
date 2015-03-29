-- Easier to see what's going on if you type:
-- .echo on;
-- Prior to doing:
-- .read create.sql;

DROP TABLE cust;
CREATE TABLE cust (
    order_num INTEGER PRIMARY KEY,
    cust_num INTEGER,
    name TEXT,
    order_cost INTEGER
);

INSERT INTO cust VALUES(0, 1, "Sushi", 800);
INSERT INTO cust VALUES(1, 0, "Chicken", 1000);
INSERT INTO cust VALUES(2, 0, "Chocolate Ouyu", 550);
INSERT INTO cust VALUES(3, 1, "French Fries", 1250);
INSERT INTO cust VALUES(4, 1, "Eggs", 300);
INSERT INTO cust VALUES(5, 2, "Half Sandwich", 50);
INSERT INTO cust VALUES(6, 0, "Ham", 2000);

select * from cust;

select cust_num, count(*) from cust;
-- The 0 comes incidentally because it happens to be the cust_num of the final entry
-- Not a particularly useful query, as it's identical to `select count(*) from cust;`
-- 0|7

select cust_num, count(*) from cust group by cust_num;
-- Now we're getting somewhere: shows how many rows (orders) there are for each customer
-- 0|3
-- 1|3
-- 2|1

select cust_num, count(*) as orderCt from cust group by cust_num order by orderCt;
-- Saves the variable of the count(*) so that we can order by it
-- 2|1
-- 0|3
-- 1|3

select cust_num, sum(order_cost) as orderTotal from cust group by cust_num order by orderTotal DESC;
-- Get the total spent by each customer and order it, descending
-- 0|3550
-- 1|2350
-- 2|50

-- Analytic functions / window functions weren't added to sqlite3 until v3.8.3, which is why
-- I haven't been able to get these to work :(
-- TODO: Get newer version

-- select cust_num, (sum(order_cost) over (partition by cust_num)) as s from cust;
-- select cust_num,
--       sum(order_cost) over (partition by cust_num order by cust_num
--           rows between unbounded preceding and current row) as s,
--       order_cost
--    from cust;
