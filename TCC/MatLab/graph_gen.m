%%
clc
clear all
close all

fcount_a = [
    483
    974
    1459
    1944
    2427
    2910
    3394
    3877
    4363
    4851
    5335
    5818
    6302
];

feas_a = [
    7.49E+03
    7.55E+03
    7.32E+03
    8.99E+03
    7.08E+03
    6.24E+03
    4.90E+03
    4.94E+03
    4.96E+03
    4.95E+03
    4.95E+03
    4.94E+03
    4.95E+03
];



plot(fcount_a, feas_a)
%hold on 
%plot(fcount_b, feas_b)
%plot(fcount_c, feas_c)

title ('Viabilidade x num_f Teste Padrao')
