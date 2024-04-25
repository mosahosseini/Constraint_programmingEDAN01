include "assignment2_data2.dzn";
include "globals.mzn";

int: graph_size;
int: start;
int: n_dests;
array[1..n_dests] of int: dests;

int: n_edges;
array[1..n_edges] of int: cities_1;
array[1..n_edges] of int: cities_2;
array[1..n_edges] of int: costs;

array[1..n_edges, 1..2] of int: edges = array2d(1..n_edges, 1..2, [if i mod 2 = 1 
                                                                   then cities_1[floor(i/2) + 1] 
                                                                   else cities_2[floor(i/2)] endif | i in 1..2*n_edges]);

array[1..graph_size] of int: balances = [if i = start then n_dests 
                                         else if i in dests then -1 
                                         else 0 endif endif | i in 1..graph_size];
                                         
array[1..n_edges] of var -n_dests..n_dests: flows;

constraint network_flow(edges, balances, flows);

var int: sum = sum([if flows[i] != 0 then costs[i] else 0 endif | i in 1..n_edges]);
solve minimize sum;

output ["\(flows)"];
output ["\(sum)"];