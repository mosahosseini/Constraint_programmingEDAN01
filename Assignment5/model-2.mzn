include "lex2.mzn";
include "urban_3.dzn";
% --- pars ---
% all lots are occupied

%% feedback : i don't know if this is nessessary , but may be it is better to add a constraint that ensures the right number of commersial and residential are placed in the grid e.i constraint sum( i in grid)(i==0)= n_commersial and sum( i in grid)(i)=n_residential
constraint n*n = n_commercial + n_residential; 


% row/column lenght
par int : n;

% number of commercial lots in the area
par int : n_commercial;

% number of residential lots in the area
par int : n_residential;

% index is the number of residential lots in the row/column
array[1..n+1] of par int : point_distribution;


% --- vars ---
% a matrix with boolean values, 1 being residential and 0 commercial
array[1..n, 1..n] of var {0, 1} : grid;

% Using the lexicagraphical order as explained in 6.2.2 in the book
constraint lex2(grid);
%%feedback have you tested lexless constraint ? 

% per row, how many residential are there
array[1..n] of var 0..n : rows;
constraint forall(i in 1..n) (rows[i] = sum([grid[j, i] | j in 1..n]));
constraint sum(rows) = n_residential;  
%% feedback : if sum(rows) = n_residential, then it implies that the sum(cols) = n_residential

array[1..n] of var 0..n : cols;
constraint forall(i in 1..n) (cols[i] = sum([grid[i, j] | j in 1..n]));
constraint sum(cols) = n_residential;


var int : points = points();
function var int : points() = 
  sum([point_distribution[i+1] | i in rows])+
  sum([point_distribution[i+1] | i in cols]);

%% Have u tried using search instead of solve maximize try for example: 
% solve :: int_search(grid, smallest, indomain_max )  
%  minimize(-points);
% this  is much more efficient for the urban_3.dzn where the computation time is reduced to less than a 1s

solve maximize points;

output[ 
    "points: \(points)\n",
    "rows: \([show_int(2, i) | i in rows])\n",
    "cols: \([show_int(2, i) | i in cols])\n",
    "grid: \n",
    show2d(grid)
];

