#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 HW5 part3.sh
# 04/08/2018
##########################

USAGE="usage: $0 [-h] [-b | -f | -l | -r | -u] [-d domain] inputfile"

main () {
	parse_input "$@"

	if [ -n "$ONLY" ]; then
		case "$ONLY" in
		"b") get_total_bytes_transferred "$DATA" only;;
		"f") get_most_frequent_object "$DATA" only;;
		"l") get_largest_object "$DATA" only;;
		"r") get_requests_per_second "$DATA" only;;
		"u") get_unique_object_count "$DATA" only;;
		\?) usage;;
		esac
	else
		get_unique_object_count "$DATA"
		get_most_frequent_object "$DATA"
		get_total_bytes_transferred "$DATA"
		get_requests_per_second "$DATA"
		get_largest_object "$DATA"
	fi
}

parse_input () {
	# region defaults to "en"
	REGION=en

	while getopts bd:fhlru flag; do
		case $flag in
		b) [ -n "$ONLY" ] && usage || ONLY=$flag;;
		d) REGION="$OPTARG";;
		f) [ -n "$ONLY" ] && usage || ONLY=$flag;;
		h) help_message; exit 0;;
		l) [ -n "$ONLY" ] && usage || ONLY=$flag;;
		r) [ -n "$ONLY" ] && usage || ONLY=$flag;;
		u) [ -n "$ONLY" ] && usage || ONLY=$flag;;
		\?) usage;;
		esac
	done
	shift $(expr $OPTIND - 1)

	[ -z "$1" ] && usage || DATA=$1
}

usage () {
	echo $USAGE
	exit 1
}

help_message () {
	cat<<EOF
 -b          only print 'total bytes' stats
 -d <domain> if not specified, default to 'en'
             note: the special domain 'all' is also valid
 -f          only print 'most frequent' stats
 -h          print this help and exit
 -l          only print 'largest object' stats
 -r          only print 'requests per second' stats
 -u          only print 'unique objects' stats
EOF
}

# takes in inputfile and a flag,
# if flag is present this is the only command being run, don't print the title
get_unique_object_count () {
	[ -z "$2" ] && echo -n "Unique objects: "

	filter_by_region $1 |
	wc -l |
	sed 's/^ *//'
}

# takes in inputfile and a flag,
# if flag is present this is the only command being run, don't print the title
get_most_frequent_object () {
	[ -z "$2" ] && echo -n "Most frequent object: "

	filter_by_region $1 |
	awk 'BEGIN{ max=0; obj="" }\
		{ if ($(NF - 1) > max) {max=$(NF - 1); obj=$2} }END \
		{print obj}'
}

# takes in inputfile and a flag,
# if flag is present this is the only command being run, don't print the title
get_total_bytes_transferred () {
	[ -z "$2" ] && echo -n "Total bytes transferred: "

	filter_by_region $1 |
	awk '{sum += $NF} END {print sum}'
}

# takes in inputfile and a flag,
# if flag is present this is the only command being run, don't print the title
get_requests_per_second () {
	[ -z "$2" ] && echo -n "Requests per second: "

	filter_by_region $1 |
	awk '{sum += $(NF - 1)} END {printf "%.*f\n", 2, sum / 60 / 60 }'
}

# takes in inputfile and a flag,
# if flag is present this is the only command being run, don't print the title
get_largest_object () {
	[ -z "$2" ] && echo -n "Largest object: "

	filter_by_region $1 |
	awk 'BEGIN{ max=0; obj="" }\
		{ if (($NF / $(NF - 1)) > max) \
		{max = ($NF / $(NF - 1)); obj=$2} }END \
		{print obj}'
}

# takes in inputfile as only argument
filter_by_region () {
	if [ "$REGION" != "all" ]; then
		zgrep "^$REGION[\. ]" $1
	else
		gzcat $1
	fi
}

# call main function
main "$@"
