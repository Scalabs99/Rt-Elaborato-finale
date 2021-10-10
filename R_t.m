function R_t(Giorni,Infetti,inv_g)
%Funzione che calcola l'Rt sui dati in input e restituisce il plot;
l=length(Infetti); %definisco la lunghezza del vettore degli infetti; 

Giorni=Giorni.'; 

R=zeros(1,l-1); 

for i=1:(l-1)
    
   R(1,i)=1+(inv_g)/(Infetti(i,1))*(Infetti(i+1,1)-Infetti(i,1));
end 

%Aggiungiamo anche la media mobile sui dati, in modo da rendere la curva 
%più smooth. La media mobile verrà fatta sulla settimana che finisce con il
%giorno considerato 

R_mm=zeros(1,l-7); 

for n=1:(l-7)
    for p=0:6
        R_mm(1,n)=R_mm(1,n)+R(1,n+p);
    end
    R_mm(1,n)=(R_mm(1,n))/7;
end 

Giorni_2(:,1)=datetime(2020,03,18)+caldays(0:l-8);

%plotto il vettore giorni vs il vettore R; 
figure('Name','Andamento di Rt')
plot(Giorni,R,'r')
title('Andamento del Rt giornaliero 2020-2021')
grid on
grid minor
hold on
plot(Giorni_2,R_mm,'b') 
hold on 
yline(1,'--')
legend('Rt giornaliero','Media mobile','Rt=1')
end

