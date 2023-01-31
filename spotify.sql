SELECT * FROM Spotifydata;

-- What is the average danceability by artist and track? 

SELECT
    AVG(danceability)
FROM Spotifydata;

-- Who are the top 10 artists based on popularity? 

SELECT 
    DISTINCT artist_name,
    popularity
FROM Spotifydata
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- What artist released the longest song? 

SELECT
    artist_name
FROM Spotifydata
HAVING 
    duration_ms = (SELECT MAX(duration_ms) FROM Spotifydata)
LIMIT 1;

-- What's the average danceability for the 10 most popular songs?

SELECT 
    ROUND(AVG(danceability), 2) AS 'Average Danceability'
FROM Spotifydata
WHERE track_name IN (
    SELECT 
        track_name
    FROM Spotifydata
    ORDER BY popularity DESC
    LIMIT 10);

/*
Calculate the average popularity for the artists in the Spotify data table. 
Then, for every artist with an average popularity of 90 or above, show their name, 
their average popularity, and label them as a “Top Star”.
*/

WITH popTable AS (
    SELECT
        artist_name, 
        ROUND(AVG(popularity), 2) AS 'popularity'
    FROM Spotifydata
    GROUP BY artist_name
    ORDER BY popularity
    )
SELECT 
    artist_name AS 'Top Star',
    popularity
FROM popTable
WHERE
    popularity >= 90
ORDER BY 2 DESC;
