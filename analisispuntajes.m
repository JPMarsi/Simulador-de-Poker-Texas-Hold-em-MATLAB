function [mejor_mano1, puntaje_total1, mejor_mano2, puntaje_total2, mejor_mano3, puntaje_total3,MANO_VALOR1,MANO_VALOR2,MANO_VALOR3] = analisispuntajes(cartas_comunitarias, cartas_computadora1, cartas_computadora2, cartas_usuario, mapacartas)
    % Analizar las cartas de la computadora 1
    [mejor_mano1, puntaje_total1, cartas_completas1,MANO_VALOR]=analizarcom(cartas_comunitarias, cartas_computadora1, mapacartas, '1');
    MANO_VALOR1=MANO_VALOR;
    
    % Analizar las cartas de la computadora 2
    [mejor_mano2, puntaje_total2, cartas_completas2,MANO_VALOR]=analizarcom(cartas_comunitarias, cartas_computadora2, mapacartas, '2');
    MANO_VALOR2=MANO_VALOR;

    %Analizar las cartas del jugador
    [mejor_mano3, puntaje_total3, cartas_completas2,MANO_VALOR]=analizarcom(cartas_comunitarias, cartas_usuario, mapacartas, 'U');
    MANO_VALOR3=MANO_VALOR;

    % Mostrar resultados
    disp('--- Resultado Final ---');
    disp(['Computadora 1: ', mejor_mano1, ' con un puntaje total de ', num2str(puntaje_total1)]);
    disp(['Computadora 2: ', mejor_mano2, ' con un puntaje total de ', num2str(puntaje_total2)]);
    disp(['Usuario: ', mejor_mano3, ' con un puntaje total de ', num2str(puntaje_total3)]);
end