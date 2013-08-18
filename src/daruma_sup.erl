%% ====================================================================
%% @author Tonami SUMIYAMA <smymtnm@gmail.com>
%% @version 0.1
%% @doc Daruma Appilcation's data type utility module 
%% @end
%% ====================================================================

-module(daruma_sup).
-behaviour(supervisor).

%% API.
-export([start_link/0]).

%% supervisor.
-export([init/1]).

%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% supervisor.

init([]) ->
    Procs = [],
    {ok, {{one_for_one, 10, 10}, Procs}}.
