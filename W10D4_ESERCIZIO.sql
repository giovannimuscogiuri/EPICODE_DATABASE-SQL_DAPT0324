-- 1. Esponi l’anagrafica dei prodotti indicando
-- per ciascun prodotto anche la sua sottocategoria

select
	dimproduct.EnglishProductName,
	dimproductsubcategory.EnglishProductSubcategoryName
from
	dimproduct
inner join
	dimproductsubcategory 
	on dimproduct.ProductSubcategoryKey = dimproductsubcategory.ProductSubcategoryKey
;

-- Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria
-- e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).

select
	dimproductcategory.EnglishProductCategoryName,
	dimproductsubcategory.EnglishProductSubcategoryName,
	dimproduct.EnglishProductName
from
	dimproduct
inner join
	dimproductsubcategory
inner join
	dimproductcategory on dimproduct.ProductSubcategoryKey = dimproductsubcategory.ProductSubcategoryKey = dimproductcategory.ProductCategoryKey
;

-- Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales)

select distinct
	dimproduct.ProductKey,
	dimproduct.EnglishProductName,
	-- factresellersales.SalesOrderNumber,
	-- factresellersales.SalesOrderLineNumber,
	dimproduct.FinishedGoodsFlag
from
	dimproduct
inner join
	factresellersales on dimproduct.ProductKey = factresellersales.ProductKey
where
	FinishedGoodsFlag = 1
;

-- Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti
-- cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1)

select
	*
from
	dimproduct
where
	dimproduct.ProductKey not in (select ProductKey from factresellersales)
    and FinishedGoodsFlag = 1
;

-- Esponi l’elenco delle transazioni di vendita (FactResellerSales)
-- indicando anche il nome del prodotto venduto (DimProduct)

select
	factresellersales.SalesOrderNumber,
    factresellersales.SalesOrderLineNumber,
    factresellersales.OrderDate,
    factresellersales.UnitPrice,
    factresellersales.OrderQuantity,
    factresellersales.TotalProductCost,
    dimproduct.EnglishProductName
from
	factresellersales
    inner join
    dimproduct on dimproduct.productkey = factresellersales.productkey
;

-- Esponi l’elenco delle transazioni di vendita indicando la categoria
-- di appartenenza di ciascun prodotto venduto.


select 
	dimproductcategory.EnglishProductCategoryName,
    dimproductsubcategory.EnglishProductSubcategoryName,
    dimproduct.EnglishProductName,
    dimproduct.ProductKey,
    SalesOrderNumber,
    factresellersales.SalesOrderLineNumber,
    factresellersales.UnitPrice,
    factresellersales.OrderDate,
    factresellersales.OrderQuantity,
    dimproduct.ListPrice,
    factresellersales.TotalProductCost
from
	factresellersales
	join dimproduct
    join dimproductsubcategory
    join dimproductcategory
    where factresellersales.ProductKey = dimproduct.ProductKey
    and dimproduct.ProductSubcategoryKey = dimproductsubcategory.ProductSubcategoryKey
    and dimproductsubcategory.ProductCategoryKey = dimproductcategory.ProductCategoryKey
;

-- Esplora la tabella DimReseller

select *
from dimreseller
;
-- Esponi in output l’elenco dei reseller indicando, per ciascun reseller,
-- anche la sua area geografica

select
	dimreseller.resellername,
    dimreseller.resellerkey,
    dimgeography.City,
    dimgeography.StateProvinceName,
    dimgeography.EnglishCountryRegionName,
    dimsalesterritory.SalesTerritoryCountry,
    dimsalesterritory.SalesTerritoryRegion
from
	dimreseller
	inner join
	dimgeography on dimreseller.GeographyKey = dimgeography.GeographyKey
    inner join
    dimsalesterritory on dimgeography.SalesTerritoryKey = dimsalesterritory.SalesTerritoryKey
;

-- Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi:
-- SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
-- Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto,
-- il nome del reseller e l’area geografica.

SELECT s.SalesOrderNumber, s.SalesOrderLineNumber, s.OrderDate, s.UnitPrice, s.OrderQuantity, s.TotalProductCost,
       p.EnglishProductName AS ProductName, pc.EnglishProductCategoryName AS CategoryName, r.ResellerName, g.City, g.StateProvinceName, g.EnglishCountryRegionName
FROM factresellersales s
	INNER JOIN dimproduct p ON s.ProductKey = p.ProductKey
	INNER JOIN dimproductsubcategory ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
	INNER JOIN dimproductcategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
	INNER JOIN dimreseller r ON s.ResellerKey = r.ResellerKey
	INNER JOIN dimgeography g ON r.GeographyKey = g.GeographyKey
;

