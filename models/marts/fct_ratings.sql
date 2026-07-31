{{ config(materialized='table') }}

select
    user_id,
    movie_id,
    rating,
    rating_timestamp

from {{ ref('int_ratings') }}