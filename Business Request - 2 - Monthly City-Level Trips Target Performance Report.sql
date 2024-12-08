SELECT 
    d.city_name AS City_name, 
    m.month_abbr AS month_name, 
    COUNT(f.trip_id) AS actual_trips, 
    m.total_target_trips AS target_trips,
    CASE 
        WHEN COUNT(f.trip_id) > m.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    CASE 
        WHEN m.total_target_trips = 0 THEN 0
        ELSE ((COUNT(f.trip_id) - m.total_target_trips) * 100.0 / m.total_target_trips)
    END AS perc_diff
FROM 
    dim_city d
JOIN 
    fact_trips f ON d.city_id = f.city_id
JOIN 
    targets_db.monthly_target_trips m ON d.city_id = m.city_id AND f.month_abbr = m.month_abbr
GROUP BY 
    d.city_name, m.month_abbr, m.total_target_trips
ORDER BY 
    d.city_name, m.month_abbr;


   

