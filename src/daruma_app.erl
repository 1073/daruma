%% ====================================================================
%% @author Tonami SUMIYAMA <smymtnm@gmail.com>
%% @version 0.1
%% @doc Daruma Appilcation
%% @end
%% ====================================================================

-module(daruma_app).
-behaviour(application).

%% API.
-export([
    start/2,
    stop/1
]).

%% API.
start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", daruma_page_handler, []},
            {"/websocket", daruma_ws_handler, []},
            {"/static/[...]", cowboy_static, [
                {directory, {priv_dir, daruma, [<<"static">>]}},
                {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
            ]}
        ]}
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}]),
    daruma_sup:start_link().

stop(_State) ->
    ok.
