#!/bin/sh

# The directory where the csv files will be stored
#search_directory = "/import/esdata"

# If there is nothing that matches a pattern, then a null is returned
shopt -s nullglob

# Searches through all the filenames ending in .csv in the search directory
for file in "/import/esdata/*.csv"
do
	# Delete the longest match of */ where * in this case is /import/esdata/)
	filename=${file##*/}
	# Delete the shortest match of .* from the end, in this case .csv
	filename=${filename%%.*}
	echo "Creating table $filename"
	# Creates a table
    sql db -ujira_issues <<END
    CREATE TABLE $filename
    (
        snapshot_date ANSIDATE NOT NULL,
        key VARCHAR(12) PRIMARY KEY,
        summary VARCHAR(5000) NOT NULL,
        status VARCHAR(20) NOT NULL,
        assignee VARCHAR(50) NOT NULL,
        priority VARCHAR(20) NOT NULL,
        created ANSIDATE NOT NULL,
        hubble_team VARCHAR(100) NOT NULL,
        last_updated ANSIDATE NOT NULL
    ) WITH STRUCTURE = VECTORWISE ;
    \p\g
END
done
