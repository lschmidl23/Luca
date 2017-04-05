%Chi in funtion von Druck und Temperatur berechnen

clear all; close all; clc;

load ('GV.mat');
load ('MK.mat');


kvec = MK(:,7);
pvec = 1:1:3;
% chivec = 0.9999:-(1/length(kvec)):0.0001;

ChiKP = [];

for ii = 1 : length(pvec)
    p = pvec(ii);
    for jj = 1 : length(kvec)             
        k = kvec(length(kvec)-jj);
        f = @(x) Kpfunc(x,p);
        g = @(x) f(x) - k;   
%         chi_zero = chivec(jj);
        chi_zero = 0.01;
        chi_star = fzero(g, chi_zero);   
        ChiKP(ii,jj) = chi_star;
        disp(ii),disp(jj),disp(chi_star);
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

% p = 1;
% x = linspace(-10,10);
% 
% 
% plot(x,Kpfunc(x,p))
% set(gca, 'YScale', 'log');
% grid on
% xlabel('\chi')
% ylabel('k')
% title(sprintf('p = %f', p))
