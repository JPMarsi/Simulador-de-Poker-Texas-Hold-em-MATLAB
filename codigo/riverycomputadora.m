function [OPTION, floptotal]=riverycomputadora(cartas_comunitarias, cartas_computadora, mapacartas)

floptotal=[cartas_comunitarias(1:5), cartas_computadora];

% Obtener los valores numéricos de las cartas (quitando el palo)
valores = cellfun(@(carta) mapacartas(carta(1:end-1)), floptotal);

% Ordenar los valores de mayor a menor
[valores_ordenados, idx] = sort(valores, 'descend');
cartas_ordenadas = floptotal(idx); % Reordenar cartas según valores

% Inicializar la mejor mano y puntaje
mano = 'Carta Alta';

%Analiza los juegos que se tiene y conforme a eso actua la computadora
if escaleracolor(cartas_ordenadas, valores_ordenados)
    if max(valores_ordenados) == 14 % Si el valor más alto es As (14)
        mejor_mano='Escalera Real';
        OPTION=1;
    else
        mejor_mano='Escalera de Color';
    end
    OPTION=1;
elseif poker(valores_ordenados)
    mejor_mano='Poker';
    OPTION=1;
elseif fullhouse(valores_ordenados)
    mejor_mano='Full';
    OPTION=1;
elseif color(cartas_ordenadas)
    mejor_mano='Color';
    OPTION=1;
elseif escalera(valores_ordenados)
    mejor_mano='Escalera';
    OPTION=1;
elseif trio(valores_ordenados)
    mejor_mano='Trío';
    OPTION=1;
elseif doblepareja(valores_ordenados)
    mejor_mano='Doble Pareja';
    OPTION=2;
elseif pareja(valores_ordenados)
    mejor_mano='Pareja';
    OPTION=2;
else
    mejor_mano='Carta Alta';
    OPTION=2;
end