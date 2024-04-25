include "assignment2_data1.dzn";
include "globals.mzn";

int: graph_size;
int: start;
int: n_dests;
array[1..n_dests] of int: dests;

int: n_edges;
array[1..n_edges] of int: cities_1;
array[1..n_edges] of int: cities_2;
array[1..n_edges] of int: costs;

%array[1..graph_size] of int: x;

%int: x1 = x[1];
function set of int: get_set(int: x) = 
  {cities_2[i] | i in 1..n_edges where cities_1[i] = x} union
  {cities_1[i] | i in 1..n_edges where cities_2[i] = x}; %union
  %{x};

%var {cities_2[i] | i in 1..graph_size where cities_1[i] = 1}: x1;
var get_set(1) union {1}: x1;
var get_set(2): x2;
var get_set(3): x3;
var get_set(4): x4;
var get_set(5): x5;
var {1} union get_set(6): x6;


array[1..graph_size] of var int: x = [x1, x2, x3, x4, x5, x6];



constraint x[start] != start;
constraint subcircuit(x);

array[1..graph_size] of var bool: included = [i != x[i] | i in 1..graph_size];
%var 0..graph_size: count = sum([costs[i] | i in 1..graph_size where included[i]]);


var int : count = sum(i in 1..graph_size)(included[i]);
% Lägg till riktad kant från dest till source med negativ kostnad (?)

solve minimize count;
%solve satisfy;
output ["\([x[i] | i in 1..graph_size])"];
output ["\(x1)\n"];
output ["\(x)\n"];
output ["Cost: \(count)\n"];



