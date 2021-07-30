% Author: Guilherme Kruger Bartels
% Date: 30/07/2021
% Code: https://github.com/guilhermebartels/Org_Hidroweb.git

% Section to import data obtained from HidroWeb.

clear all, close all, clc


cd('Data');
lista_Prec=textread('lista_Prec.txt','%s'); % Read the precipitation file names. 
lista_Cota=textread('lista_cota.txt','%s'); % Read the Stage files names. .
lista_Q=textread('lista_Q.txt','%s'); % Read the discharge file names..
cd ..

tic
cd('Data');


formatSpec = ['%f %f %s' repmat('%f', [1,72])];
formatDate = 'dd/mm/yyyy';
for i=1:length(lista_Prec) % Union of all precipitation files into a single structure
filename = strcat('chuvas_C_',lista_Prec{i,1},'.csv');
fid = fopen(filename);
P = textscan(fid,formatSpec,'Delimiter',';','Headerlines',13);
fclose(fid);
P{1,3} = datenum(P{1,3},formatDate); 
Prec.(strcat('P',lista_Prec{i})) = [P{:}];
clear P
end

formatSpec = ['%f %f %s' repmat('%f', [1,75])];
for i=1:length(lista_Q) % Union of all discharge files in a single structure
filename = strcat('vazoes_C_',lista_Q{i,1},'.csv');
fid = fopen(filename);
Q = textscan(fid,formatSpec,'Delimiter',';','HeaderLines',14);
fclose(fid);
Q{1,3} = datenum(Q{1,3},formatDate);
Vazoes.(strcat('Q',lista_Q{i})) = [Q{:}];
clear Q
end

formatSpec = ['%f %f %s %s' repmat('%f', [1,74])];
formatHour='dd/mm/yyyy HH:MM:SS';

for i=1:length(lista_Cota) % Union of all stage files in a single structure
filename = strcat('cotas_C_',lista_Cota{i,1},'.csv');
fid = fopen(filename);
C = textscan(fid,formatSpec,'Delimiter',';','HeaderLines',14);
fclose(fid);
C{1,3} = datenum(C{1,3},formatDate);
empties = cellfun('isempty',C{1,4});
[~, ~, ~, H, ~, ~] = datevec(C{1,4}(~empties),formatHour);
Z = NaN(length(C{1,4}),1);
Z(~empties) = H;
C{1,4} = Z;
Cotas.(strcat('C',lista_Cota{i})) = [C{:}];
clear C Z empties
end

cd ..
toc


%% Section to organize data with Org_Hidroweb.m

tic
for i = 1 : length(lista_Prec) % Organization of precipitation data
    Dados = Prec.(strcat('P',lista_Prec{i}));  
    Processados.(strcat('P',lista_Prec{i})) = Org_Hidroweb(Dados,2,1,NaN,NaN,NaN,3,NaN,14);
end
for i = 1 : length(lista_Q) % Organization of discharge data
    Dados = Vazoes.(strcat('Q',lista_Q{i}));  
    Processados.(strcat('Q',lista_Q{i})) = Org_Hidroweb(Dados,1,1,1,NaN,5,3,4,17);
end
for i = 1 : length(lista_Cota) % Organization of stage data
    Dados = Cotas.(strcat('C',lista_Cota{i}));  
    Processados.(strcat('C',lista_Cota{i})) = Org_Hidroweb(Dados,1,1,1,NaN,5,3,4,17); 
end
toc



