🛠️ Implementation Details
1. SQL Proficiency
Database Engine: Developed using standard SQL (PostgreSQL/MySQL compatible).

Techniques: Utilized Common Table Expressions (CTEs), Window Functions (RANK, DENSE_RANK, ROW_NUMBER), and complex JOIN logic to calculate revenue and profitability.

2. Spreadsheet Proficiency
Data Integration: Used XLOOKUP to populate feedback timestamps from the ticket master sheet.

Time Analysis: Implemented INT() and HOUR() functions to determine resolution efficiency (Same Day/Same Hour closure).

Aggregation: Used COUNTIFS to generate outlet-wise performance metrics.

3. Python Logic
Time Converter: A robust script using floor division (//) and modulo (%) operators to calculate time blocks.

String Manipulation: A case-insensitive duplicate remover that preserves the original word order using a set() for efficient lookup.

🚀 How to Run the Solutions
SQL: Run the Setup scripts before the Query scripts to ensure the database schema and sample data exist.

Spreadsheets: Open Ticket_Analysis.xlsx in Excel or Google Sheets to view formulas and summary tables.

Python: Run the scripts via terminal:

Bash
python Python/01_Time_Converter.py
python Python/02_Remove_Duplicates.py