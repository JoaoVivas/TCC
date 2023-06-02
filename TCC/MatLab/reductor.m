function [ x ] = reductor( x0, reduction )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[x0_row, x0_col] = size(x0);

x_col = ceil(x0_col/reduction);
x_row = x0_row;

x = zeros(x_row, x_col);

for i = 1:x_col
    for j = 1:x_row
        x(j,i) = x0(j,i + ((reduction-1)*(i-1)));
    end
end

for j = 1:x_row
    x(j,x_col) = x0(j,x0_col);
end
