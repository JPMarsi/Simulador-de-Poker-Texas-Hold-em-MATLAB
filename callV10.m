function [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=callV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN)

diferencia=apuesta_actual-aportes_ronda(i); %Calculo de diferencia
if diferencia<=FICHAS(i) %La diferencia NO supera tus fichas
    FICHAS(i)=FICHAS(i)-diferencia; %Descuento de fichas
    %Agregar aportes del jugador (juego y ronda)
    aportes_juego(i)=aportes_juego(i)+diferencia;
    aportes_ronda(i)=aportes_ronda(i)+diferencia;
    fprintf('Iguala la apuesta con %g fichas.\n',diferencia);
    if FICHAS(i)==0
        fprintf('Hace ALL IN.\n');
        all_in(i)=1; %Jugador hace all in
        ALL_IN(i)=1; %Jugador hace all in (supremo)
    end
else
    %-----------------------------------------------------------------------------------
    if i==2 || i==3 %Computadora tiene menos fichas que call, pero tiene buena mano, procede a foldear
        opssion=1;
        fprintf('PC %g NO tiene suficientes fichas para igualar. Hace ALL IN\n',i-1);
    end
    %-----------------------------------------------------------------------------------
    if i==1
    fprintf('No tienes suficientes fichas para igualar.\napuesta actual : [%g] | tus fichas : [%g]\n',apuesta_actual,FICHAS(i));
    opssion_valida=false; %Bandera para controlar la validez de la opción
    while ~opssion_valida
        opssion=input('1 para all in - 2 para retirarte : ');
        if ismember(opssion,[1,2])
            opssion_valida=true; % Si se ingresa 1 o 2 la opción es válida
        else
            fprintf('Opción no válida. Por favor selecciona 1 o 2.\n');
        end
    end
    end
    switch opssion
        case 1 %ALL IN
            subida=FICHAS(i); %Ingreso de fichas
            FICHAS(i)=0; %Descuento de fichas [ALL IN]
            %Agregar aportes del jugador (juego y ronda)
            aportes_juego(i)=aportes_juego(i)+subida;
            aportes_ronda(i)=aportes_ronda(i)+subida;
            fprintf('Hace ALL IN.\n');
            all_in(i)=1; %Jugador hace all in
            ALL_IN(i)=1; %Jugador hace all in (supremo)
            % ______________POZOS PARALELOS
        case 2 %fold
            fold_A(i)=0; %Usuario ha hecho fold
            opcion(end+1)=3; %Guarda opcion para luego evaluar fold
    end
end