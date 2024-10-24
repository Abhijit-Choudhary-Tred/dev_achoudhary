{{ config(materialized='table') }}


SELECT
md.member_id,
md.member_first_name,
md.member_last_name,
md.member_address,
md.member_city,
md.member_region,
md.member_email,
md.member_dob,
ld.location_id,
ld.location_name,
ld.location_region,
ld.location_zip,
ld.location_address,
id.item_id,
id.item_name,
id.item_category,
id.item_subcategory,
id.item_size,
id.item_type_code,
sf.transaction_date,
sf.activity_department_id,
sf.register_id,
MAX(sf.transaction_num) AS transaction_num,
SUM(sf.measure_uom_qty) AS total_uom_qty,
SUM(sf.eligible_reward_sales_amt) AS total_reward_sales_amt,
MAX(sf.transaction_timestamp) AS max_transaction_timestamp,  -- Keep the latest timestamp
MAX(sf.load_timestamp) AS max_load_timestamp,
MAX(sf.batch_id) AS latest_batch_id  -- Assuming you want the latest batch
FROM
`studio-de-accelerator.costco_demo_silver.sales_fact` sf
LEFT JOIN `studio-de-accelerator.costco_demo_silver.item_dim` id ON sf.item_id = id.item_id 
LEFT JOIN `studio-de-accelerator.costco_demo_silver.location_dim` ld ON sf.location_id = ld.location_id 
LEFT JOIN `studio-de-accelerator.costco_demo_silver.member_dim` md ON sf.member_id = md.member_id 
GROUP BY
md.member_id,
md.member_first_name,
md.member_last_name,
md.member_address,
md.member_city,
md.member_region,
md.member_email,
md.member_dob,
ld.location_id,
ld.location_name,
ld.location_region,
ld.location_zip,
ld.location_address,
id.item_id,
id.item_name,
id.item_category,
id.item_subcategory,
id.item_size,
id.item_type_code,
sf.transaction_date,
sf.activity_department_id,
sf.register_id