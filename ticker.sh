#!/bin/sh
test -z "$1" && echo Exchange not specified! >&2 && exit 1
case $1 in
	nyse)
		# symlist downloaded from eoddata
		# converted to csv with `s/\t.\+\n/,/g`, then all converted to lowercase
		# TODO: update symlist automatically with a headless browser and `sed`
		shift
		# check options
		while test $# != 0; do
			case $1 in
				-o) shift; OUTPUT=$(realpath $1);;
			esac
			shift
		done
		test -z "$OUTPUT" && OUTPUT=$(realpath .)
		symlist=$(cat .symlist-nyse | tr -d '\n')
		while true; do
			http get "https://query1.finance.yahoo.com/v7/finance/quote?lang=en-US&region=US&corsDomain=finance.yahoo.com&fields=symbol,marketState,regularMarketPrice&symbols=$symlist" | jq -r '.quoteResponse.result[] | [.symbol, .regularMarketPrice|tostring] | join(": ")' > "$OUTPUT/.tmp"
			cat "$OUTPUT/.tmp" > "$OUTPUT/.buf"
			sleep 2
		done;;
	*)
		echo "Exchange $1 is not supported!";;
esac
