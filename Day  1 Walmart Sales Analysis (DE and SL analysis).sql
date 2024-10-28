select * from walmart;

select distinct count(*) as Distinct_records ,
	   count(*) as Total_records
from walmart;
 
 -- Overview of store and data range
 
-- Add a new column to store the converted date
ALTER TABLE walmart
 ADD COLUMN converted_date DATE;

-- Update the new column with the converted dates
UPDATE walmart
SET converted_date = STR_TO_DATE(date, '%d-%m-%Y');  -- Adjust the format as per your dataset



SELECT count(distinct store) as num_stores,
 MIN(converted_date) as start_date,
 MAX(converted_date) as end_date
from walmart;



-- Summary Statistics of weekly sales
SELECT ROUND(MIN(Weekly_Sales),2) AS min_sales,
		ROUND(MAX(Weekly_Sales),2) AS max_sales,
        ROUND(AVG(Weekly_Sales),2) AS avg_sales
FROM walmart;

-- check missing values
select 
count(*) as total_records,
count(store) as non_null_stores,
count(converted_date) as non_null_converted_date,
count(weekly_sales) as non_null_weekly_sales
from walmart;


-- Store-Level analysis

-- total sales per store

Select store, round(sum(weekly_sales),2) as total_sales
from walmart
group by store
order by total_sales desc;

-- top 5 performing store

Select store, round(sum(weekly_sales),2) as total_sales
from walmart
group by store
order by total_sales desc
limit 5 ;

Select store, round(sum(weekly_sales),2) as total_sales
from walmart
group by store
order by total_sales asc
limit 5;

-- DATA EXPLORATORY ANALYSIS AND STORE LEVEL ANALYSIS
