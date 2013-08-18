%% ====================================================================
%% @author Tonami SUMIYAMA <smymtnm@gmail.com>
%% @version 0.1
%% @doc Daruma Appilcation's data type utility module 
%% @end
%% ====================================================================

-module(daruma_page_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-define(DEFOULT_PAGE, "index.html").

init(_Transport, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    Html = get_html(),
    {ok, Req2} = cowboy_req:reply(200,
        [{<<"content-type">>, <<"text/html">>}],
        Html, Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.

get_html() ->
    {ok, Cwd} = file:get_cwd(),
    WelcomePage = case application:get_env(daruma, welcome_page) of
                      {ok,Value}->Value;
                      _->?DEFOULT_PAGE
                  end,
    Filename =filename:join([Cwd, "priv", WelcomePage]),
    {ok, Binary} = file:read_file(Filename),
    Binary.
