-module(gs_clock).
-export([start/1,init/1,loop/2]).
 
start(Pid) -> P = spawn_link(?MODULE,init,[Pid]), {ok,P}.
 
init(Pid) ->
	io:format("New process: ~p~n", [?MODULE]),
	Port = open_port({spawn, "gs -q -dNOSAFER"}, [{line,127}]), 
        timer:sleep(500),
	port_command(Port, "(header.eps) run\n"),
	self() ! {tick},
	timer:send_interval(10000, {tick}),
	loop(Pid,Port).

loop(Pid,Port) ->
	receive
		{tick} -> {_,{H,M,_S}} = calendar:local_time(),
			Pstr = io_lib:format("del clockface ~p ~p newhour minute\n",[H,M]),
			port_command(Port, Pstr),
			?MODULE:loop(Pid,Port);
		_Any ->  % io:format("~p got unknown msg: ~p~n",[?MODULE, _Any]),
			?MODULE:loop(Pid,Port)
	end.

 

