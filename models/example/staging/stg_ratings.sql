{{ config(
    materialized='incremental',
    unique_key=['user_id','movie_id','rating_timestamp']
) }}

SELECT
    USERID AS user_id,
    MOVIEID AS movie_id,
    RATING AS rating,
    TIMESTAMP AS rating_timestamp,
    LOAD_DATE AS load_date
FROM {{ source('raw', 'RAW_RATINGS') }}

{% if is_incremental() %}
WHERE LOAD_DATE > (
    SELECT COALESCE(MAX(load_date), '1900-01-01')
    FROM {{ this }}
)
{% endif %}