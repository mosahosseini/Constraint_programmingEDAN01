% Use this editor as a MiniZinc scratch book
include "globals.mzn" ;
int : n ;
int : n_prefs ;
array [1..n_prefs , 1..2] of 1..n: prefs;

array [1..n] of var 1..n :  place ;


%var int : cost =  sum(i in 1..n_prefs) ( place[ prefs[i,1] ]+1 == place[prefs[i,2]] \/ place[prefs[i,1]] - 1 == place[prefs[i,2]]  );

var int : cost =  sum(i in 1..n_prefs) ( abs( place[ prefs[i,1] ]- place[prefs[i,2]] ) ==1 );   %why this takes more time that the cost function above ? 

constraint   all_different(place);

solve maximize cost;
output[ "Placing:" , show(place) ,"   nr_preferences :" , show(cost)]

