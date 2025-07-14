function [valor1, valor2, fuerza]=fuerzaini(cartas_computadora, mapacartas)
    % Acceder a la tabla de probabilidades
    fuerzas = [85, 68, 67, 66, 64, 63, 62, 62, 61, 60, 60, 59, 59;
               66, 83, 64, 64, 63, 61, 59, 58, 57, 56, 55, 55, 55;
               65, 62, 80, 61, 59, 58, 56, 55, 54, 53, 52, 51, 51;
               64, 65, 62, 78, 59, 57, 56, 54, 53, 52, 51, 50, 50;
               64, 63, 62, 60, 75, 56, 55, 53, 52, 50, 50, 50, 50;
               63, 62, 60, 58, 57, 73, 54, 53, 51, 50, 49, 48, 48;
               62, 61, 59, 57, 56, 54, 71, 51, 50, 49, 48, 48, 47;
               61, 59, 58, 56, 55, 53, 51, 69, 50, 48, 48, 47, 47;
               60, 58, 57, 55, 54, 52, 51, 50, 67, 48, 47, 47, 46;
               60, 57, 56, 54, 53, 51, 50, 48, 48, 64, 47, 46, 46;
               59, 56, 54, 53, 52, 50, 49, 48, 47, 47, 61, 45, 45;
               58, 55, 53, 52, 50, 49, 48, 47, 46, 46, 45, 59, 45;
               57, 54, 52, 50, 49, 48, 47, 46, 46, 46, 45, 45, 51];

    carta1_valor=cartas_computadora{1}(1:end-1);  % Obtener solo el valor de la primera carta
    carta2_valor=cartas_computadora{2}(1:end-1);  % Obtener solo el valor de la segunda carta
    
    valor1=mapacartas(carta1_valor);
    valor2=mapacartas(carta2_valor);
    
    % Acceder a la tabla de probabilidades
    fuerza=fuerzas(valor1, valor2);
end