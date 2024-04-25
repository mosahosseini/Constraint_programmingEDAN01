include "assignment4_1_1.dzn";
%include "assignment4_1_2.dzn";
%include "assignment4_1_3.dzn";
%include "assignment4_2_4.dzn";


include "globals.mzn";
include "cumulative.mzn";
int: del_add;
int:del_mul;
int: number_add;
int: number_mul;
int: n;
set of int :last;
set  of int: add;
set of int: mul;
array[1..n] of set of int: dependencies;
array [1..n] of var 0..100:t ;
% array [1..n] of var int: resources = [1 | i in 1..n];


constraint forall(i in 1..n , j in dependencies[i])(
  t[i] + (i in mul) * del_mul + (i in add) * del_add <= t[j]); 

constraint cumulative( [t[i] | i in add], [del_add | i in  1..length(add)], [1 | i in  1..length(add)] ,number_add);

constraint cumulative([t[i] | i in mul], [del_mul | i in 1..length(mul)], [1 | i in  1..length(mul)] ,number_mul);

var int: cost = max([t[i] + (i in mul) * del_mul + (i in add) * del_add | i in last]);

solve minimize(cost);

output[show(cost)];