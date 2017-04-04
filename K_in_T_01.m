%Temperaturabhängigkeit der Gleichgewichtskonstante K(T)
clear all
close all
clc

% Reaktion = 4 H2 + 1 CO2 <-> 1 CH4 + 2 H2O

load ('GV.mat');
R1 = R *10^-3; % J ==> kJ
KS = 7.7*10^19; % K bei 298 K

%Temperaturabhängigkeit von den molaren Wärmekapazitäten 
%Spalte 1 %H2,Spalte 2 CO2,Spalte 3 CH4,Spalte 4 H2O
Ti = TS : 1300;
for n1 = 1 : length(Ti);
    T = Ti(n1);
    MK(n1,:) = [CpTH2(T), CpTCO2(T), CpTCH4(T), CpTH2O(T)];
    
end

%DeltaRCpTi differenz der molaren Wärmekapazität bei Termperatur T in J/(mol K)
%Spalte 5
for n2 = 1 : length(Ti)
    MK(n2,5) = v_h2.*MK(n2,1)+v_co2.*MK(n2,2)+v_ch4.*MK(n2,3)+v_h2o.*MK (n2,4);
end

intDeltaCp = cumtrapz (Ti,MK(:,5));
%Temperaturabhängigkeit der Reaktionsenthalpie
%Spalte 6
for n3 = 1 : length(Ti);
    MK(n3,6) = DeltaRH0 + intDeltaCp(n3,:)*10^-3;
end

vT = [400 500 600 700 800 900 1000 1100]; % Temperaturvektor in Kelvin
DeltaRHTV = [-170.172 -174.862 -179.070 -182.771 -185.953 -188.658 -190.894 -192.816]; %Tabellenwerte ReaktionsenthalpiekJ/mol


%Temperaturabhängigkeit der Gleichgewichtskonstante K(T)
%Spalte 7
for n4 = 1 : length(Ti);
    y1(n4,1) = [MK(n4,6)./(Ti(n4).^2)];
end
intDeltaHT = cumtrapz (Ti,y1);

for n5 = 1 : length(Ti);
    MK(n5,7) = KS*exp((R1)^-1*intDeltaHT(n5,:));
end

% Werte von MK in .mat Dateispeicher
save('MK.mat','MK','-append');

% Vergleichswerte, aus der literatur 
Ksoft = [7.7*10^19 2.58*10^12 8.24*10^7 6.93*10^4 394 7.55 0.332 0.0263];%Tabellenwerte
vT2 = [289 400 500 600 700 800 900 1000];% Temperaturvektor Kelvin

%Plot Temperaturabhängigkeit der Gleichgewichtskonstante K(T)
figure 
hold on
subplot(2,1,1);
plot(Ti,MK(:,7),'r-');
grid on
grid minor
hold on
plot(vT2,Ksoft,'bd');
set(gca, 'YScale', 'log');
title('Temperature dependence of the equilibrium constant');
xlabel('Temperature  [T] = K');
xlim([250 1350]);
ylabel('Equilibrium constant K_eq');

%Plot Temperaturabhängigkeit der Reaktionsenthalpie
subplot(2,1,2);
plot(Ti,MK(:,6),'r-');
grid on
grid minor
hold on
plot(vT,DeltaRHTV,'bd');
title('Temperature dependence of the reaction enthalpy \Delta_{R}H(T)');
xlabel('Temperature  [T] = K');
xlim([250 1350]);
ylabel('Reaction enthalpy [\Delta_{R}H(T)] = kJ/mol');


% Plots mit Plotname und Datum Speicher 

% t = datetime('now','TimeZone','local','Format','d-MMM-y_HH-mm-ss');
% DateString = datestr(t);
% plotname = ['Plot_K-T_DeltaH-T','-',DateString,'.jpg'];
% new_plotname = strrep(plotname,':','_');
% new_plotname = strrep(new_plotname,' ','_');
% saveas(gcf,new_plotname);

