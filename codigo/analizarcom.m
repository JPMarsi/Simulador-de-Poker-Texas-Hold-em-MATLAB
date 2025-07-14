function [mejor_mano, puntaje_total, cartas_completas,MANO_VALOR]=analizarcom(cartas_comunitarias, cartas_computadora, mapacartas, numero_computadora)
MANO_VALOR=0; %Inicializar valor de
    % Combinar las cartas comunitarias con las cartas de la computadora
    cartas_totales=[cartas_comunitarias, cartas_computadora];
    
    % Obtener los valores numéricos de las cartas (quitando el palo)
    valores = cellfun(@(carta) mapacartas(carta(1:end-1)), cartas_totales);

    % Ordenar los valores de mayor a menor
    [valores_ordenados, idx]=sort(valores, 'descend');
    cartas_ordenadas=cartas_totales(idx); % Reordenar cartas según valores

    % Inicializar la mejor mano y puntaje
    mejor_mano='Carta Alta';
    puntaje_mano=0;
    puntaje_valor=max(valores_ordenados);  % Puntaje por la carta más alta inicialmente

    % Puntaje base por tipo de jugada (Escalera Real es la mejor)
    puntaje_manos=containers.Map({'Escalera Real', 'Escalera de Color', 'Poker', 'Full', 'Color', 'Escalera', ...
                                    'Trío', 'Doble Pareja', 'Pareja', 'Carta Alta'}, ...
                                    [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]);

    % Verificar la mejor jugada posible
    if escaleracolor(cartas_ordenadas, valores_ordenados)
        if max(valores_ordenados)==14 % Si el valor más alto es As (14)
            mejor_mano = 'Escalera Real';
            if numero_computadora=='1'
                MANO_VALOR=10;
            end
            if numero_computadora=='2'
                MANO_VALOR=10;
            end
            if numero_computadora=='U'
                MANO_VALOR=10;
            end
        else
            mejor_mano = 'Escalera de Color';
            if numero_computadora=='1'
                MANO_VALOR=9;
            end
            if numero_computadora=='2'
                MANO_VALOR=9;
            end
            if numero_computadora=='U'
                MANO_VALOR=9;
            end
        end
    elseif poker(valores_ordenados)
        mejor_mano = 'Poker';
        if numero_computadora=='1'
            MANO_VALOR=8;
        end
        if numero_computadora=='2'
            MANO_VALOR=8;
        end
        if numero_computadora=='U'
            MANO_VALOR=8;
        end
    elseif fullhouse(valores_ordenados)
        mejor_mano = 'Full';
        if numero_computadora=='1'
            MANO_VALOR=7;
        end
        if numero_computadora=='2'
            MANO_VALOR=7;
        end
        if numero_computadora=='U'
            MANO_VALOR=7;
        end
    elseif color(cartas_ordenadas)
        mejor_mano = 'Color';
        if numero_computadora=='1'
            MANO_VALOR=6;
        end
        if numero_computadora=='2'
            MANO_VALOR=6;
        end
        if numero_computadora=='U'
            MANO_VALOR=6;
        end
    elseif escalera(valores_ordenados)
        mejor_mano = 'Escalera';
        if numero_computadora=='1'
            MANO_VALOR=5;
        end
        if numero_computadora=='2'
            MANO_VALOR=5;
        end
        if numero_computadora=='U'
            MANO_VALOR=5;
        end
    elseif trio(valores_ordenados)
        mejor_mano = 'Trío';
        if numero_computadora=='1'
            MANO_VALOR=4;
        end
        if numero_computadora=='2'
            MANO_VALOR=4;
        end
        if numero_computadora=='U'
            MANO_VALOR=4;
        end
    elseif doblepareja(valores_ordenados)
        mejor_mano = 'Doble Pareja';
        if numero_computadora=='1'
            MANO_VALOR=3;
        end
        if numero_computadora=='2'
            MANO_VALOR=3;
        end
        if numero_computadora=='U'
            MANO_VALOR=3;
        end
    elseif pareja(valores_ordenados)
        mejor_mano = 'Pareja';
        if numero_computadora=='1'
            MANO_VALOR=2;
        end
        if numero_computadora=='2'
            MANO_VALOR=2;
        end
        if numero_computadora=='U'
            MANO_VALOR=2;
        end
    else
        mejor_mano = 'Carta Alta';
        if numero_computadora=='1'
            MANO_VALOR=1;
        end
        if numero_computadora=='2'
            MANO_VALOR=1;
        end
        if numero_computadora=='U'
            MANO_VALOR=1;
        end
    end
    
    % Puntaje de la mano según el tipo de jugada
    puntaje_mano=puntaje_manos(mejor_mano);
    
    % Resolver empates: Desempatar basándonos en el valor de las cartas restantes
    cartas_unicas=unique(valores_ordenados, 'stable'); % Mantener el orden original para resolver empates
    puntaje_valor=sum(cartas_unicas(1:4));  % Consideramos hasta 4 cartas para desempatar
    
    % El puntaje total será la suma del puntaje de la mano y el valor de las cartas más altas
    puntaje_total=puntaje_mano * 10 + puntaje_valor;  % Multiplicar por 10 para dar más peso a la mano

    % Mostrar la jugada de la computadora
    cartas_completas=[cartas_comunitarias, cartas_computadora];

end
