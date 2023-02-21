USE adventure_works;

/*1.	Create the Salespeople */

Create table Salespeople(
snum int,
sname varchar(255),
city varchar(255),
comm float
);

insert into Salespeople(snum,sname,city,comm) values(1001,'Peel','London',0.12),(1002,'Serres','San Jose',0.13),(1003,"Axelrod","New York",0.10),(1004,"Motika","London",0.11),(1007,"Rafkin","Barcelona",0.15);
																				
Select * from   Salespeople

/*2. Create the Cust Table */

Create table Cust(
cnum int,
cname varchar(255),
city varchar(255),
rating int,
snum int
);

insert into Cust (cnum,cname,city,rating,snum) Values(2001,"Hoffman","London",100,1001),(2002,"Giovanne","Rome",200,1003),(2003,"Liu","San Jose",300,1002),
                                                                                  (2004,"Grass","Berlin",100,1002),(2006,"Clemens","London",300,1007),(2007,"Pereira","Rome",100,1004),(2008,"James","London",200,1007);

Select * from Cust;

/* 3.	Create orders table */

Create table orders(
onum int,
amt float,
odate Date,
cnum int,
snum int
);

insert into orders(onum,amt,odate,cnum,snum) Values(3001,18.69,"1994-10-03",2008,1007),(3002,1900.10,"1994-10-03",2007,1004),(3003,767.19,"1994-10-03",2001,1001),(3005,5160.45,"1994-10-03",2003,1002),(3006,1098.16,"1994-10-04",2008,1007),
                                                                                   (3007,75.75,"1994-10-05",2004,1002),(3008,4723.00,"1994-10-05",2006,1001),(3009,1713.23,"1994-10-04",2002,1003),(3010,1309.95,"1994-10-06",2004,1002),(3011,9891.88,"1994-10-06",2006,1001);

Select * from orders;

/*4.	Write a query to match the salespeople to the customers according to the city they are living*/

Select * from Salespeople
WHERE city IN(Select city from Cust);

/* 5.	Write a query to select the names of customers and the salespersons who are providing service to them*/

Select s.sname,c.cname
from Salespeople s,Cust c
Where s.snum=c.snum;

/* 6.	Write a query to find out all orders by customers not located in the same cities as that of their salespeople*/

Select o.onum, o.cnum, o.snum,c.cname
From Salespeople s, Cust c, orders o
Where c.city <> s.city
AND o.cnum = c.cnum
AND o.snum=s.snum
Order By o.onum;

/*7.	Write a query that lists each order number followed by name of customer who made that order*/

Select o.onum, c.cname
from orders o, Cust c
Where o.snum=c.snum
Group By o.onum
Order By o.onum;

/*8.	Write a query that finds all pairs of customers having the same rating*/

Select a.cname, b.cname,a.rating
from cust a, cust b
where a.rating = b.rating AND a.cnum != b.cnum

/*9.	Write a query to find out all pairs of customers served by a single salesperson*/

Select * from Cust
Where snum IN (Select DISTINCT snum From Cust a
                          Where EXISTS(Select * From Cust b
                                                   Where b.snum=a.snum AND b.cname <> a.cname)); 
																			
/*10.Write a query that produces all pairs of salespeople who are living in same city*/	

Select a.sname,b.sname,a.city
From Salespeople a, Salespeople b
Where a.city=b.city AND a.sname<>b.sname;

/*11.Write a Query to find all orders credited to the same salesperson who services Customer 2008*/

Select o.cnum,o.onum,o.amt,o.odate,s.sname
From orders o,Salespeople s
Where s.snum=o.snum AND cnum=2008
Order By onum;

/* 12.	Write a Query to find out all orders that are greater than the average for Oct 4th */

Select onum,amt,odate
From orders
Where amt> (Select avg(amt) from orders where odate="1994-10-04");

/* 13.	Write a Query to find all orders attributed to salespeople in London. */ 

Select o.onum,o.amt,o.odate, s.sname,s.city
From orders o, Salespeople s
Where o.snum=s.snum AND city="London";

/* 14.	Write a query to find all the customers whose cnum is 1000 above the snum of Serres.  */

Select cnum, cname
From Cust
Where cnum > ( select snum+1000 from Salespeople where sname = 'Serres');

/* 15.	Write a query to count customers with ratings above San Jose’s average rating. */

Select Count(*) AS customer_count  From Cust
Where rating> (Select avg(rating) from Cust Where city="San Jose");

/* 16.	Write a query to show each salesperson with multiple customers. */

Select snum, sname From salespeople
Where snum IN ( Select snum From Cust 
						Group by snum
                        Having count(*) > 1);


                                                            




 								
												   
                          
            






                                                                            

