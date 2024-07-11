
-- Esplora la tabella del prodotti

	SELECT 
    *
FROM
    AdventureWorksDW.dimproduct;


-- Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey,
-- ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag. 
-- Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno

SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName AS 'Nome_Prodotto',
    Color AS 'Colore',
    StandardCost AS 'Costo',
    FinishedGoodsFlag AS 'Terminato'
FROM
    AdventureWorksDW.dimproduct
    
    -- Partendo dalla query scritta nel passaggio precedente, esponi in output i soli
    -- prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1

WHERE
    FinishedGoodsFlag = 1;
    
-- Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello 
-- (ProductAlternateKey) comincia con FR oppure BK. Il result set deve contenere il codice 
-- prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost)
-- e il prezzo di listino (ListPrice).

SELECT
	ProductKey,
	ProductAlternateKey,
    Color,
    EnglishProductName,
    StandardCost,
    ListPrice,
-- Arricchisci il risultato della query scritta nel passaggio precedente del Markup 
-- applicato dall’azienda (ListPrice - StandardCost)
    ListPrice - StandardCost
    
FROM
	AdventureWorksDW.dimproduct

WHERE
	ProductAlternateKey LIKE 'FR%' or 
    ProductAlternateKey LIKE 'BK%';
    
-- Scrivi un’altra query al fine di esporre l’elenco dei prodotti finiti il cui prezzo
--  di listino è compreso tra 1000 e 2000

SELECT 
    *
FROM
    AdventureWorksDW.dimproduct
WHERE
	ListPrice BETWEEN 1000 AND 2000;

-- Esplora la tabella degli impiegati aziendali (DimEmployee)

SELECT 
    *
FROM
    AdventureWorksDW.dimemployee;
    
-- Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti.
-- Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.
    
SELECT 
    *
FROM
    AdventureWorksDW.dimemployee
WHERE
	SalespersonFlag = 1;
    
-- Interroga la tabella delle vendite (FactResellerSales).
-- Esponi in output l’elenco delle transazioni registrate a partire dal 1 gennaio 2020
-- dei soli codici prodotto: 597, 598, 477, 214. 
-- Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).

SELECT 
    *,
    SalesAmount - TotalProductCost AS 'Profitto'
FROM
    AdventureWorksDW.factresellersales
WHERE
	OrderDate > '2020-01-01' and
    (ProductKey like 597 or
    ProductKey like 598 or
    ProductKey like 477 or
    ProductKey like 214);
