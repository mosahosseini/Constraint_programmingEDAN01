include "globals.mzn";
int : n ;
int :n_prefs ;
array[ 1..n_prefs , 1..2] of 1..n : prefs ;

array[1..n_prefs] of var 1..n-1: prefDist;

array [1..n] of var 1..n : places;
%Make sure all positions are different
constraint alldifferent(places);

% calculate the distance between a person and their preference
constraint forall(i in 1..n_prefs)(
  prefDist[i] = abs(places[prefs[i, 1]] - places[prefs[i, 2]])
);

var int :max_dist = max(d in 1..n_prefs)(prefDist[d] );
solve minimize max_dist;

var int  : nr_satisfied = sum(i in 1..n_prefs)(prefDist[i] ==1);

output[ "placement :"  ,show(places),"    max distance :" ,show(max_dist),  "   number satisfied :" ,show(nr_satisfied)  ];