# Retail Sales & Profitability Diagnostic Analysis

## Data Dictionary

**Dataset:** Global_Superstore2  
**Verified records:** 51,290  
**Columns:** 24  
**Purpose:** Describe each field and its analytical use before cleaning and analysis.

| # | Column | Meaning | Business / analytical use |
|---:|---|---|---|
| 1 | Row ID | Row-level identifier in the dataset | Record identification; check uniqueness before treating it as a key |
| 2 | Order ID | Identifier for a customer order | Order counting and order-level analysis; may repeat across product lines |
| 3 | Order Date | Date the order was placed | Daily, monthly, quarterly and yearly sales trends |
| 4 | Ship Date | Date the order was shipped | Shipping-time analysis when compared with Order Date |
| 5 | Ship Mode | Shipping service/method | Compare order volume, shipping patterns and performance by mode |
| 6 | Customer ID | Customer identifier | Customer-level analysis and distinct customer counts |
| 7 | Customer Name | Customer's displayed name | Human-readable customer identification; Customer ID is generally better for grouping |
| 8 | Segment | Customer segment | Compare sales and profitability across customer segments |
| 9 | City | City associated with the order | City-level sales and profit analysis |
| 10 | State | State/province associated with the order | State-level performance analysis |
| 11 | Country | Country associated with the order | Country-level comparison |
| 12 | Postal Code | Postal/ZIP code | Geographic grouping or location identification; treat as an identifier, not a quantity |
| 13 | Market | Business market grouping | Market-level sales and profitability analysis |
| 14 | Region | Geographic/business region | Regional performance comparison |
| 15 | Product ID | Product identifier | Product-level grouping and product tracking |
| 16 | Category | Broad product category | Category-level sales and profitability analysis |
| 17 | Sub-Category | More specific product grouping within a category | Detailed product-group comparisons |
| 18 | Product Name | Product's displayed name | Product-level performance and profitability analysis |
| 19 | Sales | Recorded sales value | Sales/revenue analysis; confirm dataset's business definition before labeling it revenue |
| 20 | Quantity | Number of units in the order line | Units-sold and demand analysis |
| 21 | Discount | Discount value/rate recorded for the order line | Discount pattern and relationship with profit; inspect scale and meaning before interpreting |
| 22 | Profit | Recorded profit for the order line | Profitability analysis; negative values indicate recorded losses |
| 23 | Shipping Cost | Recorded shipping cost | Shipping-cost analysis and possible cost-driver investigation |
| 24 | Order Priority | Priority classification for the order | Compare order volume and performance by priority |

## Important notes to verify during data profiling

- Confirm whether Row ID is unique and whether Order ID repeats across multiple product lines.
- Check data types, missing values, duplicate rows and invalid dates.
- Inspect Postal Code for blanks and mixed formats; it is an identifier, not a measure.
- Inspect Discount values to establish whether they are stored as fractions or percentages.
- Confirm the exact definition of Sales and Profit from the dataset source before making business claims.
- Treat negative Profit values as records to investigate, not automatically as data errors.

## Current project status

- Dataset downloaded and opened in Excel for the web.
- 51,290 data rows and 24 columns identified (row 1 is the header; last populated row observed was 51,291).
- Column names captured and initial data dictionary drafted.
- Data quality profiling and validation are next.
