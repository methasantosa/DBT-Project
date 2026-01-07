with CTE as 
(
    select 
    to_timestamp(STARTED_AT) as STARTED_AT,
    date(to_timestamp(STARTED_AT)) as DATE_STARTED_AT,
    hour(to_timestamp(STARTED_AT)) as HOUR_STARTED_AT,

    case 
    when dayname(to_timestamp(STARTED_AT)) in ('sat', 'sun') then 'WEEKEND'
    else 'BUSINESSDAY'
    end as DAY_TYPE,

    case
    when month(to_timestamp(STARTED_AT)) in (12,1,2) then 'WINTER'
    when month(to_timestamp(STARTED_AT)) in (3,4,5) then 'SPRING'
    when month(to_timestamp(STARTED_AT)) in (6,7,8) then 'SUMMER'
    else 'AUTUMN'
    end as STATION_OF_YEAR

    from
    {{ source('demo', 'bike') }}
    where STARTED_AT != 'started_at'
)

select * from CTE