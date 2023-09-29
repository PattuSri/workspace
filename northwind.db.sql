SELECT * FROM
(SELECT PRODUCTID, PRODUCTNAME, CUSTOMERID,TOTAL_QUANTITY ,
DENSE_RANK() OVER (PARTITION BY PRODUCTID ORDER BY TOTAL_QUANTITY DESC) AS RANK FROM 
(select *,sum(quantity)
 as total_quantity from
(SELECT producTs.productid,products.productname, customers.customerid,  `order details`.quantity  
 from products inner join `order details` on products.productid=`order details`.productid 
 inner join orders on `order details`.orderid=orders.orderid 
 inner join customers on orders.customerid=customers.customerid ORDER BY CUSTOMERS.CUSTOMERID ) as prod_cus GROUP BY PRODUCTID,CUSTOMERID
 )	 ) WHERE RANK=1