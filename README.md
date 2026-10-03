Data Analysis Practicals
This repository contains the practical work for Data Analysis Set A,
covering Excel, SQL, Python, and Power BI.
Practical Overview
Task 1 --- Excel
The Excel practical requires a workbook named excel/analysis.xlsx with
four sheets:
- Raw --- Original 13-row deliveries.csv data unchanged.
- Lookup --- The 4-row routes.csv data.
- Clean --- Cleaned delivery data with the exact duplicate
  removed, resulting in 12 unique records.
- Summary --- Hub-level calculations and PivotTable.
Main Operations
- Import the deliveries and routes datasets.
- Remove the exact duplicate delivery row.
- Add service_type using XLOOKUP or INDEX/MATCH from the Lookup
  sheet.
- Apply suitable data types to the required columns.
- Add delay_days using: =MAX(actual_days-promised_days,0)
- Use SUMIFS to calculate total delay days for Chennai, Delhi, and
  Mumbai.
- Create a PivotTable showing total delay_days by service_type and
  hub.
- Create a column chart from the PivotTable.
- Keep formulas and the PivotTable editable.
Task 2 --- SQL
The SQL practical contains:
- setup.sql
- queries.sql
Setup
setup.sql creates the required tables for:
- deliveries
- routes
It also defines suitable data types, primary keys, and the foreign-key
relationship between deliveries.route_id and routes.route_id.
The setup loads exactly:
- 12 delivery rows
- 4 route rows
Analytical Queries
queries.sql contains three separately labelled queries:
1. Total delay by service type
   - Join deliveries with routes.
   - Calculate delay_days as: MAX(actual_days - promised_days, 0)
   - Return service type and total delay days in descending order.
2. Routes with significant delay
   - Use GROUP BY and HAVING.
   - Return routes whose summed delay days exceed the required
     threshold.
3. Top two hubs by delay
   - Calculate summed delay days by hub.
   - Return the top two hubs.
   - Use alphabetical hub order to break ties.
Output and Integrity
The SQL practical also includes:
- Labelled output files for analytical query results.
- A data-integrity query using a LEFT JOIN from deliveries to
  routes.
- Verification that every route_id in deliveries matches a lookup
  row.
- SQL dialect, execution order, and other required notes documented in
  the README.
Task 3 --- Python
The Python practical is implemented in:
python/analysis.py
Load, Clean and Merge
- Load both CSV files using pandas.
- Use relative file paths so the script can run from another machine
  without path edits.
- Confirm numeric data types for required day fields.
- Remove the exact duplicate from the deliveries DataFrame.
- Merge deliveries with routes using a left join on route_id.
- Confirm that the merged DataFrame contains exactly 12 rows.
- Confirm that no route_id values are missing after the merge.
Derived Field and Service-Type Analysis
- Calculate:
  delay_days = (actual_days - promised_days).clip(lower=0)
- Create a grouped service-type summary containing:
  - Sum of delay_days
  - Delay incidence rate, representing the percentage of rows where
    actual_days > promised_days
- Identify the single route with the greatest summed delay days.
- Display the required summary values and figures explicitly.
Task 4 --- Power BI
The Power BI practical is implemented in:
powerbi/dashboard.pbix
Both CSV files are used as data sources.
Power Query and Data Model
- Correct data types for all columns.
- Remove the exact duplicate delivery row.
- Create an active one-to-many relationship:
  routes[route_id] → deliveries[route_id]
DAX Measures
Three explicit measures are created in a dedicated Measures table:
Delivery Count
Delivery Count = COUNTROWS(deliveries)
Total Delay Days
Total Delay Days =
SUMX(
    deliveries,
    MAX(deliveries[actual_days] - deliveries[promised_days], 0)
)
Delay Incidence Rate
Delay Incidence Rate =
DIVIDE(
    COUNTROWS(
        FILTER(
            deliveries,
            deliveries[actual_days] > deliveries[promised_days]
        )
    ),
    COUNTROWS(deliveries),
    0
)
The Delay Incidence Rate is formatted as a percentage.
Report Page
The report contains:
- Three KPI cards:
  - Delivery Count
  - Total Delay Days
  - Delay Incidence Rate
- A bar chart showing Total Delay Days by service type.
- A monthly trend chart for Jan → Feb → Mar.
- A hub slicer that filters the cards and charts simultaneously.
The report is demonstrated in the unfiltered state and the required
numeric findings and recommendation are documented in this README.
Data Sources
The practicals use the following datasets:
- deliveries.csv
- routes.csv
The CSV files are used consistently across the Excel, SQL, Python, and
Power BI practicals.
Repository Structure
data-analysis-set-a/
│
├── Excel_Practical.xlsx
├── Power BI_Practical.pbix
├── Python_practical.ipynb
├── deliveries.csv
├── routes.csv
└── README.md
Purpose
The purpose of these practicals is to demonstrate basic data-analysis
skills including:
- Data cleaning
- Data transformation
- Lookup and merging
- SQL querying
- Derived-field calculation
- Grouped analysis
- Data visualization
- DAX measures
- Dashboard creation
- Data integrity validation
Note
All practical files are maintained in editable form so that the examiner
can inspect formulas, PivotTables, SQL scripts, Python analysis, Power
BI transformations, relationships, and DAX measures.
