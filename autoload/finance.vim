let s:plugdir = expand('<sfile>:p:h:h')
if(!exists("g:finance_refresh_rate"))
	let g:finance_refresh_rate = 2000
endif
fu! finance#ticker()
	set filetype=finance-ticker
	execute printf('edit %s/.buf', s:plugdir)
	let s:job_id = jobstart(printf('%s/ticker.sh nyse -o %s', s:plugdir, s:plugdir))
	set autoread
	call timer_start(g:finance_refresh_rate, {-> execute('checktime')}, {'repeat': -1})
endfu
