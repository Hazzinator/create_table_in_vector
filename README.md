1. Create a new schema using the commands:
sql iidbdb

and then:

CREATE USER jira_issues WITH PASSWORD='<some_secure_password>'\g

2. Place this file in the /tmp folder of your Accelerator

3. Using chmod, give the script execute privileges.

4. Once you have .csv files in the /import/tables folder, this script should
automatically import them into the database under the schema jira_issues.