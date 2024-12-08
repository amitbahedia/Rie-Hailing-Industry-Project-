SELECT c.city_name, 
count(f.trip_id) as total_trips,
avg(fare_amount / distance_travelled_km) as avg_fare_per_km_in_Rs,
avg(fare_amount) as avg_fare_per_trip_in_Rs,
round ((COUNT(f.trip_id) * 100.0 / (SELECT COUNT(*) FROM fact_trips)),2) as percentage_contribution_to_total_trips
from dim_city c
join fact_trips f
on c.city_id = f.city_id
group by c.city_name
order by total_trips desc