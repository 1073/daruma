%% ====================================================================
%% @author Tonami SUMIYAMA <smymtnm@gmail.com>
%% @version 0.1
%% @doc @TODO
%% @end
%% ====================================================================

-module(daruma_ws_handler).
-behaviour(cowboy_websocket_handler).

-export([init/3]).

% web socket API
-export([
    websocket_init/3,
    websocket_handle/3,
    websocket_info/3,
    websocket_terminate/3
]).

-record(state, {nodes}).

init({tcp, http}, _Req, _Opts) ->
    {upgrade, protocol, cowboy_websocket}.

websocket_init(_TransportName, Req, _Opts) ->
    State = #state{nodes=get_node()},
    Result = jsonx:encode([{nodes, get_node()}]),
    erlang:start_timer(1000, self(), Result),
    {ok, Req, State}.

websocket_handle(_Data, Req, State) ->
    {ok, Req, State}.

websocket_info({timeout, _Ref, Msg}, Req, State) ->
    Result = jsonx:encode([{nodes, get_node()}]),
    erlang:start_timer(1000, self(), Result),
    {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
    ok.

get_node()->
    Nodes = nodes(connected),
    Nodes1 = [node() | Nodes],
    Nodes1.

