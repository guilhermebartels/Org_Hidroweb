
function [Saida] = Org_Hidroweb(Dado_Est, Tipo, Consistencia,Media_diaria,Hora,Col_Media_diaria,Col_Data,Col_Hora,Col_Dia1)
% funcao para organizar os dados do Hidroweb
% Esta função facilita a utilização dos dados de precipitação, cota e vazão, disponibilizado no HidroWeb. 
% O Org_Hidroweb, realiza a conversão dos dados diários obtidos do HidroWeb, para um formato mais simplificado, 
% disposto em quatro colunas (Ano, Mês, Dia e Variável), facilitando a manipulação e análise das informações. 
% Todas as falhas existentes nas séries histórias, são identificadas e atribuído NaN (Not a Number).
%
%
% Saida = Org_Hidroweb(Dado_Est, Tipo, Consistencia,Media_diaria,Hora,Col_Media_diaria,Col_Data,Col_Hora,Col_Dia1)
%
%   Variáveis de entrada:
%
%         Dado_Est:             % Nome do arquivo
%         Tipo:                 % Tipo de dado: 1 = Fluviometrico; 2 = Pluviometrico
%         Consistencia:         % Nível de consistência: 1 = Bruto; 2 = Consistido 
%         Media_diaria:         % Utiliza o dado médio diario: 1 = Sim; 0 = Não; NaN = Dados Pluviometricos
%         Hora:                 % Horario da medida da variavel: 7 = 7 horas; 17 = 17 horas; NaN = média diaria ou total de precipitação (tipo Pluvimetrico); 
%         Col_Media_diaria:     % Coluna da media diaria: Geralmente coluna 5;   NaN = Dados Pluviometricos
%         Col_Data:             % Coluna data: Geralmente coluna 3
%         Col_Hora:             % Coluna da hora: Geralmente coluna 4; NaN = Dados Pluviometricos
%         Col_Dia1:             % coluna com os dados do dia 01 de cada mês: 
%                               - Geralmente coluna 17 para dados de vazão e cota 
%                               - Geralmente coluna 14 para dados de precipitação.
%
% Author: Guilherme Kruger Bartels
% Code: https://github.com/guilhermebartels/Org_Hidroweb.git


if Tipo == 1;


  if Hora == 7;
      Hora_Cod = 7;
  elseif Hora == 17;
      Hora_Cod = 17;
  else
      Hora_Cod = NaN;
  end

  
Ord = sortrows(Dado_Est,[Col_Data Col_Hora]);


if Media_diaria == 1;
sel = find(Ord(:,2)==Consistencia & Ord(:,Col_Media_diaria)==Media_diaria);
else
sel = find(Ord(:,2)==Consistencia & Ord(:,Col_Media_diaria)==Media_diaria & Ord(:,Col_Hora)==Hora_Cod);    
end


t = Ord(sel,Col_Data); 
dt = diff(t);                   
X = dt;           



day = 1;
for i = 1 : length(sel)
  if i < length(sel)  
    if X(i) <= 31;
    busca = Ord(sel(i),[Col_Dia1:(Col_Dia1+X(i)-1)]);
    else;
    busca = [Ord(sel(i),[Col_Dia1:Col_Dia1+30]) NaN(1,(X(i)-31))]; 
    end
    saida(day:(day+X(i)-1),1) = busca';
    day = length(saida)+1;
  else
    busca = Ord(sel(i),[Col_Dia1:Col_Dia1+30]);  
    saida(day:(day+30),1) = busca';
  end
end

dias = t(1,1): t(end,1)+30; dias = dias';
[Y,M,D] = datevec(dias);
Saida = [ Y M D saida];

else
    
  
  Ord = sortrows(Dado_Est,[Col_Data]);

  

  sel = find(Ord(:,2)==Consistencia);

  
  t = Ord(sel,Col_Data); 
  dt = diff(t);                   
  X = dt;  


  
  day = 1;
  for i = 1 : length(sel)
    if i < length(sel)  
      if X(i) <= 31;
      busca = Ord(sel(i),[Col_Dia1:(Col_Dia1+X(i)-1)]);
      else;
      busca = [Ord(sel(i),[Col_Dia1:Col_Dia1+30]) NaN(1,(X(i)-31))]; 
      end
      saida(day:(day+X(i)-1),1) = busca';
      day = length(saida)+1;
    else
      busca = Ord(sel(i),[Col_Dia1:Col_Dia1+30]);  
      saida(day:(day+30),1) = busca';
    end
  end

  dias = t(1,1): t(end,1)+30; dias = dias';
  [Y,M,D] = datevec(dias);
  Saida = [ Y M D saida];    

  end;
end