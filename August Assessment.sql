--Question 1
--1.1. 
SELECT MAX("CUSTOMER#") AS MAX_CUST_NO FROM customers;
CREATE SEQUENCE cust_seq
START WITH 1021
INCREMENT BY 1
NOCACHE
NOCYCLE;


--1.2.
INSERT INTO customers ("CUSTOMER#", LastName, FirstName, Zip)
VALUES (cust_seq.NEXTVAL, 'Shoulders', 'Frank', 23567);


--Question 2
--2.1.
CREATE ROLE sales_person;
CREATE USER john IDENTIFIED BY temporary_password
PASSWORD EXPIRE;
--2.2.
GRANT sales_person TO john;
GRANT ALL ON CUSTOMERS TO john WITH GRANT OPTION;
ALTER USER john DEFAULT ROLE sales_person;

--Question 3
--3.1.
SELECT Customer#, LastName, State
FROM customers
WHERE State IN ('GA', 'NJ')
ORDER BY LastName ASC;
3.2.
SELECT LastName, FirstName
FROM Authors
WHERE LastName LIKE '%in%'
ORDER BY LastName, FirstName;

--Question 4
--4.1.
SELECT DISTINCT c.Customer#, c.LastName, c.FirstName, c.state
FROM Customers c
JOIN Orders o ON c.Customer# = o.Customer#
JOIN OrderItems oi ON o.Order# = oi.Order#
JOIN Books b ON oi.ISBN = b.ISBN
WHERE c.State = 'FL' AND b.Category = 'COMPUTER';

-- 4.2 
SELECT b.title

FROM customers c JOIN orders USING (customer#)

 JOIN orderitems USING (order#)

 JOIN books b USING (isbn)

 WHERE c.firstname = 'JAKE'

  AND c.lastname = 'LUCAS';


--Question 5
--5.1.
SELECT b.Title AS Book_Title,
TO_CHAR((oi.Quantity * (b.retail - b.Cost)), '$999,999.99') AS Profit
FROM OrderItems oi
JOIN Books b USING (ISBN)
WHERE oi.Order# = 1002;
5.2.
SELECT Title AS Book_Title,
TRUNC(((books.retail - Cost) / Cost) * 100) AS Markup_Percentage
FROM Books;


--Question 6
--6.1.
SELECT c.Customer#, c.LastName, c.FirstName, c.state
FROM Customers c
JOIN Orders o ON c.Customer# = o.Customer#
JOIN OrderItems oi ON o.Order# = oi.Order#
WHERE c.State IN ('GA', 'FL')
GROUP BY c.Customer#, c.LastName, c.FirstName, c.state
HAVING SUM(oi.PaidEach * oi.Quantity) > 80;


--Question 7
--7.1.
WITH CheapestPrice AS (
SELECT MIN(Retail) AS MinRetail
FROM Books
)
-- Subquery to find the ISBN of the least expensive book
, CheapestBook AS (
SELECT ISBN
FROM Books
WHERE Retail = (SELECT MinRetail FROM CheapestPrice)
)
-- Main query to find customers who ordered the least expensive book
SELECT DISTINCT c.Customer#, c.LastName, c.FirstName
FROM Customers c
JOIN Orders o ON c.Customer# = o.Customer#
JOIN OrderItems oi ON o.Order# = oi.Order#
WHERE oi.ISBN IN (SELECT ISBN FROM CheapestBook);
--7.2.
WITH BooksByJamesAustin AS (
SELECT DISTINCT
b.ISBN
FROM BookAuthor b
JOIN Author a ON b.AuthorID = a.AuthorID
WHERE a.fname = 'JAMES' AND a.lname = 'AUSTIN'
)

-- Step 2: Count distinct customers who ordered these books
SELECT COUNT(DISTINCT o.Customer#) AS NumberOfCustomers
FROM Orders o
JOIN OrderItems oi ON o.Order# = oi.Order#
JOIN BooksByJamesAustin bj ON oi.ISBN = bj.ISBN;

--Question 8
--8.1 
CREATE VIEW contact

 AS SELECT contact, phone

  FROM publisher;

 
--8.2 
CREATE OR REPLACE VIEW contact

 AS SELECT contact, phone

  FROM publisher

 WITH READ ONLY;


--Question 9
--9.1
CREATE TABLE category (catcode VARCHAR2(3), catdesc VARCHAR2(11) );

--9.2 
Alter table CATEGORY

Add CONSTRAINT category_code_pk PRIMARY KEY (catcode)

--9.3 
Alter table CATEGORY

Modify (CATDESC Not Null)

--9.4 
Alter table CATEGORY

Modify (CATDESC varchar2(13))

--9.5 
INSERT INTO category

VALUES ('BUS', 'BUSINESS');

 INSERT INTO category

VALUES ('CHN', 'CHILDREN');

INSERT INTO category

VALUES ('COK', 'COOKING');

INSERT INTO category

VALUES ('COM', 'COMPUTER');        

--9.6 
ALTER TABLE books

ADD (catcode VARCHAR2(3),

CONSTRAINT books_catcode_fk FOREIGN KEY (catcode)

REFERENCES category(catcode));
