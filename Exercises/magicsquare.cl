% A magic square is a N x N square grid (where N is the number of cells on each side)
% filled with distinct positive integers in the range 1,2,...,N^2 such that each cell
% contains a different integer and the sum of the integers in each row, column and diagonal is equal.
% The sum is called the magic constant or magic sum of the magic square.

#const n=3.

row(1..n).
col(1..n).
diag(1..n).
value(1..n*n).
magic_constant((n * (n * n + 1)) / 2).

% in ogni cella ci deve essere un valore
1 {magic_cell(R,C,V) : value(V)} 1 :- col(C), row(R).

% ogni valore corrisponde ad una cella diverse
1 {magic_cell(R,C,V) : col(C), row(R)} 1 :- value(V).

row_OK(R) :- S = #sum { V : magic_cell(R,C,V), col(C) }, row(R), magic_constant(S).
column_OK(C) :- S = #sum { V: magic_cell(R,C,V), row(R) }, col(C), magic_constant(S).
firstdiagonal_OK :- S = #sum { V : magic_cell(D,D,V), diag(D) }, magic_constant(S).
seconddiagonal_OK :- S = #sum { V : magic_cell(R,n + 1 - R,V), row(R) }, magic_constant(S).

:- not n {row_OK(R)} n.
:- not n {column_OK(C)} n.
:- not 1 {firstdiagonal_OK} 1.
:- not 1 {seconddiagonal_OK} 1.

#show magic_cell/3.
#show magic_constant/1.
#show row_OK/1.
