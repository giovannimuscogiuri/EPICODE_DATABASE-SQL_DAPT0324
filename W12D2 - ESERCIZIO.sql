-- Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce.

SELECT 
	genre.name as nome_genere,
	count(track.name) as quantità_genere
FROM
	genre
join 
	track on genre.GenreId = track.GenreId
group by genre.name
having count(track.name) >= 10
order by nome_genere DESC
;

-- Trovate le tre canzoni più costose.

SELECT *
FROM track
WHERE MediaTypeId <> 3
limit 3;

-- Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.

SELECT distinct
    artist.Name as Artista
FROM
	track
	join album on album.AlbumId = track.AlbumId
    join artist on artist.ArtistId = album.ArtistId
WHERE
 	Milliseconds > 360000
    ;
    
-- Individuate la durata media delle tracce per ogni genere.

select 
genre.name as Genere,
avg(track.Milliseconds) as Durata_Media
from track
join genre on genre.GenreId = track.GenreId
group by genre.name
;

-- Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome.

SELECT DISTINCT
	genre.name as Genere,
    track.name as Nome_Traccia
FROM
    track
    join
    genre on genre.GenreId = track.GenreId
WHERE
	track.Name LIKE '%love%'
;

-- Trovate il costo medio per ogni tipologia di media.

SELECT 
    mediatype.Name,
    AVG(track.UnitPrice) AS costomedio_mediatype
FROM
    track
        JOIN
    mediatype ON mediatype.MediaTypeId = track.MediaTypeId
GROUP BY mediatype.Name;

-- Individuate il genere con più tracce.

SELECT 
    genre.name as Genere
FROM
    track
        JOIN
    genre ON track.GenreId = genre.GenreId
GROUP BY genre.name
order by count(*) desc limit 1
	;

-- Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.

SELECT 
    ARTIST.NAME as Artista,
    COUNT(ALBUM.TITLE) as Numero_Album
FROM
    ALBUM
        JOIN
    ARTIST ON ALBUM.ARTISTID = ARTIST.ARTISTID
GROUP BY ARTIST.NAME
HAVING Numero_Album = (SELECT 
        COUNT(ALBUM.TITLE) AS Numero_Album
    FROM
        ALBUM
            JOIN
        ARTIST ON ALBUM.ARTISTID = ARTIST.ARTISTID
    WHERE
        ARTIST.NAME = 'The Rolling Stones')
;

-- Trovate l’artista con l’album più costoso.

SELECT 
    AR.NAME ARTIST, AL.TITLE ALBUM
FROM
    TRACK T
        LEFT JOIN
    ALBUM AL ON T.ALBUMID = AL.ALBUMID
        LEFT JOIN
    ARTIST AR ON AL.ARTISTID = AR.ARTISTID
GROUP BY AR.NAME , AL.TITLE
HAVING SUM(T.UNITPRICE) = (SELECT 
        MAX(ALBUM_PRICE)
    FROM
        (SELECT 
            AR.NAME ARTIST,
                AL.TITLE ALBUM,
                SUM(T.UNITPRICE) AS ALBUM_PRICE
        FROM
            TRACK T
        LEFT JOIN ALBUM AL ON T.ALBUMID = AL.ALBUMID
        LEFT JOIN ARTIST AR ON AL.ARTISTID = AR.ARTISTID
        GROUP BY AR.NAME , AL.TITLE) A);


