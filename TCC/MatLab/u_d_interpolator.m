function ud = u_d_interpolator(u1, u2, des)



for i=1:size(b_dt,2)
    the_v = [];
    the_des = [];
    the_a = [];
    the_delta_t = [];
    the_vi = [];
    the_dir = [];
    
    desi = b_des(i);   
    vi = b_v(i);
    acc = b_a(i);
    
    Nsteps = round(desi/step_size)-1;
    %Calcula o número de steps
    
%     if acc == 0
%         if Nsteps > 0
%             the_v = ones(1,Nsteps)*vi;
%             delta_t = step_size/vi;
%             the_delta_t = ones(1,Nsteps)*delta_t;
%             the_des = ones(1,Nsteps)*step_size;

% incializa vetores

%             last_des = desi-step_size*Nsteps;
% Calcula resto da interpolação

%             last_delta_t = last_des/vi;
%             last_vi = vi;

%             the_des = [the_des, last_des];
%             the_delta_t = [the_delta_t, last_delta_t];
%             the_v = [the_v, last_vi];
%             the_a = ones(1,Nsteps+1)*acc; 
%             the_dir = [b_dir(:,i)*ones(1,Nsteps),b_dir(:,i)];
%   Se acc == 0 incializa vetores
%
%         else
            the_des = desi;
            the_v = vi;
            the_delta_t = desi/vi;
            the_a = acc;
            the_dir = b_dir(:,i);
        end
    else
        if Nsteps > 0
            the_des = ones(1,Nsteps)*step_size;
            for j=1:Nsteps
                the_v(j) = (vi^2 + 2*acc*step_size*j).^0.5;       
            end
            the_vi = [vi,the_v(1:length(the_v)-1)];
            the_delta_t = (the_v-the_vi)/acc;
            last_des = desi-step_size*Nsteps;
            antlast_v = the_v(length(the_v));
            if antlast_v^2+2*acc*last_des <= 0
                last_v = 0;
            else
                last_v = (antlast_v^2+2*acc*last_des).^0.5;
            end
            last_delta_t = (last_v-antlast_v)/acc;
            the_des = [the_des,last_des];
            the_delta_t = [the_delta_t, last_delta_t];
            the_v = [the_v, last_v];
            the_a = ones(1,Nsteps+1)*acc; 
            the_dir = [b_dir(:,i)*ones(1,Nsteps),b_dir(:,i)];
        else
            the_des = desi;
            the_v = (vi^2+2*acc*desi).^0.5;
            the_delta_t = (the_v-vi)/acc;
            the_a = acc;
            the_dir = b_dir(:,i);
        end
        
    end
    v = [v, the_v];
    ddes = [ddes, the_des];
    dt = [dt, the_delta_t];
    a = [a, the_a];
    dir = [dir, the_dir];
end

end