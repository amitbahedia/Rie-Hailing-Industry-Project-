-- Identify Cities with Highest and Lowest Total New

WITH City_New_Passenger_Data AS (
    SELECT 
        c.city_name,
        SUM(p.new_passengers) AS total_new_passengers
    FROM 
        dim_city c
    JOIN 
        fact_passenger_summary p ON c.city_id = p.city_id
    GROUP BY 
        c.city_name
),
City_Rankings AS (
    SELECT 
        city_name,
        total_new_passengers,
        ROW_NUMBER() OVER (ORDER BY total_new_passengers DESC) AS rank_desc,
        ROW_NUMBER() OVER (ORDER BY total_new_passengers ASC) AS rank_asc
    FROM 
        City_New_Passenger_Data
)
SELECT 
    city_name,
    total_new_passengers,
    CASE 
        WHEN rank_desc <= 3 THEN 'Top 3'
        WHEN rank_asc <= 3 THEN 'Bottom 3'
        ELSE NULL
    END AS city_category
FROM 
    City_Rankings
WHERE 
    rank_asc <= 3 OR rank_desc <= 3 
ORDER BY 
    total_new_passengers DESC,  city_category;


