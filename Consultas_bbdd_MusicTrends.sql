USE musictrends;
-- ¿Cuál es el artista con más canciones entre 2019 y 2023?
SELECT nombre_artista, COUNT(id_track) AS número_canciones
FROM spotify
WHERE nombre_artista <> 'Various Artists'
GROUP BY nombre_artista
ORDER BY COUNT(id_track) DESC LIMIT 1;
-- ¿Qué género es el mejor valorado?
SELECT SUM(playcount) AS total_reproducciones, género_musical
FROM spotify
LEFT JOIN lastfm USING (id_artista)
GROUP BY género_musical
ORDER BY total_reproducciones DESC LIMIT 1; 
-- los años seleccionados ordenados por oyentes
SELECT año_lanzamiento, SUM(listeners) AS número_oyentes
FROM spotify
LEFT JOIN lastfm USING (id_artista)
GROUP BY año_lanzamiento
ORDER BY SUM(listeners) DESC;
-- ¿Cuál es la canción mejor valorada?
SELECT nombre_canción, listeners AS oyentes
FROM spotify
LEFT JOIN lastfm USING (id_artista)
ORDER BY playcount DESC LIMIT 1;
-- ¿Cuál es el artista con más valoración?
SELECT nombre_artista, playcount
FROM lastfm
ORDER BY playcount DESC LIMIT 1;
-- ¿Cuál es la canción más valorada de los años pares de mi selección?
SELECT nombre_canción, año_lanzamiento, género_musical -- revisar el género_musical
FROM (SELECT nombre_canción, año_lanzamiento, playcount
				  FROM spotify
				  LEFT JOIN lastfm USING (id_artista)
				  WHERE año_lanzamiento = 2020
				  ORDER BY playcount DESC
				  LIMIT 1
				) AS top2020
UNION
SELECT nombre_canción, año_lanzamiento, género_musical-- revisar el género_musical
FROM (SELECT nombre_canción, año_lanzamiento, playcount
				  FROM spotify
				  LEFT JOIN lastfm USING (id_artista)
				  WHERE año_lanzamiento = 2022
				  ORDER BY playcount DESC
				  LIMIT 1
				) AS top2022;
-- ¿Qué género tiene más artistas?
SELECT COUNT(id_artista), género_musical
FROM spotify
GROUP BY género_musical
LIMIT 1;
-- ¿Cuál es el artista que más veces se repite en el listado de canciones extraído?
SELECT nombre_artista, COUNT(id_artista) AS frecuencia
FROM spotify
GROUP BY nombre_artista
ORDER BY frecuencia DESC
LIMIT 20;
-- Artistas con género rock cuyo género esté incluído en el propio título de la canción
SELECT nombre_artista, nombre_canción
FROM spotify
WHERE nombre_canción LIKE 'rock%' OR '%rock' or '%rock%';
-- Búsqueda/descubrimiento de grupos más underground(menos de 200 listeners)
SELECT nombre_artista, listeners, playcount
FROM lastfm
WHERE listeners < 200
ORDER BY listeners DESC
LIMIT 10;
-- Descubrimiento de artistas que te gusten en función de un artista similar determinado
SELECT nombre_artista, similar
FROM lastfm
WHERE similar LIKE "%Armin%";
-- Descubrir artistas de tu país/de un país dada la bio
SELECT nombre_artista, bio
FROM lastfm
WHERE bio LIKE "%Sweden%" or bio LIKE "%Swedish%";
-- Descubrir canciones de temática romántica
SELECT DISTINCT nombre_artista, nombre_canción
FROM spotify
WHERE nombre_canción LIKE '%love%' LIMIT 10;
-- Cuáles son los artistas que aparecen con "Datos incompletos o error" al sacar los datos de LastFM
SELECT nombre_artista
FROM spotify
WHERE id_artista IS NULL AND nombre_artista <> "Various artists";





