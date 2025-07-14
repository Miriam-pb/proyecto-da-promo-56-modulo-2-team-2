# proyecto-da-promo-56-modulo-2-team-2
Repositorio para el desarrollo del proyecto de MusicStream del módulo 2

Este proyecto simula el funcionamiento de una empresa especializada en el análisis de tendencias musicales. Nuestro objetivo fue integrar datos de distintas APIs, limpiarlos, almacenarlos en una base de datos y analizarlos mediante consultas SQL para obtener información relevante sobre el mundo de la música para nuestro cliente.

## 📊 Objetivos

- Extraer datos musicales desde las APIs de Spotify y Lastfm.
- Limpiar y transformar los datos para análisis.
- Diseñar una base de datos en MySQL.
- Realizar consultas SQL para extraer información relevante.
- Presentar la información obtenida al cliente.

## 🔧 Herramientas utilizadas

- Python: Extracción de datos (APIs), limpieza y transformación (pandas).
- MySQL Workbench: Modelado, almacenamiento de datos y consultas para obtener insights.
- Canva: Presentación del proyecto final.
- Jupyter Notebook
- Librerias: spotipy, pandas

## 🔌 Extracción de datos

Utilizamos dos APIs:

- Spotify API: para obtener información sobre canciones, artistas y géneros.
- Last.fm API: para obtener la biografía y estadísticas de popularidad como `playcount` y `listeners`.

Los datos se extrajeron con scripts de Python usando `requests`, y los almacenamos inicialmente en estructuras `DataFrame`, finalmente los guardamos en `.csv`.

## 🧹 Limpieza y transformación de datos



## 🗃️ Diseño y carga de la base de datos

Una vez exportados los archivos `.csv`, diseñamos una base de datos en MySQL para estructurar la información de forma eficiente y escalable.

La base de datos contiene las siguientes tablas:

**Sotify**: que contiene la siguiente información

    - `id_track`: Primary key de la tabla spotify, identificador de canciones
    - `nombre_cancion`: título de la canción
    - `nombre_artista`: nombre del o de los artistas 
    - `id_artista`: Foreign key que hace referencia a la tabla lastfm, identificador de artistas
    - `año_lanzamiento`: año en el que publica la canción
    - `género_musical`: género musical asociado a cada artista o canción.
    - `tipo`: si es una canción (track) o un álbum

**Lastfm**: que contiene la siguiente información

    - `id_artista`: Primary key de la tabla lastfm, identificador de artistas
    - `nombre_artista`: nombre del o de los artistas 
    - `bio`: biografía de los artistas
    - `listeners`: oyentes por artista
    - `playcount`: número total de veces que una artista ha sido reproducido
    - `similar`: artistas similares

Se definieron claves primarias y foráneas para establecer relaciones entre las tablas (por ejemplo, cada canción está vinculada a un artista mediante `id_artista`).

## 🧾 Ejemplo de creación de tabla

CREATE TABLE IF NOT EXISTS `Spotify` (
  `id_track` INT NOT NULL AUTO_INCREMENT,
  `nombre_cancion` VARCHAR(200) NULL,
  `nombre_artista` VARCHAR(100) NOT NULL,
  `id_artista` INT NULL,
  `año_lanzamiento` VARCHAR(4),
  `género_musical` VARCHAR(45) NULL,
  `tipo` VARCHAR(10) NULL,
  PRIMARY KEY(`id_track`),
  CONSTRAINT `fk_lastfm`
    FOREIGN KEY (`id_artista`)
    REFERENCES `lastfm`(`id_artista`)
	ON DELETE CASCADE
    ON UPDATE CASCADE);

## 📤 Carga de datos CSV a MySQL desde Python

Una vez que los datos fueron limpiados y exportados a archivos `.csv`, se cargaron en la base de datos utilizando 

## 🧠 Consultas SQL y análisis de datos

Una vez almacenados los datos en la base de datos, creamos consultas SQL para obtener insights significativos.

### Ejemplos de preguntas que respondimos:

-  ¿Cuál es el artista con más canciones entre 2019 y 2023?
-  ¿Qué canciones fueron las más reproducidas en 2020 y 2022?
-  ¿Cuál es el género musical con mayor número de oyentes?
-  Descubrir canciones de temática romántica


### 🧪 Ejemplo de consulta

SELECT nombre_cancion, año_lanzamiento
FROM (SELECT nombre_cancion, año_lanzamiento, playcount
				  FROM spotify
				  LEFT JOIN lastfm USING (id_artista)
				  WHERE año_lanzamiento = 2020
				  ORDER BY playcount DESC
				  LIMIT 1
				) AS top2020
UNION
SELECT nombre_cancion, año_lanzamiento
FROM (SELECT nombre_cancion, año_lanzamiento, playcount
				  FROM spotify
				  LEFT JOIN lastfm USING (id_artista)
				  WHERE año_lanzamiento = 2022
				  ORDER BY playcount DESC
				  LIMIT 1
				) AS top2022;

## 🖼️ Presentación final

Como parte del proyecto, diseñamos una presentación visual en Canva para simular el pitch de una startup de análisis de tendencias musicales. En esta presentación mostramos:

- Ejemplos visuales de los insights obtenidos.
- Propuestas de valor para empresas del sector musical.

Objetivo: transmitir cómo los datos pueden ayudar a identificar tendencias, artistas emergentes o cambios en la popularidad de géneros musicales.



