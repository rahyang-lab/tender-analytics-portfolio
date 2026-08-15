# Power BI Interactive Dashboard — Tender Win-Loss Analytics

Interactive three-page dashboard built on 104 B2B industrial equipment tenders (2022–2025). Phase 2 of the Tender Analytics portfolio project — Phase 1 covered the exploratory analysis; this phase turns those findings into something a sales director could actually use on a Monday morning.

![Executive Overview](images/PowerBI_Page1_Overview.png)

---

## Why this dashboard exists

Phase 1 produced 17 insights in a spreadsheet. Useful once, dead the moment someone asks a follow-up question: *"what does that look like for Sugar only?"*, *"was 2024 different?"*

This dashboard answers those questions without anyone rebuilding a pivot table. Every visual responds to three slicers, and the loss-reason breakdown recalculates on the fly.

---

## Structure — one page, one question

| Page | The question it answers |
|---|---|
| **Executive Overview** | How are we performing overall, and where? |
| **Deep Dive** | Why do we win and lose? |
| **Tender-Level Detail** | Which specific tenders sit behind the numbers? |

Nothing lives on a page that doesn't help answer that page's question. Charts I built and then removed are not in the file.

---

## Data

- 104 tenders, 18 source columns, 2022–2025
- 6 calculated columns added in Power Query
- **Synthetic dataset.** Structure mirrors real B2B industrial tender patterns from my time as an Applicant Engineer. No proprietary or client data is used anywhere in this project.

---

## Measures worth explaining

Twelve DAX measures drive the report. Four of them involved a real decision, so those are the ones documented here.

### `Win Rate vs Overall`

```dax
Win Rate vs Overall =
VAR CurrentWinRate = [Win Rate %]
VAR OverallWinRate = CALCULATE( [Win Rate %], REMOVEFILTERS( Tenders ) )
RETURN
    CurrentWinRate - OverallWinRate
```

Stakeholders rarely ask "what is our win rate in Lampung?" They ask "is Lampung better or worse than usual?" An absolute number forces them to do that subtraction in their head. This measure does it for them, and it stays correct under any slicer combination because `REMOVEFILTERS` re-establishes the full-population baseline rather than hard-coding 69.23%.

### `Top Loss Reason`

```dax
Top Loss Reason =
VAR LossTable =
    CALCULATETABLE(
        ADDCOLUMNS(
            VALUES( Tenders[Win_Loss_Reason] ),
            "@LossCount", CALCULATE( COUNTROWS( Tenders ) )
        ),
        Tenders[Status] = "Loss"
    )
RETURN
    MAXX( TOPN( 1, LossTable, [@LossCount], DESC ), Tenders[Win_Loss_Reason] )
```

Returns text rather than a number, so the dashboard can state the dominant loss reason in plain language for whatever slice is selected.

Built with `ADDCOLUMNS` over `VALUES` rather than `SUMMARIZE` with an extension column. The `SUMMARIZE` pattern is shorter but is known to produce incorrect results under certain filter contexts — a shortcut that works until it silently doesn't.

### `Preventable Loss %`

```dax
Preventable Loss % =
VAR PreventableLosses =
    CALCULATE(
        COUNTROWS( Tenders ),
        Tenders[Status] = "Loss",
        Tenders[Win_Loss_Reason] IN { "Lost to Tender Specs", "Technical Mismatch" }
    )
RETURN
    DIVIDE( PreventableLosses, [Total Losses], 0 )
```

"Preventable" is a judgement call, not a data property. I define it as losses where the cause was specification mismatch rather than price — situations a pre-bid technical clarification could have changed. Losing on price to a European OEM with a structurally lower cost base is not preventable by the sales team, so it is excluded.

The definition is stated here because the number is meaningless without it.

### `KPI Color`

```dax
KPI Color =
VAR WR = [Win Rate %]
RETURN
    SWITCH( TRUE(), WR >= 0.70, "#D4A017", WR >= 0.50, "#1E3A5F", "#C0392B" )
```

Returns a hex string consumed by conditional formatting on the Win Rate card. The card colours itself based on performance instead of being manually coloured — so it stays honest when a slicer drops the win rate below threshold.

---

## Design decisions

**Quarter sorting.** `Tender_Quarter` is text, so Power BI sorted it alphabetically: Q1-2022, Q1-2023, Q1-2024, Q1-2025, Q2-2022. The trend line looked plausible and meant nothing. Fixed with a numeric `Quarter_Sort` column (`Year × 10 + QuarterOfYear`) applied via *Sort by column*.

**Decimal separator on import.** `Bid_Margin_Pct` loaded as 125 instead of 12.5 — the default locale read the decimal point as a thousands separator. Every margin in the model was ten times too large, and nothing errored. Fixed by passing `"en-US"` as the culture argument to `Table.TransformColumnTypes`, which handles the whole type-conversion step at once rather than patching one column downstream.

**Volume over proportion.** The regional chart uses a stacked bar showing tender counts, not a 100% stacked bar. Riau at 50/50 from 6 tenders and East Java at 86% from 14 are not comparable, and a 100% stacked chart hides exactly that difference.

**Blank cells in the heatmap are grey, not red.** Several equipment × project-type combinations have no tenders at all. Colouring them with the minimum-value colour would read as a 0% win rate.

**No trend line on the scatter.** Power BI does not offer trend lines on scatter charts. Rather than substituting a ratio line that looks like a regression but isn't, the chart carries a constant line at the 69.23% overall win rate, which is what a reader actually needs to judge each category against.

---

## What the dashboard shows

**Price dominates the loss column — but not the way you'd expect.** 78% of losses cite "Higher Price". Yet across equipment categories, higher average margin does not correlate with lower win rate. Spare Parts carries the highest margin at 22.6% and wins 100% of the time; Material Handling sits at 14.5% margin and wins 43.8%.

The variable doing the work is deal type, not price. Small spare-parts orders are won on delivery speed. Large capital equipment is won or lost on the principal's cost base, which the sales team does not control.

**Speed converts.** Tenders quoted within 60 days win 80% of the time, against 61–64% for slower responses. This is the most actionable finding in the report, because response time is one of the few variables entirely within the team's control.

**We do not beat international OEMs.** Zero wins from 31 tenders where an international OEM competed directly. See the limitations section before quoting this figure.

---

## Limitations

Stated plainly, because a dashboard that hides its own weak points is worth less than one that doesn't.

**Quarterly figures are noise, not trend.** 104 tenders across 16 quarters is roughly 6–7 per quarter. Every quarterly win rate in the report is a multiple of 1/6 or 1/7, and a single tender flipping moves a quarter by 14 percentage points. The quarterly chart is included because stakeholders expect a time view — but the stable ~69% baseline is the signal, and the 57%–86% swing around it is not.

**Spare Parts is 10 tenders.** A 100% win rate from 10 observations is a hypothesis worth testing, not an established fact.

**`Competitor_Type` may leak the outcome.** The 0-from-31 record against international OEMs is striking, but the field's collection point is unclear. If competitor type is recorded after the tender result is known, it describes the outcome rather than predicting it. Treated here as a flag for investigation, not as a finding.

**Synthetic data.** Patterns are realistic in structure but were not observed. Nothing here should be read as a claim about any actual company's performance.

---

## Files

```
/powerbi
   TenderDashboard_FINAL.pbix          Power BI Desktop file
   README.md                            this document
   /images
      PowerBI_Page1_Overview.png
      PowerBI_Page2_DeepDive.png
      PowerBI_Page3_Detail.png
      PowerBI_Interactive_Demo.gif      slicer interaction, 15s
   /export
      Tender_Dashboard_PowerBI.pdf
```

Open the `.pbix` with [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free). No data source configuration needed — the dataset is embedded.

---

## Tools

Power BI Desktop · Power Query (M) · DAX

Phase 1 of this project — exploratory analysis, 17 insights, and methodology — is in the repository root.
