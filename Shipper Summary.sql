--select * from Sales.Shippers
--select * from Sales.Orders
--select * from Sales.OrderDetails

select companyname, sum(os.freight) TotalFreight, sum(PRICE) TotalCostShipped, sum(cantidad) TotalItemsShipped from Sales.Shippers sh 
INNER JOIN Sales.Orders os ON sh.shipperid= os.shipperid
LEFT JOIN (SELECT orderid, SUM(UNITPRICE* qty)  PRICE, Sum(qty) cantidad FROM Sales.OrderDetails
GROUP BY ORDERID) AS od on od.orderid = os.orderid
group by companyname
order by 1 


--By Jose Luis Avila