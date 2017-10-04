1. Create a new schema using the commands:
sql iidbdb

and then:

CREATE USER jira_issues WITH PASSWORD='<some_secure_password>'\g

2. Place the create_tables script into the /tmp folder of your Accelerator

3. Using chmod, give the script execute privileges e.g. chmod 700 create_tables.sh

4. Once you have .csv files in the /import/tables folder, this script should
automatically import them into the database under the schema jira_issues.