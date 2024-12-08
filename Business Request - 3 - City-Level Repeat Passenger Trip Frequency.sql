WITH City_Trip_Data AS (
    SELECT 
        c.city_name,
        t.Trip_count_Whole_Number,
        SUM(t.repeat_passenger_count) AS repeat_passenger_count
    FROM 
        dim_repeat_trip_distribution t
    JOIN 
       dim_city c ON t.city_id = c.city_id
    WHERE 
        t.Trip_count_Whole_Number IN (1,2,3,4,5,6,7,8,9,10)
    GROUP BY 
        c.city_name, t.Trip_count_Whole_Number
), 
    
City_Total_Repeat AS (
    SELECT 
        city_name,
        SUM(repeat_passenger_count) AS total_repeat_passengers
    FROM 
        City_Trip_Data
    GROUP BY 
        city_name
)
SELECT 
    ctd.city_name,
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 2 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "2-Trips",
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 3 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "3-Trips",
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 4 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "4-Trips",
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 5 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "5-Trips",
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 6 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "6-Trips",
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 7 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "7-Trips",
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 8 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "8-Trips",
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 9 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "9-Trips",
    ROUND((SUM(CASE WHEN ctd.Trip_count_Whole_Number = 10 THEN ctd.repeat_passenger_count END) * 100.0) / ctr.total_repeat_passengers, 2) AS "10-Trips"
   
FROM 
    City_Trip_Data ctd
JOIN 
    City_Total_Repeat ctr ON ctd.city_name = ctr.city_name
GROUP BY 
    ctd.city_name, ctr.total_repeat_passengers
ORDER BY 
    ctd.city_name;
