/*
1.Scrivi una query per verificare che il campo ProductKey 
nella tabella DimProduct sia una chiave primaria. 
Quali considerazioni/ragionamenti è necessario che tu faccia?
*/
select count(productkey) as numero_righe,
		count(distinct Productkey) as conteggio_distinct 
from dimproduct;

/*
2.Scrivi una query per verificare che la combinazione 
dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK;
*/

Select 
	count(*) as TotaleCount,
    count(distinct SalesOrderNumber, SalesOrderLineNumber) as UnicoCount
From
    factresellersales
;
    
/*
3.Conta il numero transazioni (SalesOrderLineNumber) 
realizzate ogni giorno a partire dal 1 Gennaio 2020;
*/

Select 
    OrderDate as data_ordini,
    count(Distinct Salesordernumber) as numero_ordini
from factresellersales
where OrderDate >= "2020.01.01."
Group by OrderDate 
;
/*
4.Calcola il fatturato totale (FactResellerSales.SalesAmount), 
la quantità totale venduta (FactResellerSales.OrderQuantity) 
e il prezzo medio di vendita (FactResellerSales.UnitPrice) 
per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, 
la quantità totale venduta e il prezzo medio di vendita.
I campi in output devono essere parlanti!
 */
 
 Select 
	 B.EnglishProductName,
	 sum(A.SalesAmount) as Fatturato_Totale,
	 sum(A.Orderquantity) as Quantita_totale,
	 AVG(A.Unitprice) as Prezzo_medio
from 
  factresellersales as A
	join 
 dimproduct B on A.Productkey= B.Productkey
where 
	A.Orderdate >= '2020.01.01'
Group by B.EnglishProductName
;

    /*
    5.Calcola il fatturato totale (FactResellerSales.SalesAmount) 
    e la quantità totale venduta (FactResellerSales.OrderQuantity) 
    per Categoria prodotto (DimProductCategory). 
    Il result set deve esporre pertanto il nome della categoria prodotto, 
    il fatturato totale e la quantità totale venduta. 
    I campi in output devono essere parlanti!
    */
    
Select 
    A.Englishproductcategoryname as Categoria,
    sum(D.Salesamount) as Fatturato,
    sum(D.Orderquantity) as Quantita_totale,
    avg(D.Unitprice) as Prezzo_Medio
from
    dimproductcategory as A
	left join
    dimproductsubcategory as B on A.ProductCategoryKey= B.ProductCategoryKey
	left join
    dimproduct as C on B.ProductSubcategoryKey= C.ProductSubcategoryKey
    left join
    factresellersales as D on C.ProductKey= D.ProductKey
group by A.EnglishProductCategoryName
; 
    /*
    6.Calcola il fatturato totale per area città (DimGeography.City) 
    realizzato a partire dal 1 Gennaio 2020. 
    Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.
    */
Select
    dimgeography.City,
    sum(factresellersales.Salesamount) as Totale_Fatturato
from
    factresellersales
    join
    dimreseller on factresellersales.ResellerKey= dimreseller.resellerkey
    join 
    dimgeography on dimreseller.GeographyKey= dimgeography.GeographyKey
where
    factresellersales.orderdate >= '2020.01.01'
group by dimgeography.city
;
    