{{ config(
    materialized='incremental',
    unique_key=['user_id','movie_id','tag']
) }}

SELECT
    data:userId::INT AS user_id,
    data:movieId::INT AS movie_id,
    data:tag::STRING AS tag,
    data:timestamp::NUMBER AS tag_timestamp,
    LOAD_DATE AS load_date
FROM {{ source('raw', 'RAW_TAGS_JSON') }}

{% if is_incremental() %}
WHERE LOAD_DATE > (
    SELECT COALESCE(MAX(load_date), '1900-01-01'::DATE)
    FROM {{ this }}
)
{% endif %}