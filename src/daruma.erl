%% ====================================================================
%% @author Tonami SUMIYAMA <smymtnm@gmail.com>
%% @version 0.1
%% @doc Daruma Appilcation's data type utility module 
%% @end
%% ====================================================================


-module(daruma).

%% ====================================================================
%% API functions
%% ====================================================================
-export([
    start/0
]).

%% @doc Initialize
start()->
    application:start(lager),
    application:start(crypto),
    application:start(ranch),
    application:start(cowboy),
    application:start(daruma).

%% ====================================================================
%% Internal functions
%% ====================================================================


