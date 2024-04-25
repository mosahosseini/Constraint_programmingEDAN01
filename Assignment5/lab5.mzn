include "urban_7.dzn";
include "globals.mzn";
int: n ;
int: n_commercial;
% number of residential lots in the area
int: n_residential;
% index is the number of residential lots in the row/column
array [1..n+1] of -n..n:  point_distribution ;

array [1..n, 1..n] of var 0..1 : placing; 


% this function returns a vector which gives number of residential (1) in each row. 
function array[int] of var int: rowSums(array[1..n, 1..n] of var int: matrix) =
    [point_distribution[ sum(matrix[i,1..n])+1 ]| i in 1..n];

%same as above , but the vector contains column sum. 
function array[int] of var int: colSums(array[1..n, 1..n] of var int: matrix) =
    [point_distribution[ sum(matrix[1..n,i])+1 ]| i in 1..n];  

% this constraint ensure that correct number of residential and commertial locals have been placed. 
constraint sum(i in placing)(i==0) =n_commercial;
constraint sum(j in placing)(j==1) = n_residential;


% lex2 is a symmetry braking constraint which ensures that adjecent rows and columns should be of lexographical order 
constraint lex2(placing); 


var int: cost = sum(rowSums(placing) ) + sum(colSums(placing));
  
solve :: int_search(placing, smallest, indomain_max ) 
      minimize(-cost);

%solve maximize(cost);   % execution time for example 3 using solve maximize is 11s


output["Total points : " ++ show(cost) ++ "\n|"  ];
output[show(placing[r,c]) ++ if c == n /\ c + r<2*n then "|\n|" elseif r+c==2*n then "|\n"  else " " endif| r in 1..n, c in 1..n ];


