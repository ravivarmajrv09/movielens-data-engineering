{{ config(materialized='table') }}

select
    movie_id,
    title,
    genres,
    language,
    'CSV' as source_type
from {{ ref('stg_movies') }}

union all

select
    movie_id,
    title,
    genres,
    'JSON' as source_type
from {{ ref('stg_movies_json') }}