-- =============================================================
-- Phase 3 — SQL | Tender Win/Loss Analytics (SQLite)
-- 01_schema.sql : tables + reference (dimension) tables
-- Dataset: 104 tenders, 2022–2025. SYNTHETIC — modeled on
-- patterns from 4+ years of B2B tender preparation.
-- =============================================================

DROP TABLE IF EXISTS tenders;
DROP TABLE IF EXISTS dim_region;
DROP TABLE IF EXISTS dim_category;

-- Fact table: one row per tender (loaded from data/tender_dataset.csv)
CREATE TABLE tenders (
    tender_id            TEXT PRIMARY KEY,
    submission_date      TEXT NOT NULL,      -- ISO date YYYY-MM-DD
    client_industry      TEXT NOT NULL,
    client_region        TEXT NOT NULL,
    equipment_category   TEXT NOT NULL,
    equipment_type       TEXT,
    project_type         TEXT,
    tender_value_idr     INTEGER NOT NULL,
    our_bid_idr          INTEGER NOT NULL,
    bid_margin_pct       REAL    NOT NULL,   -- stored as 12.5, not 0.125
    lead_time_days       INTEGER NOT NULL,
    status               TEXT    NOT NULL CHECK (status IN ('Win','Loss')),
    win_loss_reason      TEXT,
    competitor_type      TEXT,
    principal_origin     TEXT,
    quotation_revisions  INTEGER,
    decision_maker_level TEXT,
    tender_quarter       TEXT
);

-- Dimension: region -> island + industrial belt (for JOIN practice)
CREATE TABLE dim_region (
    client_region   TEXT PRIMARY KEY,
    island          TEXT NOT NULL,
    industrial_belt TEXT NOT NULL
);

INSERT INTO dim_region VALUES
    ('Lampung',         'Sumatra',    'Sugar Belt'),
    ('South Sumatra',   'Sumatra',    'Mixed (Sugar + Power)'),
    ('East Java',       'Java',       'Sugar Belt'),
    ('Central Java',    'Java',       'Sugar Belt'),
    ('Riau',            'Sumatra',    'Pulp Belt'),
    ('East Kalimantan', 'Kalimantan', 'Pulp Belt'),
    ('Jakarta',         'Java',       'Power Belt'),
    ('West Java',       'Java',       'Power Belt');

-- Dimension: equipment category -> deal profile
CREATE TABLE dim_category (
    equipment_category TEXT PRIMARY KEY,
    deal_profile       TEXT NOT NULL
);

INSERT INTO dim_category VALUES
    ('Power & Utilities', 'Big-ticket project'),
    ('Process Machinery', 'Core equipment'),
    ('Material Handling', 'Core equipment'),
    ('Instrumentation',   'Mid-size system'),
    ('Spare Parts',       'Small, repeat order');
