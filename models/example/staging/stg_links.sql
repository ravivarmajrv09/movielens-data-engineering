{{ config(
    materialized='incremental',
    unique_key='movie_id'
) }}

SELECT
    MOVIEID AS movie_id,
    IMDBID AS imdb_id,
    TMDBID AS tmdb_id,
    LOAD_DATE AS load_date
FROM {{ source('raw', 'RAW_LINKS') }}

{% if is_incremental() %}
WHERE LOAD_DATE > (
    SELECT COALESCE(MAX(load_date), '1900-01-01')
    FROM {{ this }}
)
{% endif %}