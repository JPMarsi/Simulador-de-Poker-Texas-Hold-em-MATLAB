function [orden_jugadores,aportes_juego,aportes_ronda,FICHAS]=orden_y_ciegas(jugada,FICHAS,aportes_juego,aportes_ronda)

%!!!!!!!!!!!!!!!!!!! SI QUERES CAMBIAR CIEGAS, tambien debes actualizar el valor de "apuesta_actual" en la funcion prefloV10 (apuesta_actual debe ser igual a CG) 
CP=5; %Ciega Pequeña
CG=10; %Ciega Grande

%Determinar el orden de los jugadores en función de "jugada" y determina a quien le toca la ciega pequeña y grande
switch jugada
    case 1 %Modelo 1 : Usuario, PC1, PC2
        orden_jugadores=[1,2,3];
        FICHAS(2)=FICHAS(2)-CP; %Computadora 1 apuesta CP
        if FICHAS(2)<0
            FICHAS(2)=1;
        end
        %Ingreso de aportes
        aportes_juego(2)=CP;
        aportes_ronda(2)=CP;
        FICHAS(3)=FICHAS(3)-CG; %Computadora 2 apuesta CG
        if FICHAS(3)<0
            FICHAS(3)=1;
        end
        %Ingreso de aportes
        aportes_juego(3)=CG;
        aportes_ronda(3)=CG;

    case 2 %Modelo 2 : PC1, PC2, Usuario
        orden_jugadores=[2,3,1];
        FICHAS(3)=FICHAS(3)-CP; %Computadora 2 apuesta CP
        if FICHAS(3)<0
            FICHAS(3)=1;
        end
        %Ingreso de aportes
        aportes_juego(3)=CP;
        aportes_ronda(3)=CP;
        FICHAS(1)=FICHAS(1)-CG; %Usuario apuesta CG
        if FICHAS(1)<0
            FICHAS(1)=1;
        end
        %Ingreso de aportes
        aportes_juego(1)=CG;
        aportes_ronda(1)=CG;

    case 3 %Modelo 3 : PC2, Usuario, PC1
        orden_jugadores=[3,1,2];
        FICHAS(1)=FICHAS(1)-CP;  %Usuario apuesta CP
        if FICHAS(1)<0
            FICHAS(1)=1;
        end
        %Ingreso de aportes
        aportes_juego(1)=CP;
        aportes_ronda(1)=CP;
        FICHAS(2)=FICHAS(2)-CG; %Computadora 1 apuesta CG
        if FICHAS(2)<0
            FICHAS(2)=1;
        end
        %Ingreso de aportes
        aportes_juego(2)=CG;
        aportes_ronda(2)=CG;
end

%Mostrar quien paga ciegas pequeñas y grandes
if aportes_juego(2)==CP && aportes_juego(3)==CG
    fprintf('\n>>PC 1 paga CIEGA PEQUEÑA = %g fichas\n',CP);
    pause(2);
    fprintf('\n>>PC 2 paga CIEGA GRANDE = %g fichas\n',CG);
    pause(2);
elseif aportes_juego(3)==CP && aportes_juego(1)==CG
    fprintf('\n>>PC 2 paga CIEGA PEQUEÑA = %g fichas\n',CP);
    pause(2);
    fprintf('\n>>Usuario paga CIEGA GRANDE = %g fichas\n',CG);
    pause(2);
elseif aportes_juego(1)==CP && aportes_juego(2)==CG
    fprintf('\n>>Usuario paga CIEGA PEQUEÑA = %g fichas\n',CP);
    pause(2);
    fprintf('\n>>PC 1 paga CIEGA GRANDE = %g fichas\n',CG);
    pause(2);
else
end