function [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=manoplaV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN,ronda,cartas_computadora1,cartas_computadora2,mapacartas,cartas_comunitarias)

%INICIO - Informacion condensada para el Command Window---------------------------------------------------------------------------------------------------------------------------------------------------
if i==1
    fprintf('\n');
    disp('>>Turno de Usuario');
    disp('————————————————————————————————————————————————————');
    fprintf('Fichas/Aportes de cada jugador : | USUARIO = %g/%g | PC1 = %g/%g | PC2 = %g/%g |\n',FICHAS(1),aportes_ronda(1),FICHAS(2),aportes_ronda(2),FICHAS(3),aportes_ronda(3)); %Mostrar fichas y aportes
    bote = sum(aportes_juego); %Calcular bote
    fprintf('Apuesta Actual %g | Bote acumulado : %g\n',apuesta_actual,bote); %Mostrar apuesta actual y bote
    disp('————————————————————————————————————————————————————');
elseif i==2
    fprintf('\n');
    disp('>>Turno de PC 1');
    disp('————————————————————————————————————————————————————');
    bote = sum(aportes_juego); %Calcular bote
    fprintf('Apuesta Actual %g | Bote acumulado : %g\n',apuesta_actual,bote); %Mostrar apuesta actual y bote
    disp('————————————————————————————————————————————————————');
else
    fprintf('\n');
    disp('>>Turno de PC 2');
    disp('————————————————————————————————————————————————————');
    bote = sum(aportes_juego); %Calcular bote
    fprintf('Apuesta Actual %g | Bote acumulado : %g\n',apuesta_actual,bote); %Mostrar apuesta actual y bote
    disp('————————————————————————————————————————————————————');
end
%FIN - Informacion condensada para el Command Window------------------------------------------------------------------------------------------------------------------------------------------------------
pause(1);

if aportes_ronda(i)==apuesta_actual || apuesta_actual==0 %Condiciones para utilizar check en vez de call
    opcion_valida=false; %Bandera para controlar la validez de la opción
    while ~opcion_valida
        if i==2
            if ronda==1
                [valor1,valor2,fuerza]=fuerzaini(cartas_computadora1,mapacartas);
                if fuerza<45
                    OPTION=3;
                else
                    [OPTION]=preflopcom(cartas_computadora1,mapacartas);
                end
                if OPTION==1
                    disp('PC 1 hace Raise');
                end
                if OPTION==2
                    disp('PC 1 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 1 hace Fold');
                end
            end
            if ronda==2
                [OPTION]=flopycomputadora(cartas_comunitarias,cartas_computadora1,mapacartas);
                if OPTION==1
                    disp('PC 1 hace Raise');
                end
                if OPTION==2
                    disp('PC 1 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 1 hace Fold');
                end
            end
            if ronda==3
                [OPTION]=turnycomputadora(cartas_comunitarias,cartas_computadora1,mapacartas);
                if OPTION==1
                    disp('PC 1 hace Raise');
                end
                if OPTION==2
                    disp('PC 1 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 1 hace Fold');
                end
            end
            if ronda==4
                [OPTION]=riverycomputadora(cartas_comunitarias,cartas_computadora1,mapacartas);
                if OPTION==1
                    disp('PC 1 hace Raise');
                end
                if OPTION==2
                    disp('PC 1 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 1 hace Fold');
                end
            end
        end
        if i==3
            if ronda==1
                [valor1,valor2,fuerza]=fuerzaini(cartas_computadora2,mapacartas);
                if fuerza<45
                    OPTION=3;
                else
                    [OPTION]=preflopcom(cartas_computadora2,mapacartas);
                end
                if OPTION==1
                    disp('PC 2 hace Raise');
                end
                if OPTION==2
                    disp('PC 2 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 2 hace Fold');
                end
            end
            if ronda==2
                [OPTION]=flopycomputadora(cartas_comunitarias,cartas_computadora2,mapacartas);
                if OPTION==1
                    disp('PC 2 hace Raise');
                end
                if OPTION==2
                    disp('PC 2 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 2 hace Fold');
                end
            end
            if ronda==3
                [OPTION]=turnycomputadora(cartas_comunitarias,cartas_computadora2,mapacartas);
                if OPTION==1
                    disp('PC 2 hace Raise');
                end
                if OPTION==2
                    disp('PC 2 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 2 hace Fold');
                end
            end
            if ronda==4
                [OPTION]=riverycomputadora(cartas_comunitarias,cartas_computadora2,mapacartas);
                if OPTION==1
                    disp('PC 2 hace Raise');
                end
                if OPTION==2
                    disp('PC 2 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 2 hace Fold');
                end
            end
        end
        if i==1
            fprintf('1 Bet/Raise [>=%g fichas] - 2 Check - 3 Fold : ',apuesta_actual*2);
            OPTION = input('');
        end
        if ismember(OPTION,[1,2,3])
            opcion_valida=true; %Si se ingresa 1, 2 o 3 la opción es válida
        else
            fprintf('Opción no válida. Por favor selecciona 1, 2 o 3.\n');
        end
    end
    opcion(end+1)=OPTION; %Guarda opcion para luego evaluar fold
    switch OPTION
        case 1 %Bet/Raise
            [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=betV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN);
        case 2 %Check
            disp('Ha elegido Check');
        case 3 %Fold
            fold_A(i)=0; %Usuario ha hecho fold
    end
else %Se utiliza call en vez de check
    opcion_valida1=false; %Bandera para controlar la validez de la opción
    while ~opcion_valida1
        if i==2
            if ronda==1
                [valor1,valor2,fuerza]=fuerzaini(cartas_computadora1,mapacartas);
                if fuerza<45
                    OPTION=3;
                else
                    [OPTION]=preflopcom(cartas_computadora1,mapacartas);
                end
                if OPTION==1
                    disp('PC 1 hace Raise');
                end
                if OPTION==2
                    disp('PC 1 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 1 hace Fold');
                end
            end
            if ronda==2
                [OPTION]=flopycomputadora(cartas_comunitarias,cartas_computadora1,mapacartas);
                if OPTION==1
                    disp('PC 1 hace Raise');
                end
                if OPTION==2
                    disp('PC 1 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 1 hace Fold');
                end
            end
            if ronda==3
                [OPTION]=turnycomputadora(cartas_comunitarias,cartas_computadora1,mapacartas);
                if OPTION==1
                    disp('PC 1 hace Raise');
                end
                if OPTION==2
                    disp('PC 1 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 1 hace Fold');
                end
            end
            if ronda==4
                [OPTION]=riverycomputadora(cartas_comunitarias,cartas_computadora1,mapacartas);
                if OPTION==1
                    disp('PC 1 hace Raise');
                end
                if OPTION==2
                    disp('PC 1 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 1 hace Fold');
                end
            end
        end
        if i==3
            if ronda==1
                [valor1,valor2,fuerza]=fuerzaini(cartas_computadora2,mapacartas);
                if fuerza<45
                    OPTION=3;
                else
                    [OPTION]=preflopcom(cartas_computadora2,mapacartas);
                end
                if OPTION==1
                    disp('PC 2 hace Raise');
                end
                if OPTION==2
                    disp('PC 2 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 2 hace Fold');
                end
            end
            if ronda==2
                [OPTION]=flopycomputadora(cartas_comunitarias,cartas_computadora2,mapacartas);
                if OPTION==1
                    disp('PC 2 hace Raise');
                end
                if OPTION==2
                    disp('PC 2 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 2 hace Fold');
                end
            end
            if ronda==3
                [OPTION]=turnycomputadora(cartas_comunitarias,cartas_computadora2,mapacartas);
                if OPTION==1
                    disp('PC 2 hace Raise');
                end
                if OPTION==2
                    disp('PC 2 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 2 hace Fold');
                end
            end
            if ronda==4
                [OPTION,floptotal]=riverycomputadora(cartas_comunitarias,cartas_computadora2,mapacartas);
                if OPTION==1
                    disp('PC 2 hace Raise');
                end
                if OPTION==2
                    disp('PC 2 hace Check/Call');
                end
                if OPTION==3
                    disp('PC 2 hace Fold');
                end
            end
        end
        if i==1
            fprintf('1 Bet/Raise [>=%g fichas] - 2 Call [%g fichas --> te faltan %g fichas] - 3 Fold : ',apuesta_actual*2,apuesta_actual,apuesta_actual-aportes_ronda(i));
            OPTION = input('');
        end
        if ismember(OPTION,[1,2,3])
            opcion_valida1=true; % Si se ingresa 1, 2 o 3, la opción es válida
        else
            fprintf('Opción no válida. Por favor selecciona 1, 2 o 3.\n');
        end
    end
    opcion(end+1)=OPTION;
    switch OPTION
        case 1 %Bet/Raise
            [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=betV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN);
        case 2 %Call
            [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=callV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN);
        case 3 %Fold
            fold_A(i)=0; %Usuario ha hecho fold
    end
end