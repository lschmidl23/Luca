%Chi in funtion von Druck und Temperatur berechnen

clear all; close all; clc;

load ('GV.mat');
load ('MK.mat');

kvec = MK(:,7);
pvec = 1:1:10;

ChiKP = [];

for ii = 1 : length(pvec)
    for jj = 400:500%1 : length(kvec)
        
        p = pvec(ii);
        k = kvec(jj);    
        f = @(x) Kpfunc(x,p);
        g = @(x) f(x) - k;                       
        chi_zero = 0.9;
        chi_star = fzero(g, chi_zero)   
        ChiKP(ii,jj) = chi_star;
        disp(ii);disp(jj);
    end
end

disp (ChiKP);


% x = linspace(0,1);
%                 semilogy(x, f(x))
%                 grid on
%                 xlabel('\chi')
%                 ylabel('k')
%                 title(sprintf('p = %f', p))
%                 clear x