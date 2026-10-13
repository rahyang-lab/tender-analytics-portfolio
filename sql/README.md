# Phase 3 — SQL: Re-checking My Own Findings

> **Dataset:** 104 B2B equipment tenders, 2022–2025. **Synthetic**, modeled on patterns from my 4+ years of tender preparation. No real client, price, or company data.

Phases 1 and 2 (Excel, Power BI) produced 17 insights. In this phase I loaded the same data into SQLite and rebuilt the key numbers from scratch with SQL. The goal is not to make a new dashboard. The goal is to check whether my earlier conclusions survive a second, independent calculation.

## How to run

```bash
python sql/build_db.py      # builds sql/tenders.db and writes sql/results.md
```

You only need Python's standard library. You can also open `tenders.db` in [DB Browser for SQLite](https://sqlitebrowser.org/) and run `02_analysis.sql` one query at a time.

| File | What it does |
|---|---|
| `01_schema.sql` | Typed fact table + two dimension tables (`dim_region`, `dim_category`) |
| `02_analysis.sql` | 8 queries, one business question each |
| `build_db.py` | Loads the CSV (explicit numeric types), runs every query |
| `results.md` | Query outputs |

**SQL used:** `JOIN`, `GROUP BY`, `CASE WHEN`, CTE (`WITH`), window functions (`RANK`, `LAG`, `SUM() OVER ()`), `UNION ALL`.

## What survived, what changed

| # | Earlier finding | SQL result | Verdict |
|---|---|---|---|
| Q2 | Spare Parts 100% WR, highest margin | 10/10 wins, 22.7% avg margin | ✅ Confirmed |
| Q2 | Material Handling worst (43.8%) | 7/16 wins = 43.8% | ✅ Confirmed |
| Q3 | West Java: smallest volume, highest WR | 8 tenders, 87.5% | ✅ Confirmed |
| Q4 | 78% of losses are price; Rp 49.8B lost | 25/32 = 78.1%; Rp 49.8B | ✅ Confirmed |
| Q5 | 4 of 9 Material Handling losses preventable | 3 specs + 1 technical mismatch = Rp 5.0B | ✅ Confirmed |
| Q7 | "Quoted within 60 days win 80%" | **Under** 60 days = 80.0%. With 60 days included, the figure drops to 77.1% | ⚠️ Boundary matters: the cutoff is < 60, not ≤ 60 |
| Q8 | Speed is a transferable win driver | Gap shrinks from 17.5 to 10.8 pts once Spare Parts is removed | ⚠️ Partly a category effect |

## The finding worth keeping: Q8

Spare Parts has 10 tenders. All of them are fast, and all of them won. That one category pulls the "fast tenders win more" result upward.

- With all categories: fast 80.0% vs slow 62.5% (**17.5 pts**)
- Without Spare Parts: fast 73.3% vs slow 62.5% (**10.8 pts**)

The speed effect is still there, but about 40% of it was really the category. The effect is also sensitive to the cutoff: at ≤ 60 days (still excluding Spare Parts), the gap is only 71.1% vs 68.2%. With 104 rows, this is a hypothesis to test on real data. It is not a rule to roll out.

## Limits

- Synthetic data. The patterns are designed to look plausible, not measured.
- n = 104. One tender moves a category win rate by 6–10 points.
- `lead_time_days` is taken as recorded. It is not proven to be something the sales team controls.
