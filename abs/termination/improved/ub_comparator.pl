/** <module> ub_comparator
Comparation of UB based on generating random values for the parameters and
fields

@author Enrique Martin-Martin <emartinm@ucm.es>
@year 2016
@license GPL
*/

:- module(ub_comparator, [compare_ub_show/2] ).

:- use_module(stdlib(utils),[ut_member/2, ut_nth/3, ut_length/2, ut_sort/2, ut_subseteq/2]).
:- use_module(library(random), [random_between/3]).
:- use_module(ub_checker, [compare_ubs/5]).


num_tests(200).
min_value(0).
max_value(1000).

ub_2_ub(UB, NUB, NNames, NV) :-
    ub_2_prolog(UB, [], [], [to_ub], NUB, NNames, NV).
    
ub_2_prolog(UB, NUB, NNames, NV) :-
    ub_2_prolog(UB, [], [], [to_prolog], NUB, NNames, NV).
    
ub_2_prolog(UB, Names, V, _Options, UB, Names, V) :-
    number(UB), !.
ub_2_prolog(UB, Names, V, _Options, Var, Names, V) :-
    atom(UB),
    ut_nth(P, Names, UB), !,
    ut_nth(P, V, Var).
ub_2_prolog(UB, Names, V, _Options, K, [UB|Names], [K|V] ) :-
    atom(UB), !.
ub_2_prolog(nat(UB), Names, V, Options, floor(max(NUB,0)), NNames, NV) :-
    % translates nat(X) into floor(max(X,0))
    ut_member(to_prolog, Options),
    !,
    ub_2_prolog(UB, Names, V, Options, NUB, NNames, NV).    
ub_2_prolog(nat(UB), Names, V, Options, nat(NUB), NNames, NV) :-
    % leaves nat(X)
    ut_member(to_ub, Options),
    !,
    ub_2_prolog(UB, Names, V, Options, NUB, NNames, NV).    
ub_2_prolog(max(F), Names, V, _Options, Var, Names, V) :-
    atom(F),
    ut_nth(P, Names, max(F)), !,
    ut_nth(P, V, Var).
ub_2_prolog(max(F), Names, V, _Options, K, [max(F)|Names], [K|V] ) :-
    atom(F), !.
ub_2_prolog(min(F), Names, V, _Options, Var, Names, V) :-
    atom(F),
    ut_nth(P, Names, min(F)), !,
    ut_nth(P, V, Var).
ub_2_prolog(min(F), Names, V, _Options, K, [min(F)|Names], [K|V] ) :-
    atom(F), !.
ub_2_prolog(UB, Names, V, Options, NUB, NNames, NV) :-    
    UB =.. [Head|Params],
    ub_2_prolog_list(Params, Names, V, Options, NParams, NNames, NV),
    NUB =.. [Head|NParams].
    
    
ub_2_prolog_list([], Names, V, _Options, [], Names, V).
ub_2_prolog_list([UB|R], Names, V, Options, [NUB|NR], NNames, NV) :-
    ub_2_prolog(UB, Names, V, Options, NUB, Names2, V2 ),
    ub_2_prolog_list(R, Names2, V2, Options, NR, NNames, NV).
    
%RG: param(mcons), param(mreq), param(nprod), field(buffer)
%  89+3*nat(mcons)+3*nat(mreq)+3*nat(nprod)+3*nat(nreq)+nat(max(buffer)/2-3/2)
%OC: param(nprod), param(nreq), field(buffer), param(mcons)
%  17+nat(nprod)* (18+nat(nreq)* (22+5*nat(max(buffer)/2-1/2)))+nat(mcons)* (18+25*nat(mreq))

%compare_ub( 89+3*nat(mcons)+3*nat(mreq)+3*nat(nprod)+3*nat(nreq)+nat(max(buffer)/2-3/2), 17+nat(nprod)* (18+nat(nreq)* (22+5*nat(max(buffer)/2-1/2)))+nat(mcons)* (18+25*nat(mreq)), Results). 
%compare_ub_show( 89+3*nat(mcons)+3*nat(mreq)+3*nat(nprod)+3*nat(nreq)+nat(max(buffer)/2-3/2), 17+nat(nprod)* (18+nat(nreq)* (22+5*nat(max(buffer)/2-1/2)))+nat(mcons)* (18+25*nat(mreq))). 

compare_ub_show( RGExp, OCExp ) :-
    compare_ub( RGExp, OCExp, Result ),
    compare_ub_checker(RGExp, OCExp, R),
    write((R, Result)),
    !.

compare_ub( RGExp, OCExp, Result ) :-
    ub_2_prolog(RGExp, RGUB, RGN, RGV),
    ub_2_prolog(OCExp, OCUB, OCN, OCV),
    compare_ub2( ub(RGN, RGV, RGUB), ub(OCN, OCV, OCUB), Result ).


compare_ub2( ub([], [], _RGUB), ub([], [], _OCUB), constant ) :-
    !.
compare_ub2( ub(RGN, RGV, RGUB), ub(OCN, OCV, OCUB), Result ) :-
    ut_length(RGN, L),
    ut_length(OCN, L),
    ut_sort(RGN, SortedRGN), %They shouldn't contain duplicates
    ut_sort(OCN, SortedOCN),
    ut_subseteq(SortedRGN, SortedOCN), 
    !,
    % The are defined wrt. the same set of parameters or fields
    compare_ub_random( ub(RGN, RGV, RGUB), ub(OCN, OCV, OCUB), Result ).
compare_ub2( ub(RGN, _RGV, _RGUB), ub(OCN, _OCV, _OCUB), incomparable(RGN,OCN) ).


compare_ub_random( ub(RGN, RGV, RGUB), ub(OCN, OCV, OCUB), ratio(Avg) ) :-
    num_tests(N),
    compare_ub_random2( ub(RGN, RGV, RGUB), ub(OCN, OCV, OCUB), N, [], Ratios ),
    average(Ratios, Avg).
    
compare_ub_random2( _, _, 0, Acc, Acc ).
compare_ub_random2( ub(RGN, RGV, RGUB), ub(OCN, OCV, OCUB), N, Acc, Ratios ) :-
    compare_ub_random_single( ub(RGN, RGV, RGUB), ub(OCN, OCV, OCUB), Ratio ),
    NP is N - 1,
    compare_ub_random2( ub(RGN, RGV, RGUB), ub(OCN, OCV, OCUB), NP, [Ratio|Acc], Ratios ).
    

compare_ub_random_single( ub(RGN, RGV, RGUB), ub(_, OCV, OCUB), Ratio ) :-
    copy_term( ub(RGN, RGV, RGUB), ub(RGN, RGVC, RGUBC) ),
    copy_term( ub(_, OCV, OCUB), ub(_, OCVC, OCUBC) ),
    min_value(Min),
    max_value(Max),
    get_random_values( RGV, Min, Max, Values),
    Values = RGVC,
    Values = OCVC,
    RG is RGUBC,
    OC is OCUBC,
    Ratio is RG / OC.
    %format("Names: ~p~n", [RGN]),
    %format("Values: ~p~n", [Values]),
    %format("valor RG: ~p~n", [RG]),
    %format("valor OC: ~p~n", [OC]),
    %format("Ratio: ~p~n", [Ratio]).
    
    
get_random_values([], _, _, []).
get_random_values( [_|R], Min, Max, [Val|RVal] ) :-
    random_between(Min, Max, Val),
    get_random_values(R, Min, Max, RVal ).  
    
    
average(L, R) :-
    average2( L, 0, 0, Sum, N),
    R is Sum / N. 
average2([], Sum, N, Sum, N).
average2([X|R], Sum, N, NSum, NN) :-
    SumP is Sum + X,
    NP is N + 1,
    average2(R, SumP, NP, NSum, NN).
    
    

compare_ub_checker(RG, OC, R) :-
    ub_2_ub(RG, RGUB, RGN, RGV),
    ub_2_ub(OC, OCUB, OCN, OCV),
    ut_length(RGN, L),
    ut_length(OCN, L),
    ut_sort(RGN, SortedRGN), %They shouldn't contain duplicates
    ut_sort(OCN, SortedOCN),
    ut_subseteq(SortedRGN, SortedOCN), 
    !,
    % The are defined wrt. the same set of parameters or fields
    RGV = OCV,
    copy_term(RGUB, RGUBCopy),
    copy_term(OCUB, OCUBCopy),
    % compare_ubs adds annotations in the variables
    compare_ubs(RGUB, OCUB, [], [], R1),
    compare_ubs(OCUBCopy, RGUBCopy, [], [], R2),
    %write(R1), write('    '), write(R2), nl,
    combine_results( R1, R2, R).
compare_ub_checker(_RG, _OC, different_vars).

combine_results( yes, yes, 'RG == OC').
combine_results( yes, no,  'RG <= OC').
combine_results( no,  yes, 'RG >= OC').
combine_results( no,  no,  'RG != OC').

