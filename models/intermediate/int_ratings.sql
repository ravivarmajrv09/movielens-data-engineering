{{ config(materialized='table') }}

select
    user_id,
    movie_id,
    rating,
    rating_timestamp,
    'CSV' as source_type
from {{ ref('stg_ratings') }}

union all

select
    user_id,
    movie_id,
    rating,
    rating_timestamp,
    'JSON' as source_type
from {{ ref('stg_ratings_json') }}