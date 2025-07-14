function [cartas_usuario,cartas_computadora1,cartas_computadora2,cartas_comunitarias,posiciones]=jugada2_reparte_cartas(cartas,filas,columnas,cartasrepartidas,posiciones)

%Reparto de cartas para la computadora 2
disp('Se reparten cartas a computadora 2');
pause(1);
cartas_computadora2={};
for k=1:2
    while true
        filaazar2=randi(filas);
        columnaazar2=randi(columnas);
        if ~cartasrepartidas(filaazar2,columnaazar2)
            cartasrepartidas(filaazar2,columnaazar2)=true;
            carta2=cartas{filaazar2,columnaazar2};
            cartas_computadora2{end+1}=carta2; %Guardar la carta en la lista de la computadora 2
            posiciones{end+1}=[filaazar2,columnaazar2]; %Guardar la posición
            break; 
        end
    end
end
%Reparto de cartas para el Usuario
disp('Se reparten cartas a usuario');
pause(1);
cartas_usuario={};
for k=1:2
    while true
        filaazar=randi(filas);
        columnaazar=randi(columnas);
        %Controlar si la carta ya se repartio o no
        if ~cartasrepartidas(filaazar,columnaazar)
            cartasrepartidas(filaazar,columnaazar)=true;
            carta=cartas{filaazar,columnaazar};
            cartas_usuario{end+1}=carta; %Guardar la carta en la lista del usuario
            posiciones{end+1}=[filaazar,columnaazar]; %Guardar la posición de la carta del usuario
            break; 
        end
    end
end
%Reparto de cartas para la computadora 1
disp('Se reparten cartas a computadora 1');
pause(1);
cartas_computadora1={};
for k=1:2
    while true
        filaazar1=randi(filas);
        columnaazar1=randi(columnas);
        if ~cartasrepartidas(filaazar1,columnaazar1)
            cartasrepartidas(filaazar1,columnaazar1)=true;
            carta1=cartas{filaazar1,columnaazar1};
            cartas_computadora1{end+1}=carta1; %Guardar la carta en la lista de la computadora 1
            posiciones{end+1}=[filaazar1,columnaazar1]; %Guardar la posición
            break; 
        end
    end
end
%Reparto de 5 cartas comunitarias
cartas_comunitarias={};
for k=1:5
    while true
        filaazar3=randi(filas);
        columnaazar3=randi(columnas);
        if ~cartasrepartidas(filaazar3,columnaazar3)
            cartasrepartidas(filaazar3,columnaazar3)=true; %Marcar la carta como repartida
            comun=cartas{filaazar3,columnaazar3};
            cartas_comunitarias{end+1}=comun; %Guardar la carta en la lista de cartas comunitarias
            posiciones{end+1}=[filaazar3,columnaazar3]; %Guardar la posición
            break;
        end
    end
end

disp('————————————————————————————————————————————————————');
pause(1);
disp('Cartas usuario : ')
pause(1);
disp(cartas_usuario);
disp('————————————————————————————————————————————————————');
pause(1);