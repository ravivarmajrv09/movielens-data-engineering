{{ config(materialized='table') }}

select
    movie_id,
    imdb_id,
    tmdb_id,
    'CSV' as source_type
from {{ ref('stg_links') }}

union all

select
    movie_id,
    imdb_id,
    tmdb_id,
    'JSON' as source_type
from {{ ref('stg_links_json') }}