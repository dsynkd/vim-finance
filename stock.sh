#!/bin/sh
test -z "$1" && echo Exchange not specified! >&2 && exit 1
case $1 in
	cache)
		# updates symlist cache files
		# sed -i 's/\t.+\n/,/'
		;;
	nyse)
		# symlist downloaded from eoddata
		# converted to csv with `s/\t.\+\n/,/g`, then all converted to lowercase
		# not sure how to do this with `sed` yet, need non-greedy regex with `-z`
		symlist=$(cat .symlist-nyse | tr -d '\n')
		http get "https://query1.finance.yahoo.com/v7/finance/quote?lang=en-US&region=US&corsDomain=finance.yahoo.com&fields=symbol,marketState,regularMarketPrice&symbols=$symlist" | jq -r '.quoteResponse.result[] | [.symbol, .regularMarketPrice|tostring] | join(": ")';;
	*)
		echo "Exchange $1 is not supported!";;
esac
