-- Auto Generated (Do not modify) 880A6B91D233FC1DF03D4C8EE592524B5AB8DCEA32301D4A9B7255686FC435C6
CREATE VIEW gold_monthly_summary AS

WITH monthly_summary AS
(
    SELECT
        FORMAT(order_date,'yyyy-MM') AS year_month,
        dc.region,
        SUM(total_amount) AS total_revenue,
        COUNT(order_id) AS total_orders,
        AVG(total_amount) AS avg_order_value
    FROM fact_orders fo
    JOIN dim_customer dc
        ON fo.customer_id = dc.customer_id
    GROUP BY
        FORMAT(order_date,'yyyy-MM'),
        dc.region
)

SELECT *,
       RANK() OVER
       (
           PARTITION BY year_month
           ORDER BY total_revenue DESC
       ) AS revenue_rank_in_month
FROM monthly_summary;