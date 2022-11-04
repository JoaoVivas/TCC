function [des,dir] = directionator(x,y)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
for i=1:(size(x,1)-1)
   des_x = x(i+1)-x(i);
   des_y = y(i+1)-y(i);
   des_vec(:,i) = [des_x;des_y];
   des(i) = norm(des_vec(:,i));
   dir(:,i) = des_vec(:,i)./des(i);
end
des(size(x,1)) = 0;
dir(:,size(x,1)) = [0;0];
end

