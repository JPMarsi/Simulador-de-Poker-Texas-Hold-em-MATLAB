function [ronda_completa]=logica_apuestasV10(FICHAS,opcion,aportes_ronda,fold_A,ronda_completa,contador_usuario,contador_PC1,contador_PC2,ALL_IN,ronda)
%  Funcion que se encarga de la logica durante las rondas de apuestas (preflop, flop, turn, river).
%  Se basa en los aportes de cada jugador; si estos son iguales, la ronda finaliza, de lo contrario, continua.
%
%  Sintaxis : [ronda_completa]=logica_apuestas(opcion,aportes,fold_A,ronda_completa)
%
%   - ronda_completa : Se encarga de finalizar las rondas de apuesta. (false=continua ronda ; true=termina ronda).
%   - opcion : Vector que guarda las opciones seleccionadas por los jugadores. (Se utiliza unicamente para los fold, cuyo valor es 3)
%   - aportes : Vector que guarda las apuestas de cada jugador durante todo el juego (NO por ronda).
%   - fold_A : Vector logico que indica que jugadores estan activos, es decir, muestra quien se ha retirado.

jug_AI=0;

%Evaluar jugadores "ALL IN"
if ALL_IN(1)==1
    jug_AI=jug_AI+1;
end
if ALL_IN(2)==1
    jug_AI=jug_AI+1;
end
if ALL_IN(3)==1
    jug_AI=jug_AI+1;
end

%jugador NO all in
jug_ALL_IN= find(ALL_IN==0);

if jug_AI>=1
    % Caso cuando solo un jugador está en ALL IN
    if jug_AI==1 && aportes_ronda(jug_ALL_IN(1))==aportes_ronda(jug_ALL_IN(2))
        ronda_completa=true;
        if (FICHAS(1)>0 && contador_usuario==0) || (FICHAS(2)>0 && contador_PC1==0) || (FICHAS(3)>0 && contador_PC2==0)
            ronda_completa=false; % Si algún jugador con fichas puede actuar, la ronda no termina
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ACA JOSEPH
    % Caso cuando dos jugadores están en ALL IN
    if jug_AI==2
        ronda_completa=true; %Todos los números son iguales, finaliza ronda
        if contador_usuario==0 || contador_PC1==0 || contador_PC2==0
            ronda_completa=false;
        end
    end
    if jug_AI==2 && ronda>1
        ronda_completa=true; %Todos los números son iguales, finaliza ronda
    end

    if jug_AI==3
        ronda_completa=true; %Todos los números son iguales, finaliza ronda
    end

else
    if aportes_ronda(1)==aportes_ronda(2) && aportes_ronda(2)==aportes_ronda(3) && mean(fold_A)==1 %Todos los jugadores estan activos y apostaron la misma cantidad
        ronda_completa=true; %Todos los números son iguales, finaliza ronda
        if contador_usuario==0 || contador_PC1==0 || contador_PC2==0
            ronda_completa=false;
        end

    elseif fold_A(1)==0 %Usuario se retiro
        if aportes_ronda(2)==aportes_ronda(3) %Dos jugadores estan activos y apostaron la misma cantidad
            ronda_completa=true; %Todos los números son iguales, finaliza ronda
        end
        if contador_PC1==0 || contador_PC2==0
            ronda_completa=false;
        end

    elseif fold_A(2)==0 %PC 1 se retiro
        if aportes_ronda(1)==aportes_ronda(3) %Dos jugadores estan activos y apostaron la misma cantidad
            ronda_completa=true; %Todos los números son iguales, finaliza ronda
        end
        if contador_usuario==0 || contador_PC2==0
            ronda_completa=false;
        end

    elseif fold_A(3)==0 %PC 2 se retiro
        if aportes_ronda(1)==aportes_ronda(2) %Dos jugadores estan activos y apostaron la misma cantidad
            ronda_completa=true; %Apuestas son iguales, finaliza ronda
        end
        if contador_usuario==0 || contador_PC1==0
            ronda_completa=false;
        end
    end
end

%Contar numeros 3 (representan los FOLD/retiros)
numero_tres=sum(opcion==3);

%Dos jugadores se retiran -> finaliza el juego
if numero_tres==2
    ronda_completa=true; %finaliza ronda
    return; %finaliza juego
end

