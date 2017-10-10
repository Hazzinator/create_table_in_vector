#!/bin/sh

# The directory where the csv files will be stored
search_directory='/import/tables/'

# The schema we will be importing the data into
schema=devdash

# If there is nothing that matches a pattern, then a null is returned
shopt -s nullglob

# Searches through all the filenames ending in .csv in the search directory
for file in $search_directory/*.csv
do
	# Delete the longest match of */ where * in this case is /import/esdata/
	filename=${file##*/}
	# Delete the shortest match of .* from the end, in this case .csv
	filename=${filename%%.*}
	# Drops a table if it already exists.
	sql db -u$schema <<END
	DROP TABLE $filename \p\g
END
    sql db -u$schema <<END
    CREATE TABLE $filename
    (
        snapshot_date ANSIDATE NOT NULL,
        key VARCHAR(12) PRIMARY KEY,
        summary VARCHAR(5000) NOT NULL,
        status VARCHAR(20),
        assignee VARCHAR(50),
        priority VARCHAR(20),
        created ANSIDATE NOT NULL,
        hubble_team VARCHAR(100) NOT NULL,
        last_updated ANSIDATE NOT NULL
    ) WITH STRUCTURE = VECTORWISE ;
    \p\g
END
	# Load the .csv into the newly created table
	vwload -u $schema -f "," -q "\"" -s 1 -l $filename.log -t $filename db /import/tables/$filename.csv
done