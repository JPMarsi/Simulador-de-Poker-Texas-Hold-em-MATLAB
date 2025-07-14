function [FICHAS]=gameV10(FICHAS,jugada)
%funcion que desarrolla un juego de poker. 
% Primero, reparte cartas.
% Segundo, inicia las rondas de apuestas. 
% Tercero, determina el ganador.

%Inicialización de las cartas
cartas={'2♠','3♠','4♠','5♠','6♠','7♠','8♠','9♠','10♠','J♠','Q♠','K♠','A♠';
        '2♥','3♥','4♥','5♥','6♥','7♥','8♥','9♥','10♥','J♥','Q♥','K♥','A♥';
        '2♦','3♦','4♦','5♦','6♦','7♦','8♦','9♦','10♦','J♦','Q♦','K♦','A♦';
        '2♣','3♣','4♣','5♣','6♣','7♣','8♣','9♣','10♣','J♣','Q♣','K♣','A♣'};

%Nuevo orden para la comparacion de las cartas frente a la matriz de fuerza inicial de mano 
mapacartas=containers.Map({'A','K','Q','J','10','9','8','7','6','5','4','3','2'},num2cell(1:13));

[filas,columnas]=size(cartas); %Tamaño de la Celda
cartasrepartidas=false(filas,columnas); %Rastreo de cartas repetidas
posiciones={}; %Celda para guardar las posiciones de cartas repartidas

%Reparto de cartas orden : 1-ciega pequeña ; 2-ciega grande ; 3-dealer
if jugada==1
[cartas_usuario,cartas_computadora1,cartas_computadora2,cartas_comunitarias]=jugada1_reparte_cartas(cartas,filas,columnas,cartasrepartidas,posiciones);
elseif jugada==2
[cartas_usuario,cartas_computadora1,cartas_computadora2,cartas_comunitarias]=jugada2_reparte_cartas(cartas,filas,columnas,cartasrepartidas,posiciones);
else
[cartas_usuario,cartas_computadora1,cartas_computadora2,cartas_comunitarias]=jugada3_reparte_cartas(cartas,filas,columnas,cartasrepartidas,posiciones);
end

%llamar FUNCION preFLOP
ronda=1; %Cuenta el numero de rondas (1 preflop)
[FICHAS,aportes_juego,numero_tres,fold_A,opcion,all_in,orden_jugadores,botes,jug_AI,ALL_IN]=preflopV10(FICHAS,jugada,ronda,cartas_computadora1,cartas_computadora2,mapacartas);

if numero_tres==2
    return
end

%llamar FUNCION FLOP
ronda=2; %Cuenta el numero de rondas (2 flop)
disp('Cartas FLOP : ');
disp(cartas_comunitarias(1:3));
pause(2);
[FICHAS,aportes_juego,numero_tres,fold_A,opcion,all_in,botes,jug_AI,ALL_IN]=flopV20(FICHAS,orden_jugadores,aportes_juego,fold_A,opcion,all_in,botes,jug_AI,ALL_IN,ronda,cartas_computadora1,cartas_computadora2,mapacartas,cartas_comunitarias);

if numero_tres==2
    return
end

%llamar FUNCION TURN
ronda=3; %Cuenta el numero de rondas (3 turn)
disp('Carta TURN : ');
disp(cartas_comunitarias(4));
pause(2);
[FICHAS,aportes_juego,numero_tres,fold_A,opcion,all_in,botes,jug_AI,ALL_IN]=turnV20(FICHAS,orden_jugadores,aportes_juego,fold_A,opcion,all_in,botes,jug_AI,ALL_IN,ronda,cartas_computadora1,cartas_computadora2,mapacartas,cartas_comunitarias);

if numero_tres==2
    return
end

%llamar FUNCION RIVER
ronda=4; %Cuenta el numero de rondas (4 river)
disp('Carta RIVER : ');
disp(cartas_comunitarias(5));
pause(2);
[FICHAS,bote,numero_tres,fold_A,opcion,all_in,botes,jug_AI,ALL_IN,aportes_juego,aportes_ronda]=riverV20(FICHAS,orden_jugadores,aportes_juego,fold_A,opcion,all_in,botes,jug_AI,ALL_IN,ronda,cartas_computadora1,cartas_computadora2,mapacartas,cartas_comunitarias);

if numero_tres==2
    return
end

%Union de cartas de cada jugador. Concatenación de dos celdas (privadas + comunitarias)
cartasFinalesUsuario=[cartas_usuario,cartas_comunitarias]; %Usuario
cartasFinalesComputadora1=[cartas_computadora1,cartas_comunitarias]; %PC 1
cartasFinalesComputadora2=[cartas_computadora2,cartas_comunitarias]; %PC2

%INFO EXTRA!
%Mostrar todas las cartas del usuario (privadas + comunitarias)
disp('Cartas finales del usuario (privadas + comunitarias):');
disp(cartasFinalesUsuario);
disp('Cartas finales de computadora 1 (privadas + comunitarias):');
disp(cartasFinalesComputadora1);
disp('Cartas finales de computadora 2 (privadas + comunitarias):');
disp(cartasFinalesComputadora2);

% Analisis de cartas y puntaje
[mejor_mano1,puntaje_total1,mejor_mano2,puntaje_total2,mejor_mano3,puntaje_total3,MANO_VALOR1,MANO_VALOR2,MANO_VALOR3]=analisispuntajes(cartas_comunitarias,cartas_computadora1,cartas_computadora2,cartas_usuario,mapacartas);

% Calcular jugador ganador
% Valores de las manos y puntajes de los jugadores
MANO_VALORES = [MANO_VALOR1, MANO_VALOR2, MANO_VALOR3];
PUNTAJES = [puntaje_total1, puntaje_total2, puntaje_total3];
JUGADORES = {'1', '2', 'U'};

% Ordenamos por el valor de la mano en orden descendente
[valores_ordenados, orden_mano]=sort(MANO_VALORES, 'descend');

% Inicializamos una matriz de posiciones para guardar el resultado final
posiciones_finales=cell(3,1); % Para los 3 jugadores

% Comprobamos si hay empate en la mano más alta
if valores_ordenados(1)==valores_ordenados(2)
    % Desempate entre el primer y segundo puesto
    if PUNTAJES(orden_mano(1))>PUNTAJES(orden_mano(2))
        posiciones_finales{1}=JUGADORES{orden_mano(1)};
        posiciones_finales{2}=JUGADORES{orden_mano(2)};
    else
        posiciones_finales{1}=JUGADORES{orden_mano(2)};
        posiciones_finales{2}=JUGADORES{orden_mano(1)};
    end
else
    % No hay empate, asignamos los puestos 1 y 2 directamente
    posiciones_finales{1}=JUGADORES{orden_mano(1)};
    posiciones_finales{2}=JUGADORES{orden_mano(2)};
end

% Comprobamos si hay empate en el tercer lugar (o en el segundo y tercer lugar)
if valores_ordenados(2)==valores_ordenados(3)
    % Desempate entre el segundo y tercer puesto
    if PUNTAJES(orden_mano(2))>PUNTAJES(orden_mano(3))
        posiciones_finales{2}=JUGADORES{orden_mano(2)};
        posiciones_finales{3}=JUGADORES{orden_mano(3)};
    else
        posiciones_finales{2}=JUGADORES{orden_mano(3)};
        posiciones_finales{3}=JUGADORES{orden_mano(2)};
    end
else
    % No hay empate, asignamos el puesto 3 directamente
    posiciones_finales{3}=JUGADORES{orden_mano(3)};
end

% Mostrar las posiciones finales
disp([posiciones_finales{1}, ' 1° puesto']);
disp([posiciones_finales{2}, ' 2° puesto']);
disp([posiciones_finales{3}, ' 3° puesto']);

conteo_unos=0;
conteo_unos=sum(ALL_IN==1);
if conteo_unos>=1
    fprintf('\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
    [BOTE_PRINCIPAL,BOTE_SECUNDARIO,BOTE_TERCIARIO,botes,jug_AI]=botes_paralelos(botes,ALL_IN,fold_A,aportes_juego,aportes_ronda);
    [jugadores_bote_principal, jugadores_bote_secundario, jugador_bote_terciario]=determinarBotes(aportes_juego, BOTE_PRINCIPAL, BOTE_SECUNDARIO, BOTE_TERCIARIO);
    FICHAS = distribuirFichas(FICHAS, posiciones_finales, aportes_juego, BOTE_PRINCIPAL, BOTE_SECUNDARIO, BOTE_TERCIARIO);
    fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
else
    fprintf('\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
    if posiciones_finales{1}=='1' && fold_A(2)==1
        FICHAS(2)=FICHAS(2)+bote;
    end
    if posiciones_finales{1}=='2' && fold_A(3)==1
        FICHAS(3)=FICHAS(3)+bote;
    end
    if posiciones_finales{1}=='U' && fold_A(1)==1
        FICHAS(1)=FICHAS(1)+bote;
    end
    fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
end
