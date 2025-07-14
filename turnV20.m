function [FICHAS,aportes_juego,numero_tres,fold_A,opcion,all_in,botes,jug_AI,ALL_IN]=turnV20(FICHAS,orden_jugadores,aportes_juego,fold_A,opcion,all_in,botes,jug_AI,ALL_IN,ronda,cartas_computadora1,cartas_computadora2,mapacartas,cartas_comunitarias)

%INICIALIZACION DE VARIABLES --------------------------------------------------------------------------
aportes_ronda=[0,0,0]; %Inicializar aportes de cada ronda <<SE AGREGA con 0,0,0)>>
apuesta_actual=0; %La apuesta inicial es la ciega grande <<SE AGREGA con 0 para flop, turn y river>>
ronda_completa=false; %Inicializar ronda (false para iniciar el ciclo while) <<SE AGREGA>>

%Cuanta cuantas veces intervino un jugador por ronda <<SE AGREGAN con 0>>
contador_usuario=0;
contador_PC1=0;
contador_PC2=0;
%------------------------------------------------------------------------------------------------------

%[PARTE 2] Bucle de la ronda de apuestas preflop <<SI SE AGREGA)>>
while ronda_completa==false
    %Llamar a la lógica de apuestas para verificar si la ronda ha terminado
    [ronda_completa]=logica_apuestasV10(FICHAS,opcion,aportes_ronda,fold_A,ronda_completa,contador_usuario,contador_PC1,contador_PC2,ALL_IN,ronda);
    
    for k=1:3 %Orden de jugadores
        [ronda_completa]=logica_apuestasV10(FICHAS,opcion,aportes_ronda,fold_A,ronda_completa,contador_usuario,contador_PC1,contador_PC2,ALL_IN,ronda);
        %Cuando "logica_apuestas" entregue un true, entonces se finaliza la ronda
        if ronda_completa==true
            break;
        end
        i=orden_jugadores(k); %Jugador actual
        %USUARIO
        if i==1 && fold_A(i)==1 && FICHAS(i)>0 && all_in(i)==0 && botes~=3 && jug_AI~=2
            [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=manoplaV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN,ronda,cartas_computadora1,cartas_computadora2,mapacartas,cartas_comunitarias);
            contador_usuario=contador_usuario+1;
            pause(2);
        end
        %PC 1
        if i==2 && fold_A(i)==1 && FICHAS(i)>0 && all_in(i)==0 && botes~=3 && jug_AI~=2
            [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=manoplaV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN,ronda,cartas_computadora1,cartas_computadora2,mapacartas,cartas_comunitarias);
            contador_PC1=contador_PC1+1;
            pause(2);
        end
        %PC 2
        if i==3 && fold_A(i)==1 && FICHAS(i)>0 && all_in(i)==0 && botes~=3 && jug_AI~=2
            [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=manoplaV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN,ronda,cartas_computadora1,cartas_computadora2,mapacartas,cartas_comunitarias);
            contador_PC2=contador_PC2+1;
            pause(2);
        end
    end
end

%[PARTE 3.1] Finalizar juego (dos jugadores se retiraron) <<SE AGREGA)>>
numero_tres=sum(opcion==3); %Contar numeros 3 (representan los FOLD)

if numero_tres==2
    posicion_ganador=find(fold_A==1); %Encuentra la posición donde el valor es 1
    bote=sum(aportes_juego); %Calcular bote
    FICHAS(posicion_ganador)=FICHAS(posicion_ganador)+bote; %Agrega bote al ganador
    disp('———————————————————————————————————————————————');
    disp('Juego finalizado.');
    if posicion_ganador==1
        disp('¡¡GANO USUARIO!!');
    elseif posicion_ganador==2
        disp('¡¡GANO PC 1!!');
    elseif posicion_ganador==3
        disp('¡¡GANO PC 2!!');
    end
    disp('———————————————————————————————————————————————');
    return;
end

%[PARTE 3.2] Finalizar ronda de apuestas <<SE AGREGA)>>
conteo_unos=sum(ALL_IN==1);
if conteo_unos>=1
    fprintf('\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
    disp('Ronda de apuestas preflop finalizada.');
    fprintf('Fichas/Aportes de cada jugador : | USUARIO = %g/%g | PC1 = %g/%g | PC2 = %g/%g |\n',FICHAS(1),aportes_ronda(1),FICHAS(2),aportes_ronda(2),FICHAS(3),aportes_ronda(3)); %Mostrar fichas y aportes
    [BOTE_PRINCIPAL,BOTE_SECUNDARIO,BOTE_TERCIARIO,botes,jug_AI]=botes_paralelos(botes,ALL_IN,fold_A,aportes_juego,aportes_ronda);
    if botes==2 && (jug_AI==1 || jug_AI==2)
        fprintf('Apuesta Actual %g | Bote Principal : %g | Bote Secundario : %g\n',apuesta_actual,BOTE_PRINCIPAL,BOTE_SECUNDARIO); %Mostrar apuesta actual y botes (2)
    elseif botes==3 && (jug_AI==2 || jug_AI==3)
        fprintf('Apuesta Actual %g | Bote Principal : %g | Bote Secundario : %g | Bote Terciario : %g\n',apuesta_actual,BOTE_PRINCIPAL,BOTE_SECUNDARIO,BOTE_TERCIARIO); %Mostrar apuesta actual y botes (3)
    end

    fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');

else
    fprintf('\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
    disp('Ronda de apuestas preflop finalizada.');
    fprintf('Fichas/Aportes de cada jugador : | USUARIO = %g/%g | PC1 = %g/%g | PC2 = %g/%g |\n',FICHAS(1),aportes_ronda(1),FICHAS(2),aportes_ronda(2),FICHAS(3),aportes_ronda(3)); %Mostrar fichas y aportes
    bote = sum(aportes_juego); %Calcular bote
    fprintf('Apuesta Actual %g | Bote acumulado : %g\n',apuesta_actual,bote); %Mostrar apuesta actual y bote
    fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
end