clc % limpa a tela de comando 
clear all % limpa todas as variaves
close all % fecha todas as figuras

acc_max = 1000;
jun_disv = 0.1;
step_size = 1;

points = curvnatorGcode(acc_max,jun_disv,step_size);
%%
global Np Temptot

optimal = [];
optimaly = [];

%tic % inicializacao da contagem de tempo

%deslocamento_ya(gridN1+1:gridN+gridN1)=0.01*sin(omega*delta*(1:gridN));
%velocidade_ya(gridN1+1:gridN+gridN1)=0.01*omega*cos(omega*delta*(1:gridN));

deslocamento_xb_entrada = points(1,:);
velocidade_xb_entrada = points(2,:);

deslocamento_xb = deslocamento_xb_entrada;
velocidade_xb = velocidade_xb_entrada;

deslocamento_yb_entrada = points(3,:);
velocidade_yb_entrada = points(4,:);

deslocamento_yb = deslocamento_yb_entrada;
velocidade_yb = velocidade_yb_entrada;

Temptot = sum(points(5,:));
deltats = points(5,:);

Np = size(deslocamento_xb_entrada,2);

% Funcao que sera minimizada
desvio_min = @(x) (x(2:Np+1) - deslocamento_xb_entrada)*(x(2:Np+1) - deslocamento_xb_entrada)'+(x(2+4*Np:5*Np+1) - deslocamento_yb_entrada)*(x(2 + 4*Np:5*Np+1) - deslocamento_yb_entrada)'

% Ai encima estamos minimizando o quadrado de todos os desvios entre a
% posicao requerida e posicao de entrada

% requerida       - posicao (inicialmente) gerada pelo gcode; posicao ideal
% simulada        - posicao do bico da impressora simulada com a entrada requerida sem controle

% entrada efetiva - posicao de entrada de acordo do sistema de controle
% real efetiva    - posicao do bico da impressora simulada com a entrada efetiva com controle


%  |||                    |||
%  |||                    |||
%  |||------------------- |||
%  |||                    |||
%  |||                    |||
%  -->       mola         -->
%   y     amortecedor      x
% requerida eh o y inicial do problema 
% simulada eh o x inicial do problema
% entrada efetiva eh o y final do problema 
% real efetiva eh o x final do problema


% Equacao de movimento do sistema

% m*x..+b*x.+k*x=k*y+b*y.

% passando a equacao acima pra espaco de estados;
% X.=A*X+F
%onde

%X.=[x.  x.. ]';
%X=[x  x. ]';
%A=[0 1 ; -k/m -b/m];
%F=[0 k*y+b*y'];


% Chute inicial dos parametros

deslocamento_x(1:Np)=deslocamento_xb(1:Np);
velocidade_x(1:Np)=velocidade_xb(1:Np);

deslocamento_y(1:Np)=deslocamento_yb(1:Np);
velocidade_y(1:Np)=velocidade_yb(1:Np);

% Essa variavel x representa o vetor de dados do problema;

%Para um dado valor de deslocamento tema seguinte configuracao:

% No ponto 1, a impressora esta na posicao inicial e com velocidade 0.
% O algoritmo eh livre pra encontrar a melhor trajetoria desde o ponto 1
% ateh o ponto gridN1

%Apos, entre os pontos 1+gridN1 e gridN+gridN1 a impressora deve serguir
%uma trajetoria pre definida 

% Por fim de 1+gridN+gridN1 a gridN+2*gridN1 impressora eh livre pra escolher uma
% trajetoria ateh parar. 

x(1)=Temptot;
x(2: 1 + Np)=deslocamento_x;
x(2 + 1*Np     : 1 + Np * 2)=velocidade_x;
x(2 + 2*Np     : 1 + Np * 3)=deslocamento_xb;
x(2 + 3*Np     : 1 + Np * 4)=velocidade_xb;
x(2 + 4*Np     : 1 + Np * 5)=deslocamento_y;
x(2 + 5*Np     : 1 + Np * 6)=velocidade_y;
x(2 + 6*Np     : 1 + Np * 7)=deslocamento_yb;
x(2 + 7*Np     : 1 + Np * 8)=velocidade_yb;
x(2 + 8*Np     : 1 + Np * 9)=deltats;

xx=x; % guardo o vetor x em outro vetor xx

% Dados da otimizacao 

% No linear inequality or equality constraints

A = [];
bx = [];
Aeq = [];
Beq = [];

% Valores minimos que o meu sistema nao pode alcancar

tempo=0;
deslocamento_xb_lb=-ones(1,Np)*.0001;
velocidade_xb_lb=-ones(1,Np)*1000;

deslocamento_x_lb=deslocamento_xb_lb;
velocidade_x_lb=velocidade_xb_lb;

deslocamento_yb_lb=-ones(1,Np)*.0001;
velocidade_yb_lb=-ones(1,Np)*1000;

deslocamento_y_lb=deslocamento_yb_lb;
velocidade_y_lb=velocidade_yb_lb;

deltats_lb(1:Np) = 0;

% Essa variavel x representa o vetor de dados do problema;

lb(1)=tempo;
lb(2: 1 + Np)=deslocamento_x_lb;
lb(2 + 1*Np     : 1 + Np * 2)=velocidade_x_lb;
lb(2 + 2*Np     : 1 + Np * 3)=deslocamento_xb_lb;
lb(2 + 3*Np     : 1 + Np * 4)=velocidade_xb_lb;
lb(2 + 4*Np     : 1 + Np * 5)=deslocamento_y_lb;
lb(2 + 5*Np     : 1 + Np * 6)=velocidade_y_lb;
lb(2 + 6*Np     : 1 + Np * 7)=deslocamento_yb_lb;
lb(2 + 7*Np     : 1 + Np * 8)=velocidade_yb_lb;
lb(2 + 8*Np     : 1 + Np * 9)=deltats_lb;

% upper bound

tempo=Temptot*1.1;
deslocamento_xb_ub(1:Np)=250;
velocidade_xb_ub(1:Np)=1000;

deslocamento_x_ub =deslocamento_xb_ub;
velocidade_x_ub =velocidade_xb_ub;

deslocamento_yb_ub(1:Np)=250;
velocidade_yb_ub(1:Np)=1000;

deslocamento_y_ub =deslocamento_yb_ub;
velocidade_y_ub =velocidade_yb_ub;

deltats_ub(1:Np) = 1;


% Essa variavel x representa o vetor de dados do problema;

ub(1)=tempo;
ub(2: 1 + Np)=deslocamento_x_ub;
ub(2 + 1*Np     : 1 + Np * 2)=velocidade_x_ub;
ub(2 + 2*Np     : 1 + Np * 3)=deslocamento_xb_ub;
ub(2 + 3*Np     : 1 + Np * 4)=velocidade_xb_ub;
ub(2 + 4*Np     : 1 + Np * 5)=deslocamento_y_ub;
ub(2 + 5*Np     : 1 + Np * 6)=velocidade_y_ub;
ub(2 + 6*Np     : 1 + Np * 7)=deslocamento_yb_ub;
ub(2 + 7*Np     : 1 + Np * 8)=velocidade_yb_ub;
ub(2 + 8*Np     : 1 + Np * 9)=deltats_ub;

%%

% Propiedades do otimizador

options = optimoptions(@fmincon, 'TolFun', 0.0000000001, 'MaxIter', 100000, ...
                       'MaxFunEvals', 700000, 'Display', 'iter', ...
                       'DiffMinChange', 0.0001, 'Algorithm', 'sqp');
% Solve for the best simulation time + control input

if isempty(optimal)
         optimal=xx;
end

   % Algorimo da otimizacao    
   nonlcon=@double_integrator_points;
   
optimal = fmincon(desvio_min,optimal, A, bx, Aeq, Beq, lb, ub, ...
              nonlcon,options);
          

tempo_total_convergido=optimal(1);
%tempo = deltat*(1:Np);
deslocamento_x_convergido=optimal(2: 1 + Np);
velocidade_x_convergido=optimal(2 + 1*Np     : 1 + Np * 2);
deslocamento_xb_convergido=optimal(2 + 2*Np     : 1 + Np * 3);
velocidade_xb_convergido=optimal(2 + 3*Np     : 1 + Np * 4); 
deslocamento_y_convergido=optimal(2  + 4*Np:1 + Np*5);
velocidade_y_convergido=optimal(2 + 5*Np     : 1 + Np * 6);
deslocamento_yb_convergido=optimal(2 + 6*Np     : 1 + Np * 7);
velocidade_yb_convergido=optimal(2 + 7*Np     : 1 + Np * 8);
deltats_convergido= optimal(2 + 8*Np     : 1 + Np * 9);

optimal = optimal/1.05;
%%
close all
hold on
plot (deslocamento_x_convergido,deslocamento_y_convergido, 'g')
plot (deslocamento_xb_convergido,deslocamento_yb_convergido, 'r')
plot (deslocamento_xb_entrada, deslocamento_yb_entrada,'b')
%plot(tempo,deslocamento_x_convergido)
%plot(tempo,deslocamento_xb_convergido)
%hold off
%figure
%hold on
%plot(deslocamento_x_convergido)
%plot(deslocamento_xb_convergido)
%plot(deslocamento_xb_entrada)
%legend('Real','Controle','Ideal')