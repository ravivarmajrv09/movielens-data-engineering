{{ config(
    materialized='incremental',
    unique_key='movie_id'
) }}

SELECT
    data:movieId::INT AS movie_id,
    data:imdbId::STRING AS imdb_id,
    data:tmdbId::STRING AS tmdb_id,
    LOAD_DATE AS load_date
FROM {{ source('raw', 'RAW_LINKS_JSON') }}

{% if is_incremental() %}
WHERE LOAD_DATE > (
    SELECT COALESCE(MAX(load_date), '1900-01-01'::DATE)
    FROM {{ this }}
)
{% endif %}