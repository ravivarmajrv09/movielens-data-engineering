{{ config(materialized='table') }}

select
    user_id,
    movie_id,
    tag,
    tag_timestamp,
    'CSV' as source_type
from {{ ref('stg_tags') }}

union all

select
    user_id,
    movie_id,
    tag,
    tag_timestamp,
    'JSON' as source_type
from {{ ref('stg_tags_json') }}