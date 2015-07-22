-module(sel).
-export([select/2, permutate/1]).

% select(List, N) -> selects all combinations of N elements from the list List
select([], _) ->
    [[]];
select(_, N) when N =< 0 ->
    [[]];
select(L, 1) ->
    [[E] || E <- L];
select([H|T], N) when N > 1, N < length([H|T]) ->
    [[H|S] || S <- select(T, N - 1)] ++ select(T, N);
select(L, N) when N =:= length(L) ->
    [L];
select(L, N) when N > length(L) ->
    [[]].


% permutate(List) -> returns all permutations of List
permutate([]) ->
    [[]];
permutate(L) ->
    [[E|P] || E <- L,
	      P <- permutate(L -- [E])].
