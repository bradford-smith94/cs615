#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 HW5 part2.sh
# 04/07/2018
##########################

main () {
	parse_input "$*"
	DATA=$1

	get_unique_object_count $DATA

	get_most_frequent_object $DATA

	get_total_bytes_transferred $DATA

	get_requests_per_second $DATA

	get_largest_object $DATA
}

parse_input () {
	if [ -z $1 ]; then
		echo "usage:" $0 "inputfile"
		exit 1
	fi
}

# takes in inputfile as only argument
get_unique_object_count () {
	echo -n "Unique objects: " 

	filter_by_en $1 |
	wc -l |
	trim_spaces

	echo
}

# takes in inputfile as only argument
get_most_frequent_object () {
	echo -n "Most frequent object: " 

	filter_by_en $1 |
	awk '{print $2, $(NF -1)}' |
	sort -nrk 2 |
	head -n 1 |
	cut -d ' ' -f 1 |
	trim_spaces

	echo
}

# takes in inputfile as only argument
get_total_bytes_transferred () {
	echo -n "Total bytes transferred: " 

	filter_by_en $1 |
	awk '{sum += $NF} END {print sum}' |
	trim_spaces

	echo
}

# takes in inputfile as only argument
get_requests_per_second () {
	echo -n "Requests per second: "

	filter_by_en $1 |
	awk '{sum += $(NF - 1)} END {print sum / 60 / 60 }' |
	trim_spaces

	echo
}

# takes in inputfile as only argument
get_largest_object () {
	echo -n "Largest object: "

	filter_by_en $1 |
	awk '{print $NF / $(NF - 1), $0}' |
	sort -nr |
	head -n 1 |
	cut -d ' ' -f 3 |
	trim_spaces

	echo
}

# takes in inputfile as only argument
filter_by_en () {
	zgrep ^en $1
}

trim_spaces () {
	tr -d '[:space:]'
}

# call main function
main "$*"
