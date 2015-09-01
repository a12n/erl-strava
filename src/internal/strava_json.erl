-module(strava_json).

%% To/from JSON map functions
-export([to_activity/1, to_athlete/1, to_club/1, to_gear/1,
         to_segment/1, to_segment_effort/1]).

%%%===================================================================
%%% To/from JSON map functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @end
%%--------------------------------------------------------------------
-spec to_activity(map()) -> strava_activity:t().

to_activity(Map) ->
    maps:fold(
      fun({K, V}, Ans)
            when K =:= <<"id">>;
                 K =:= <<"external_id">>;
                 K =:= <<"upload_id">>;
                 K =:= <<"name">>;
                 K =:= <<"description">>;
                 K =:= <<"distance">>;
                 K =:= <<"moving_time">>;
                 K =:= <<"elapsed_time">>;
                 K =:= <<"total_elevation_gain">>;
                 K =:= <<"timezone">>;
                 K =:= <<"location_city">>;
                 K =:= <<"location_state">>;
                 K =:= <<"location_country">>;
                 K =:= <<"achievement_count">>;
                 K =:= <<"kudos_count">>;
                 K =:= <<"comment_count">>;
                 K =:= <<"athlete_count">>;
                 K =:= <<"photo_count">>;
                 K =:= <<"total_photo_count">>;
                 K =:= <<"trainer">>;
                 K =:= <<"commute">>;
                 K =:= <<"manual">>;
                 K =:= <<"private">>;
                 K =:= <<"flagged">>;
                 K =:= <<"gear_id">>;
                 K =:= <<"average_speed">>;
                 K =:= <<"max_speed">>;
                 K =:= <<"average_cadence">>;
                 K =:= <<"average_temp">>;
                 K =:= <<"average_watts">>;
                 K =:= <<"weighted_average_watts">>;
                 K =:= <<"kilojoules">>;
                 K =:= <<"device_watts">>;
                 K =:= <<"average_heartrate">>;
                 K =:= <<"max_heartrate">>;
                 K =:= <<"calories">>;
                 K =:= <<"has_kudoed">> ->
              Ans#{binary_to_atom(K, latin1) => V};
         ({<<"resource_state">>, Int}, Ans) -> Ans#{resource_state => Int}; % TODO
         ({<<"athlete">>, Term}, Ans) -> Ans#{athlete => to_athlete(Term)};
         ({<<"type">>, Str}, Ans) -> Ans#{type => Str}; % TODO
         ({<<"start_date">>, Str}, Ans) -> Ans#{start_date => Str}; % TODO
         ({<<"start_date_local">>, Str}, Ans) -> Ans#{start_date_local => Str}; % TODO
         ({<<"start_latlng">>, List}, Ans) -> Ans#{start_latlng => List}; % TODO
         ({<<"end_latlng">>, List}, Ans) -> Ans#{end_latlng => List}; % TODO
         ({<<"photos">>, List}, Ans) -> Ans#{photos => List}; % TODO
         ({<<"map">>, Term}, Ans) -> Ans#{map => Term};         % TODO
         ({<<"workout_type">>, Int}, Ans) -> Ans#{workout_type => Int}; % TODO
         ({<<"gear">>, Term}, Ans) -> Ans#{gear => to_gear(Term)}; % TODO
         ({<<"segment_efforts">>, List}, Ans) -> Ans#{segment_efforts => lists:map(fun to_segment_effort/1, List)};
         ({<<"splits_metric">>, _Term}, Ans) -> Ans;
         ({<<"splits_standard">>, _Term}, Ans) -> Ans;
         ({<<"best_efforts">>, _Term}, Ans) -> Ans;
         ({_K, _V}, Ans) -> Ans
      end, _Ans = #{}, Map).

%%%===================================================================
%%% To/from JSON map functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @end
%%--------------------------------------------------------------------
-spec to_athlete(map()) -> strava_athlete:t().

to_athlete(Map) ->
    maps:fold(
      fun({K, V}, Ans)
            when K =:= <<"id">>;
                 K =:= <<"firstname">>;
                 K =:= <<"lastname">>;
                 K =:= <<"profile_medium">>;
                 K =:= <<"profile">>;
                 K =:= <<"city">>;
                 K =:= <<"state">>;
                 K =:= <<"country">>;
                 K =:= <<"premium">>;
                 K =:= <<"follower_count">>;
                 K =:= <<"friend_count">>;
                 K =:= <<"mutual_friend_count">>;
                 K =:= <<"date_preference">>;
                 K =:= <<"email">>;
                 K =:= <<"ftp">>;
                 K =:= <<"weight">> ->
              Ans#{binary_to_atom(K, latin1) => V};
         ({<<"resource_state">>, Int}, Ans) -> Ans#{resource_state => Int}; % TODO
         ({<<"sex">>, Str}, Ans) -> Ans#{sex => Str}; % TODO
         ({<<"friend">>, Str}, Ans) -> Ans#{friend => Str}; % TODO
         ({<<"follower">>, Str}, Ans) -> Ans#{follower => Str}; % TODO
         ({<<"created_at">>, Str}, Ans) -> Ans#{created_at => Str}; % TODO
         ({<<"updated_at">>, Str}, Ans) -> Ans#{updated_at => Str}; % TODO
         ({<<"athlete_type">>, Int}, Ans) -> Ans#{athlete_type => Int}; % TODO
         ({<<"measurement_preference">>, Str}, Ans) -> Ans#{measurement_preference => Str}; % TODO
         ({<<"clubs">>, List}, Ans) -> Ans#{clubs => lists:map(fun to_club/1, List)};
         ({<<"bikes">>, List}, Ans) -> Ans#{bikes => lists:map(fun to_gear/1, List)};
         ({<<"shoes">>, List}, Ans) -> Ans#{shoes => lists:map(fun to_gear/1, List)};
         ({_K, _V}, Ans) -> Ans
      end, _Ans = #{}, Map).

%%%===================================================================
%%% To/from JSON map functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @end
%%--------------------------------------------------------------------
-spec to_club(map()) -> strava_club:t().

to_club(Map) ->
    maps:fold(
      fun({K, V}, Ans)
            when K =:= <<"id">>;
                 K =:= <<"name">>;
                 K =:= <<"profile_medium">>;
                 K =:= <<"profile">>;
                 K =:= <<"description">>;
                 K =:= <<"city">>;
                 K =:= <<"state">>;
                 K =:= <<"country">>;
                 K =:= <<"private">>;
                 K =:= <<"member_count">> ->
              Ans#{binary_to_atom(K, latin1) => V};
         ({<<"resource_state">>, Int}, Ans) -> Ans#{resource_state => Int}; % TODO
         ({<<"club_type">>, Str}, Ans) -> Ans#{club_type => Str}; % TODO
         ({<<"sport_type">>, Str}, Ans) -> Ans#{sport_type => Str}; % TODO
         ({_K, _V}, Ans) -> Ans
      end, _Ans = #{}, Map).

%%%===================================================================
%%% To/from JSON functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @end
%%--------------------------------------------------------------------
-spec to_gear(map()) -> strava_gear:t().

to_gear(Map) ->
    maps:fold(
      fun({K, V}, Ans)
         when K =:= <<"id">>;
              K =:= <<"primary">>;
              K =:= <<"name">>;
              K =:= <<"distance">>;
              K =:= <<"brand_name">>;
              K =:= <<"model_name">>;
              K =:= <<"description">> ->
              Ans#{binary_to_atom(K, latin1) => V};
         ({<<"resource_state">>, Int}, Ans) -> Ans#{resource_state => Int}; % TODO
         ({<<"frame_type">>, Int}, Ans) -> Ans#{frame_type => Int}; % TODO
         ({_K, _V}, Ans) -> Ans
      end, _Ans = #{}, Map).

%%%===================================================================
%%% To/from JSON functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @end
%%--------------------------------------------------------------------
-spec to_segment_effort(map()) -> strava_segment_effort:t().

to_segment_effort(Map) ->
    maps:fold(
      fun({K, V}, Ans)
            when K =:= <<"id">>;
                 K =:= <<"name">>;
                 K =:= <<"elapsed_time">>;
                 K =:= <<"moving_time">>;
                 K =:= <<"distance">>;
                 K =:= <<"start_index">>;
                 K =:= <<"end_index">>;
                 K =:= <<"average_cadence">>;
                 K =:= <<"average_watts">>;
                 K =:= <<"device_watts">>;
                 K =:= <<"average_heartrate">>;
                 K =:= <<"max_heartrate">>;
                 K =:= <<"kom_rank">>;
                 K =:= <<"pr_rank">>;
                 K =:= <<"hidden">> ->
              Ans#{binary_to_atom(K, latin1) => V};
         ({<<"resource_state">>, Int}, Ans) -> Ans#{resource_state => Int}; % TODO
         ({<<"activity">>, Term}, Ans) -> Ans#{activity => to_activity(Term)};
         ({<<"athlete">>, Term}, Ans) -> Ans#{athlete => to_athlete(Term)};
         ({<<"start_date">>, Str}, Ans) -> Ans#{start_date => Str}; % TODO
         ({<<"start_date_local">>, Str}, Ans) -> Ans#{start_date_local => Str}; % TODO
         ({<<"segment">>, Term}, Ans) -> Ans#{segment => to_segment(Term)};
         ({_K, _V}, Ans) -> Ans
      end, _Ans = #{}, Map).

%%%===================================================================
%%% To/from JSON functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @end
%%--------------------------------------------------------------------
-spec to_segment(map()) -> strava_segment:t().

to_segment(Map) ->
    maps:fold(
      fun({K, V}, Ans)
            when K =:= <<"id">>;
                 K =:= <<"name">>;
                 K =:= <<"distance">>;
                 K =:= <<"average_grade">>;
                 K =:= <<"maximum_grade">>;
                 K =:= <<"elevation_high">>;
                 K =:= <<"elevation_low">>;
                 K =:= <<"city">>;
                 K =:= <<"state">>;
                 K =:= <<"country">>;
                 K =:= <<"private">>;
                 K =:= <<"starred">>;
                 K =:= <<"total_elevation_gain">>;
                 K =:= <<"effort_count">>;
                 K =:= <<"athlete_count">>;
                 K =:= <<"hazardous">>;
                 K =:= <<"star_count">> ->
              Ans#{binary_to_atom(K, latin1) => V};
         ({<<"resource_state">>, Int}, Ans) -> Ans#{resource_state => Int}; % TODO
         ({<<"activity_type">>, Str}, Ans) -> Ans#{activity_type => Str}; % TODO
         ({<<"start_latlng">>, List}, Ans) -> Ans#{start_latlng => List}; % TODO
         ({<<"end_latlng">>, List}, Ans) -> Ans#{end_latlng => List}; % TODO
         ({<<"climb_category">>, Int}, Ans) -> Ans#{climb_category => Int}; % TODO
         ({<<"created_at">>, Str}, Ans) -> Ans#{created_at => Str}; % TODO
         ({<<"updated_at">>, Str}, Ans) -> Ans#{updated_at => Str}; % TODO
         ({<<"map">>, Term}, Ans) -> Ans#{map => Term};             % TODO
         ({_K, _V}, Ans) -> Ans
      end, _Ans = #{}, Map).