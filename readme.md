# vim-finance

* watcher: `while true; do sleep 2 && ./stock.sh nyse > .tmp; cat .tmp > .buf; done`
* vim: `call timer_start(2000, {-> execute('checktime')}, {'repeat': -1})`
