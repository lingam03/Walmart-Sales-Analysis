-- External Factor Analysis
-- Sales vs Temperature

select 
  case
    when temperature < 30 then 'Cold'
    when temperature between 20 and 35 then 'Moderate'
    else 'Hot'
  end as temperature_range,
  round(avg(weekly_sales),2) as Avg_sales,
 MAX(weekly_sales) as max_sales,
 MIN(weekly_sales) as min_sales
From walmart
group by temperature_range;

-- sales vs fuel price
 -- Average weekly sales for different fuel price ranges
 
select 
case
when fuel_price < 2.5 then "Low fuel Price"
when fuel_price between 2.5 and 4.0 then 'Moderate Fuel Price'
else 'High Fuel Price'
end as fuel_price_range,
Round(avg(weekly_sales),2) as avg_sales,
max(weekly_sales) as max_sales,
min(weekly_sales) as min_sales
from walmart
group by fuel_price_range;

-- sales vs consumer price index (CPI)
 -- Avg weekly sales for difference CPI range
 
 select 
 case 
 when cpi < 150 then 'Low CPI'
 when cpi between 150 and 200 then 'Moderate CPI'
 else 'High CPI'
 end as cpi_range,
 Round(Avg(weekly_sales),2) as avg_sales,
 Max(weekly_sales) as max_sales,
 Min(weekly_sales) as min_sales
 from walmart
 group by cpi_range;
 
 -- sales vs Unemployement 
 -- Avg weekly sales for different unemployment levels
 
 select 
 case 
 when unemployment < 5.0 then 'Low Unemployment'
 when unemployment between 5.0 and 10.0 then 'Moderate Unemployment'
 else 'High Unemployment'
 end as unemployment_level,
Round(Avg(weekly_sales),2) as avg_sales,
 MAX(weekly_sales) as max_sales,
 MIN(weekly_sales) as min_sales
 From walmart
 group by unemployment_level;
 
  /*  ADVANCE Analysis  */
 -- seasonal analysis 
 
 SELECT 
    MONTH(converted_date) AS sale_month,
    ROUND(AVG(weekly_sales), 2) AS avg_monthly_sales,
    ROUND(AVG(temperature), 2) AS avg_monthly_temp,
    ROUND(MAX(weekly_sales), 2) AS max_monthly_sales,
    ROUND(MAX(temperature), 2) AS max_monthly_temp,
    ROUND(MIN(weekly_sales), 2) AS min_monthly_sales,
    ROUND(MIN(temperature), 2) AS min_monthly_temp
FROM walmart
GROUP BY sale_month
ORDER BY sale_month;

-- sales forcasting

SELECT 
    converted_date,
    weekly_sales,
    Round(AVG(weekly_sales) OVER (ORDER BY converted_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) AS moving_avg_sales
FROM walmart;

-- Impact of holidays on sales

SELECT 
    converted_date,
    weekly_sales,
    holiday_flag,
    fuel_price
FROM walmart
WHERE holiday_flag = 1; -- Filter for holiday periods only

-- Regional Analysis

SELECT 
    store,
    round(AVG(weekly_sales),2) AS avg_sales,
    round(AVG(temperature),2) AS avg_temp,
    round(AVG(unemployment),2) AS avg_unemployment
FROM walmart
GROUP BY store
ORDER BY avg_sales DESC;

-- Outline Detection

SELECT 
    converted_date, 
    weekly_sales,
   round(ABS(weekly_sales - (SELECT round(AVG(weekly_sales),2) FROM walmart)),2) AS sales_deviation
FROM walmart
ORDER BY sales_deviation DESC
limit 10; -- Top 10 outliers


