% A magic square is a N x N square grid (where N is the number of cells on each side)
% filled with distinct positive integers in the range 1,2,...,N^2 such that each cell
% contains a different integer and the sum of the integers in each row, column and diagonal is equal.
% The sum is called the magic constant or magic sum of the magic square.

#const n=3.

row(1..n).
col(1..n).
value(1..n*n).
magic_constant((n * (n * n + 1)) / 2).

% Every cell must be filled with a positive number.
1 {magic_cell(R,C,V) : value(V)} 1 :- col(C), row(R).

% Every cell must be filled with a distinct number.
:- magic_cell(R1,C1,V), magic_cell(R2,C2,V), 1 {R1 != R2; C1 != C2} 2.

%Given a row, the sum of its integers must be equal to the magic constant
row_OK(R) :- S = #sum { V : magic_cell(R,C,V), col(C) }, row(R), magic_constant(S).
%Given a column, the sum of its integers must be equal to the magic constant
column_OK(C) :- S = #sum { V: magic_cell(R,C,V), row(R) }, col(C), magic_constant(S).
%Given the primary diagonal, the sum of its integers must be equal to the magic constant
primarydiagonal_OK :- S = #sum { V : magic_cell(R,R,V), row(R) }, magic_constant(S).
%Given the secondary diagonal, the sum of its integers must be equal to the magic constant
secondarydiagonal_OK :- S = #sum { V : magic_cell(R,n + 1 - R,V), row(R) }, magic_constant(S).

% There must be exactly n rows in which the sum of their integers is equal to the magic constant.
:- not n {row_OK(R)} n.
% There must be exactly n columns in which the sum of their integers is equal to the magic constant.
:- not n {column_OK(C)} n.
% There must be exactly one primary diagonal in which the sum of its integers is equal to the magic constant.
:- not 1 {primarydiagonal_OK} 1.
% There must be exactly one secondary diagonal in which the sum of its integers is equal to the magic constant.
:- not 1 {secondarydiagonal_OK} 1.

#show magic_cell/3.
#show magic_constant/1.
