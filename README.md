If you already have an existing schema, go to step 2
1. Create a new schema using the commands:
sql iidbdb

and then:

CREATE USER schema WITH PASSWORD='<some_secure_password>'\g

2. Open create_tables.sh and change the schema variable at the top to your schema name


2. Place the create_tables script into the /tmp folder of your Accelerator

3. Using chmod, give the script execute privileges e.g. chmod 700 create_tables.sh

4. Once you have .csv files in the /import/tables folder, this script should
automatically import them into the database under the schema jira_issues.