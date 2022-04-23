-- Se agrega una columna demas NextPredicterOrder_AVG la cual obtiene el conteo de dias de diferencia entre cada fecha y obtiene el promedio de diferencia entre las fechas.

 SELECT CUS.COMPANYNAME, ORD.orderdate, FEC.NextPredicterOrder ,DATEADD(DAY, CT1.PROMEDIO,ORD.orderdate) NextPredicterOrder_AVG  FROM (
 select  AVG(DATEDIFF(DAY,C1.orderdate, C2.ORDERDATE)) PROMEDIO, MAX(C2.orderid) LASTORDER, C1.custid from (
 SELECT orderid, ROW_NUMBER( ) over(PARTITION BY CUSTID order by orderdate) ID, orderdate, custid from sales.Orders ) as c1
 INNER JOIN (
  SELECT orderid, ROW_NUMBER( ) over(PARTITION BY CUSTID order by orderdate) ID, orderdate, custid from sales.Orders ) AS C2

  ON C1.ID = C2.ID -1 AND C1.custid = C2.custid
  GROUP BY  C1.custid
  ) AS CT1
  INNER JOIN [Sales].[Orders] ORD ON ORD.custid=CT1.custid AND ORD.orderid = CT1.LASTORDER
  INNER JOIN [Sales].[Customers]  CUS ON ORD.custid = CUS.custid
  INNER JOIN (  select DATEADD(DAY, datediff(day, MIN(od.orderdate), MAX(od.orderdate))/COUNT(custid),  MAX(od.orderdate)) NextPredicterOrder , OD.custid custId
  from  [Sales].[Orders] od 
  GROUP BY  OD.custid) FEC ON FEC.custid=ORD.custid
  ORDER BY 1 