# Utility to Load Synthea CSV data to OMOP CDM
## Currently supports CDM V5.3

### Scripted Execution
Use the bulk-load script.


### Step by Step
1. Create the empty CDM tables: located in: ETL/SQL/omop_cdm_pg_ddl.sql
2. Create the empty synthea tables: ETL/SQL/synthea_ddl.sql
3. To populate the tables created in step 2 use the import tool in pgadmin (simply right-click on a table and a dropdown of options will appear - choose "Import/Export").
The following guide is helpful: http://www.postgresqltutorial.com/import-csv-file-into-posgresql-table/
The data to import into your tables consists of the csv files located in the ETL/CSV directory.
