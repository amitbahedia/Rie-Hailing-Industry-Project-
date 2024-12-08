WITH City_Monthly_Revenue AS (
    SELECT 
        c.city_name,
        f.month_abbr,
        SUM(f.fare_amount) AS total_revenue
    FROM 
        dim_city c 
    JOIN 
        fact_trips f ON c.city_id = f.city_id
    GROUP BY 
        c.city_name, f.month_abbr
),
Highest_Revenue_Month AS (
    SELECT 
        city_name,
        month_abbr,
        total_revenue,
        ROW_NUMBER() OVER (PARTITION BY city_name ORDER BY total_revenue DESC) AS revenue_rank
    FROM 
        City_Monthly_Revenue
)
SELECT 
    city_name,
    month_abbr AS highest_revenue_month,
    total_revenue AS highest_revenue
FROM 
    Highest_Revenue_Month
WHERE 
    revenue_rank = 1
ORDER BY 
    city_name;
