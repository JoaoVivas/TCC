function [ acumulated_vector ] = acumulator( vector, initial_value )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

acumulated_vector = zeros(1,length(vector));
acumulated_vector(1) = vector(1)+initial_value;
for i=1:length(vector)-1
    acumulated_vector(i+1) = acumulated_vector(i)+vector(i+1);
end

