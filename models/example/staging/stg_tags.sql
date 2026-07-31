{{ config(
    materialized='incremental',
    unique_key=['user_id','movie_id','tag']
) }}

SELECT
    USERID AS user_id,
    MOVIEID AS movie_id,
    TAG,
    TIMESTAMP AS tag_timestamp,
    LOAD_DATE AS load_date
FROM {{ source('raw', 'RAW_TAGS') }}

{% if is_incremental() %}
WHERE LOAD_DATE > (
    SELECT COALESCE(MAX(load_date), '1900-01-01')
    FROM {{ this }}
)
{% endif %}