# erlang_ghostscript_clock
 Use ghostscript as an erlang port and enjoy DisplayPostscript.

Install ghostscript from https://www.ghostscript.com

Install Erlang from https://www.erlang.org

Compile gs_clock.erl

erlc gs_clock.erl

Run the erlang console

erl

Start the clock, don't forget the ending dot.

gs_clock:start(self()).

