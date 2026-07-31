{{ config(materialized='table') }}

select
    m.movie_id,
    m.title,
    m.genres,
    l.imdb_id,
    l.tmdb_id

from {{ ref('int_movies') }} m

left join {{ ref('int_links') }} l
on m.movie_id = l.movie_id