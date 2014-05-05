sel(X, [X|Rest], Rest).
sel(X, [Y|Rest], [Y|Z]) :- sel(X, Rest, Z).

permutation([], []).
permutation(X, [E|P]) :- sel(E, X, Rest), permutation(Rest, P).

partitioned([], _, [], []).
partitioned([X|R], E, [X|L1], L2) :- X =< E, partitioned(R, E, L1, L2).
partitioned([X|R], E, L1, [X|L2]) :- X > E, partitioned(R, E, L1, L2).

%% selection sort

minElement([X], X).
minElement([E|Rest], E) :- minElement(Rest, M1), E =< M1.
minElement([E|Rest], M1) :- minElement(Rest, M1), E > M1.

selSort([], []).
selSort(L1, [M | LL2]) :- 
    minElement(L1, M), 
    select(M, L1, LL1),
    selSort(LL1, LL2).

%% quick sort

append([], X, X).
append([X|R], Y, [X|Z]) :- append(R, Y, Z).

quickSort([], []).
quickSort([H|Rest], AL2) :-
    partitioned(Rest, H, Small, Large),
    quickSort(Small, SL1),
    quickSort(Large, SL2),
    append(SL1, [H], AL1),
    append(AL1, SL2, AL2).

%% bubble sort

bubble([], []).
bubble([H], [H]).
bubble([X,Y|R], [X|SR]) :- X =< Y, bubble([Y|R], SR).
bubble([X,Y|R], [Y|SR]) :- X > Y, bubble([X|R], SR).

bubble_loop(L, 1, L1) :- bubble(L, L1), !.
bubble_loop(L, N, L2) :- bubble(L, L1), N1 is N - 1, bubble_loop(L1, N1, L2).

bubbleSort(L1, L2) :- length(L1, Len), bubble_loop(L1, Len, L2).

%% insertion sort

maxElement([X], X).
maxElement([H|Rest], H) :- maxElement(Rest, M), H > M.
maxElement([H|Rest], M) :- maxElement(Rest, M), H =< M.

insertSort([], []).
insertSort(L1, L4) :-
    maxElement(L1, M),
    select(M, L1, L2),
    insertSort(L2, L3),
    append(L3, [M], L4).
