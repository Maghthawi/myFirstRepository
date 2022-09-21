/* Bird identification system. */

go :- hypothesize(Bird),
      write('I guess that the Bird is: '),
      write(Bird),
      nl,
      undo.
      

hypothesize(grey_parrot)   :- grey_parrot, !.
hypothesize(canary)        :- canary, !.
hypothesize(ostrich)       :- ostrich, !.
hypothesize(penguin)       :- penguin, !.
hypothesize(duck)          :- duck, !.
hypothesize(unknown).             /* no diagnosis */


grey_parrot :- bird,  
           verify(has_grey_color),
           verify(can_talk).
           
canary :- bird,  
           verify(has_yellow_color), 
           verify(can_sing).

ostrich :- bird,  
           verify(can_not_fly), 
           verify(has_long_neck).
           
penguin :- bird, 
           verify(can_not_fly), 
           verify(swims),
           verify(is_black_and_white).
           
duck :- bird,
           verify(green_head),
           verify(quack_sound).

bird    :- verify(has_feathers), !.
bird    :- verify(flys); 
           verify(lays_eggs).
             



ask(Question) :-
    write('Does the Bird have the following attribute: '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.


verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.

