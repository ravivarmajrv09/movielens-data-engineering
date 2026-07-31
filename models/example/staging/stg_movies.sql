{{ config(
    materialized='incremental',
    unique_key='movie_id'
) }}

SELECT
    movieId AS movie_id,
    TITLE AS title,
    GENRES AS genres,
    LOAD_DATE AS load_date
FROM {{ source('raw','RAW_MOVIES') }}

{% if is_incremental() %}
WHERE LOAD_DATE > (
    SELECT COALESCE(MAX(load_date), '1900-01-01')
    FROM {{ this }}
)
{% endif %}