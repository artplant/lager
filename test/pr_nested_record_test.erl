-module(pr_nested_record_test).

-compile([{parse_transform, lager_transform}]).

-ifdef(TEST).

-record(a, {field1, field2}).
-record(b, {field1, field2}).

-include_lib("eunit/include/eunit.hrl").

nested_record_test() ->
    A = #a{field1 = x, field2 = y}, 
    B = #b{field1 = A, field2 = {}},
    Pr_B = lager:pr(B, ?MODULE),
    ?assertEqual({'$lager_record', b,
                    [{field1, {'$lager_record', a,
                                    [{field1, x},{field2, y}]}},
                     {field2, {}}]}, 
                   Pr_B).
-endif.
