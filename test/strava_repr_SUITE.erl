-module(strava_repr_SUITE).

-include_lib("common_test/include/ct.hrl").

-export([all/0]).

-export([test_to_activity_comment/1,
         test_to_athlete/1]).

all() ->
    [ test_to_activity_comment,
      test_to_athlete ].

-define(test_call(Name, FunName),
        {JSON, ExpectedTerm} = load_data(Config, Name),
        Term = strava_repr:FunName(JSON),
        ct:pal("~p", [ExpectedTerm]),
        ct:pal("~p", [Term]),
        ExpectedTerm = Term).

test_to_activity_comment(Config) ->
    ?test_call(<<"activity_comment">>, to_activity_comment).

test_to_athlete(Config) ->
    ?test_call(<<"athlete">>, to_athlete).

load_data(Config, Name) ->
    DataDir = ?config(data_dir, Config),
    JSONPath = filename:join(DataDir, <<Name/bytes, ".json">>),
    TermPath = filename:join(DataDir, <<Name/bytes, ".erl">>),
    ct:pal("Loading '~s' files:~n"
           "~s~n~s", [Name, JSONPath, TermPath]),
    {ok, JSON} = file:read_file(JSONPath),
    {ok, [Term]} = file:consult(TermPath),
    {jsx:decode(JSON, [return_maps]), Term}.
