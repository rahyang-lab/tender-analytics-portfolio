-- =============================================================
-- Phase 3 — SQL | 02_analysis.sql
-- Re-checking my Excel / Power BI findings with SQL.
-- Each query = one business question. Run in SQLite
-- (DB Browser for SQLite, or `python sql/build_db.py`).
-- =============================================================


-- Q1. Overall baseline: how many tenders, what win rate, what value?
SELECT
    COUNT(*)                                             AS tenders,
    SUM(status = 'Win')                                  AS wins,
    ROUND(100.0 * SUM(status = 'Win') / COUNT(*), 1)     AS win_rate_pct,
    ROUND(SUM(tender_value_idr) / 1e9, 1)                AS total_value_bn_idr
FROM tenders;


-- Q2. Which equipment category wins most, and at what margin?
--     (GROUP BY + JOIN to dimension + RANK window function)
SELECT
    t.equipment_category,
    c.deal_profile,
    COUNT(*)                                             AS tenders,
    ROUND(100.0 * SUM(t.status = 'Win') / COUNT(*), 1)   AS win_rate_pct,
    ROUND(AVG(t.bid_margin_pct), 1)                      AS avg_margin_pct,
    ROUND(AVG(t.tender_value_idr) / 1e6, 0)              AS avg_deal_mn_idr,
    RANK() OVER (ORDER BY 1.0 * SUM(t.status = 'Win') / COUNT(*) DESC) AS win_rate_rank
FROM tenders t
JOIN dim_category c ON c.equipment_category = t.equipment_category
GROUP BY t.equipment_category, c.deal_profile
ORDER BY win_rate_rank;


-- Q3. Region performance by industrial belt — does volume convert?
SELECT
    r.industrial_belt,
    t.client_region,
    COUNT(*)                                             AS tenders,
    ROUND(100.0 * SUM(t.status = 'Win') / COUNT(*), 1)   AS win_rate_pct
FROM tenders t
JOIN dim_region r ON r.client_region = t.client_region
GROUP BY r.industrial_belt, t.client_region
ORDER BY tenders DESC;


-- Q4. Why do we lose? Count and value of losses per reason.
SELECT
    win_loss_reason,
    COUNT(*)                                                       AS losses,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1)             AS share_of_losses_pct,
    ROUND(SUM(tender_value_idr) / 1e9, 1)                          AS lost_value_bn_idr
FROM tenders
WHERE status = 'Loss'
GROUP BY win_loss_reason
ORDER BY losses DESC;


-- Q5. Material Handling deep dive: which losses were preventable?
SELECT
    win_loss_reason,
    COUNT(*)                                  AS losses,
    ROUND(SUM(tender_value_idr) / 1e9, 2)     AS lost_value_bn_idr,
    CASE WHEN win_loss_reason IN ('Lost to Tender Specs', 'Technical Mismatch')
         THEN 'Preventable (pre-bid clarification)'
         ELSE 'Price-driven'
    END                                       AS loss_type
FROM tenders
WHERE equipment_category = 'Material Handling'
  AND status = 'Loss'
GROUP BY win_loss_reason
ORDER BY losses DESC;


-- Q6. Year-over-year win rate with change vs previous year (CTE + LAG)
WITH yearly AS (
    SELECT
        SUBSTR(submission_date, 1, 4)                     AS yr,
        COUNT(*)                                          AS tenders,
        ROUND(100.0 * SUM(status = 'Win') / COUNT(*), 1)  AS win_rate_pct
    FROM tenders
    GROUP BY yr
)
SELECT
    yr,
    tenders,
    win_rate_pct,
    ROUND(win_rate_pct - LAG(win_rate_pct) OVER (ORDER BY yr), 1) AS change_pts
FROM yearly
ORDER BY yr;


-- Q7. Claim check: "tenders with lead time under 60 days win ~80%".
--     Bucket the lead time, then compare.
SELECT
    CASE WHEN lead_time_days < 60  THEN '1) < 60 days'
         WHEN lead_time_days <= 90 THEN '2) 60-90 days'
         ELSE                           '3) > 90 days'
    END                                                AS lead_time_bucket,
    COUNT(*)                                           AS tenders,
    ROUND(100.0 * SUM(status = 'Win') / COUNT(*), 1)   AS win_rate_pct
FROM tenders
GROUP BY lead_time_bucket
ORDER BY lead_time_bucket;


-- Q8. Is the lead-time effect real, or is it just Spare Parts?
--     Same comparison, with and without the Spare Parts category.
WITH flagged AS (
    SELECT
        *,
        CASE WHEN lead_time_days < 60 THEN 'Fast (< 60d)' ELSE 'Slow (>= 60d)' END AS speed
    FROM tenders
)
SELECT
    'All categories'                                   AS scope,
    speed,
    COUNT(*)                                           AS tenders,
    ROUND(100.0 * SUM(status = 'Win') / COUNT(*), 1)   AS win_rate_pct
FROM flagged
GROUP BY speed
UNION ALL
SELECT
    'Excluding Spare Parts',
    speed,
    COUNT(*),
    ROUND(100.0 * SUM(status = 'Win') / COUNT(*), 1)
FROM flagged
WHERE equipment_category <> 'Spare Parts'
GROUP BY speed
ORDER BY scope, speed;
