{{ config(materialized='table') }}

select
    user_id,
    movie_id,
    tag,
    tag_timestamp

from {{ ref('int_tags') }}