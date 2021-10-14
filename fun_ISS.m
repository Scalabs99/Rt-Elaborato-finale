function R=fun_ISS(c_tot,c_imp,n_sim,sigma)
%funzione per il calcolo del Rt tramite algoritmo ISS;
 
 c_diff=c_tot-c_imp; 
 l=length(c_tot); 
 R=ones(l,n_sim);
 my_shape=1.87;
 my_rate=0.28; 
 gamma=gampdf(1:l,my_shape,1/my_rate);
 gamma=gamma';
 %rng('shuffle'); %può avere senso metterlo qua? Meglio di no. Ma al momento
 %lo lascio commentato; 
 
%il loop parte da 2 perchè non ha senso calcolare Rt per t=1; 

for i=2:l %loop over the time series; 
 

  like_prev=likelihood(1,c_tot,c_diff,i,gamma);

  for p=1:(n_sim-1) %loop over MCMC iterations;
      
    R_prop=R(i,p)+sigma*randn;
    like_new=likelihood(R_prop,c_tot,c_diff,i,gamma);
    if rand < like_new/like_prev
        R(i,p+1)=R_prop;
        like_prev=like_new;
    else
        R(i,p+1)=R(i,p);     
    end
    
  end

end
 
function L=likelihood(R,c_tot,c_diff,t,gamma)
    c_tot_1=c_tot((t-1):-1:1); 
    gamma_1=gamma(1:(t-1));
    ii=find(c_tot_1);
    lambda=sum(gamma_1.*c_tot_1)/sum(gamma_1(ii)); %qui devo stare attento!!! 
    L=poisspdf(c_diff(t,1),R*lambda); 
end

 
end 