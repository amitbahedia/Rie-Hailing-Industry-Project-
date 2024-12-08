 -- Repeat Passenger Rate Analysis
 with Passenger_Stats as
 (
 
 select c.city_name, p.month_abbr, sum(p.total_passengers) as total_passengers, 
 
 sum(p.repeat_passengers) as repeat_passengers
 
 from dim_city c join fact_passenger_summary p
 
 on c.city_id = p.city_id
 
 group by c.city_name, p.month_abbr
 
 ),
 
 monthly_repeat_passenger_rate as 
 (
 
 select 
 city_name,
 month_abbr, 
 total_passengers, 
 repeat_passengers, 
 Case
	when total_passengers = 0 then 0
    else round((repeat_passengers / total_passengers)*100, 2)
end as repeat_passenger_rate

from Passenger_Stats

),
city_repeat_passenger_rate AS (
    SELECT 
        city_name,
        SUM(total_passengers) AS total_passengers_city,
        SUM(repeat_passengers) AS repeat_passengers_city,
        CASE 
            WHEN SUM(total_passengers) = 0 THEN 0  -- Handle division by zero
            ELSE ROUND((SUM(repeat_passengers) / SUM(total_passengers)) * 100, 2)
        END AS city_repeat_passenger_rate
    FROM 
        Passenger_Stats
    GROUP BY 
        city_name

 )
 
 SELECT 
    m.city_name,
    m.month_abbr,
    m.total_passengers,
    m.repeat_passengers,
    m.repeat_passenger_rate,
    c.city_repeat_passenger_rate AS overall_city_repeat_rate
FROM 
    monthly_repeat_passenger_rate m
JOIN 
    city_repeat_passenger_rate c ON m.city_name = c.city_name
ORDER BY 
    m.city_name, m.month_abbr;