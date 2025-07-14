% ||+————————————————————————————————+||
% ||                                  ||
% ||   Texas Hold'Em Simulador v1.0   ||
% ||      (para tres jugadores)       ||
% ||                                  ||
% ||+————————————————————————————————+||
clc;clear;close all;

%Inicializar variables
contador=0; %Cuenta los juegos jugados
FICHAS=[1000,1000,1000]; %Fichas iniciales de cada jugador

while FICHAS(1)<3000 && FICHAS(1)>0 %Mientras el jugador tenga fichas entre 1 y 2999 el ciclo while continua
    for i=1:3
        if i==1
            contador=contador+1;
            fprintf('JUEGO N°%g———————————————————————————————————————————————\n',contador);
            jugada=1; %Modelo 1 : Usuario, PC1, PC2
            %Llamar a la función game
            [FICHAS]=gameV10(FICHAS,jugada);
            fprintf('Cantidad de fichas al finalizar Juego %g\nUsuario: %g    Computadora 1: %g    Computadora 2: %g\n',contador,FICHAS(1),FICHAS(2),FICHAS(3)); %Mostrar fichas de cada jugador
            if FICHAS(1)==0 %Si el jugador llega o 0 fichas se rompe el while
                break;
            end
            if FICHAS(1)==3000 %Si el jugador llega o 3000 fichas se rompe el while
                break;
            end
            pause(5);
        end
        if i==2
            contador=contador+1;
            fprintf('JUEGO N°%g———————————————————————————————————————————————\n',contador);
            jugada=2; %Modelo 2 : PC1, PC2, Usuario
            %Llamar a la función game
            [FICHAS]=gameV10(FICHAS,jugada);
            fprintf('Cantidad de fichas al finalizar Juego %g\nUsuario: %g    Computadora 1: %g    Computadora 2: %g\n',contador,FICHAS(1),FICHAS(2),FICHAS(3)); %Mostrar fichas de cada jugador
            if FICHAS(1)==0 %Si el jugador llega o 0 fichas se rompe el while
                break;
            end
            if FICHAS(1)==3000 %Si el jugador llega o 3000 fichas se rompe el while
                break;
            end
            pause(5);
        end
        if i==3
            contador=contador+1;
            fprintf('JUEGO N°%g———————————————————————————————————————————————\n',contador);
            jugada=3; %Modelo 3 : PC2, Usuario, PC1
            %Llamar a la función game
            [FICHAS]=gameV10(FICHAS,jugada); 
            fprintf('Cantidad de fichas al finalizar Juego %g\nUsuario: %g    Computadora 1: %g    Computadora 2: %g\n',contador,FICHAS(1),FICHAS(2),FICHAS(3)); %Mostrar fichas de cada jugador
            if FICHAS(1)==0 %Si el jugador llega o 0 fichas se rompe el while
                break;
            end
            if FICHAS(1)==3000 %Si el jugador llega o 3000 fichas se rompe el while
                break;
            end
        end
        pause(5);
    end
end

%Mensajes finales, muestran si el usuario gano o perdio
if FICHAS(1)>=3000 
    disp('Ganaste el juego');
elseif FICHAS(1)<=0
    disp('Perdiste el juego');
end