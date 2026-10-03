-- Total delay by service type

SELECT
    r.service_type,
    SUM(GREATEST(d.actual_days - d.promised_days, 0)) AS total_delay_days
FROM deliveries d
JOIN routes r
    ON d.route_id = r.route_id
GROUP BY r.service_type
ORDER BY total_delay_days DESC;

-- Routes with significant delay

SELECT
    d.route_id,
    SUM(GREATEST(d.actual_days - d.promised_days, 0)) AS total_delay_days
FROM deliveries d
GROUP BY d.route_id
HAVING SUM(GREATEST(d.actual_days - d.promised_days, 0)) > 8;

-- Top two hubs by summed delay

SELECT
    hub,
    SUM(GREATEST(actual_days - promised_days, 0)) AS total_delay_days
FROM deliveries
GROUP BY hub
ORDER BY total_delay_days DESC, hub ASC
LIMIT 2;

-- Data integrity check

SELECT
    d.route_id,
    r.route_id AS matched_route_id
FROM deliveries d
LEFT JOIN routes r
    ON d.route_id = r.route_id
WHERE r.route_id IS NULL;
WHERE r.route_id IS NULL;