with CTE as 
(
    select 
    STARTED_AT
    from
    {{ source('demo', 'bike') }}
)