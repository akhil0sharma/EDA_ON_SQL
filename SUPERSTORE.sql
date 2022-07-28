USE BOB;
SELECT * FROM Orders$;
SELECT * FROM People$;
SELECT * FROM Returns$;

select count(*)
from Orders$;

select count(*)
from People$;

select count(*)
from Returns$;

--CUSTOMER WHO PLACED ORDER MORE THAN ONE 
SELECT [Order ID],[Customer Name] ,COUNT(*) FROM Orders$
GROUP BY [Order ID],[Customer Name]
HAVING COUNT(*)>1;

SELECT *  FROM Orders$
where [Order ID] = 'AE-2014-3830';
--[Order ID] CAN NOT BE PRIMARY KEY ALONE AS IT IS NOT UNIQUE


SELECT * FROM Orders$ WHERE [Ship Date] < [Order Date];
--CHECKING WEATHER SHIP DATE IS LESS THAN ORDER DATE OR NOT


SELECT DISTINCT[Ship Mode] from Orders$;

--NUMBER OF DAYS FOR COMPLETING THE ORDER
SELECT DATEDIFF(DAY,[ORDER DATE],[SHIP DATE]) AS NUM_DAYS ,* 
FROM Orders$;


SELECT DATEDIFF(DAY,[ORDER DATE],[SHIP DATE]) AS NUM_DAYS ,* 
FROM Orders$
WHERE [Ship Mode]='FIRST CLASS';

--MAXIMUM AND MINIMUM DAYS FOR COMPLETING THE ORDER
SELECT MIN(A.NUM_DAYS) AS MIN_DAYS,MAX(A.NUM_DAYS) AS MAX_DAYS
FROM(
SELECT DATEDIFF(DAY,[ORDER DATE],[SHIP DATE]) AS NUM_DAYS ,* 
FROM Orders$
WHERE [Ship Mode]='FIRST CLASS') A;


--ORDERS PLACED BY EACH CUSTOMER
SELECT [CUSTOMER ID],[Customer Name],[ORDER ID],[Order DATE] ,COUNT(*) AS NUM_OF_ITEMS FROM Orders$
GROUP BY [CUSTOMER ID],[Customer Name],[ORDER ID],[Order DATE]
ORDER BY [CUSTOMER ID];


--ORDER DETAILS FOR A PARTICULAR ORDER ID
SELECT * FROM Orders$
WHERE [Order ID] = 'CA-2011-128055';

--CUSTOMER WHO PLACED MAXIMUM ORDERS
SELECT TOP 1 [CUSTOMER ID],[CUSTOMER NAME],COUNT([Order ID]) AS NUM_OF_ORDERS FROM Orders$
GROUP BY [CUSTOMER ID],[CUSTOMER NAME] 
ORDER BY COUNT([Order ID]) DESC;


--Category wise total order placed
SELECT CATEGORY,COUNT([ORDER ID]) as total_orders FROM Orders$
group by CATEGORY
order by COUNT([ORDER ID]) desc;

--Sub-Category wise total order placed
select   [Sub-Category], count([order id]) from Orders$
group by [Sub-Category]
order by count([order id]) desc;

--maximum orders placed for binders
select Top 1  [Sub-Category], count([order id]) from Orders$
group by [Sub-Category]
order by count([order id]) desc;


--
select top 3 [country], count([order id])  from Orders$
group by country
order by count([order id]) desc;


--product wise sales
select [Product name], max(sales) from Orders$
group by[Product name]
order by max(sales) desc;

--CISCO TELEPRESENCE GENERATED MAXIMUM SALES
select TOP 1 [Product name], sales from Orders$
group by[Product name],SALES
order by sales desc;


--CANON IMAGE COPIER PRODUCED MAXIMUM PROFIT
SELECT TOP 1 [PRODUCT NAME] ,PROFIT FROM Orders$
GROUP BY [PRODUCT NAME],Profit
ORDER BY PROFIT DESC;
--OR USING SUB QUERY
SELECT [Product ID], [PRODUCT NAME] ,PROFIT FROM Orders$ 
WHERE Profit = (SELECT MAX(PROFIT) FROM Orders$);

--PLANTRONICS HAS THE MAXIMUM SHIPPING COST
SELECT [Product Name],[Shipping Cost] FROM Orders$ WHERE
[Shipping Cost]  =(SELECT MAX([Shipping Cost]) AS MAX_COST  FROM Orders$);

SELECT * FROM Orders$;
SELECT * FROM People$;
SELECT * FROM Returns$;


--CUSTOMERS WHO HAD RETURNED THE ORDERS
SELECT O.[Order ID] ,O.[Customer ID], O.[Customer Name],R.RETURNED FROM Orders$ O
JOIN 
Returns$ R
ON O.[Order ID]=R.[Order ID];

SELECT O.REGION,P.Person FROM Orders$ O
JOIN People$ P
ON O.REGION=P.REGION;


