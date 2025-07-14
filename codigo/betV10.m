function [apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN]=betV10(i,apuesta_actual,aportes_ronda,FICHAS,aportes_juego,all_in,fold_A,opcion,ALL_IN)

subida_valida=false; %Condicion para controlar el bucle while (solo termina si se coloca una subida valida)
while ~subida_valida
%El doble de la apuesta actual supera tus fichas
    if apuesta_actual*2>FICHAS(i) && apuesta_actual-aportes_ronda(i)>FICHAS(i)
        if i ==1
            fprintf('El doble de la apuesta actual supera tus fichas\ndoble apuesta actual : [%g] | tus fichas : [%g]\n',apuesta_actual*2,FICHAS(i));
            opsion_valida=false; %Bandera para controlar la validez de la opción
            while ~opsion_valida
                opsion=input('1 para all in - 2 para retirarte : ');
                if ismember(opsion,[1,2])
                    opsion_valida=true; % Si se ingresa 1 o 2 la opción es válida
                else
                    fprintf('Opción no válida. Por favor selecciona 1 o 2.\n');
                end
            end
        end
        %-----------------------------------------------------------------------------------
        if i==2 || i==3 %Computadora tiene menos fichas que apuesta actual doble y pero tiene buena mano, procede a foldear
                opsion=1;
        end
        %-----------------------------------------------------------------------------------
        switch opsion
            case 1 %ALL IN
                subida=FICHAS(i); %Ingreso de fichas
                FICHAS(i)=0; %Descuento de fichas [ALL IN]
                %Agregar aportes del jugador (juego y ronda)
                aportes_juego(i)=aportes_juego(i)+subida;
                aportes_ronda(i)=aportes_ronda(i)+subida;
                fprintf('Hace ALL IN.\n');
                all_in(i)=1; %Jugador hace all in
                ALL_IN(i)=1; %Jugador hace all in (supremo)
                % ______________POZOS PARALELOS
                subida_valida=true;
            case 2 %fold
                fold_A(i)=0; %Usuario ha hecho fold
                subida_valida=true;
                opcion(end+1)=3; %Guarda opcion para luego evaluar fold
        end
%El doble de la apuesta actual supera tus fichas, pero la apuesta actual normal no (es posible call)
    elseif apuesta_actual*2>FICHAS(i) && apuesta_actual-aportes_ronda(i)<=FICHAS(i)
        if i==1
        fprintf('El doble de la apuesta actual supera tus fichas, pero la apuesta actual normal no (es posible call)\ndoble apuesta actual : [%g] | tus fichas : [%g]\n',apuesta_actual*2,FICHAS(i));
        oppsion_valida=false; %Bandera para controlar la validez de la opción
        while ~oppsion_valida
            oppsion=input('1 para call - 2 para all in - 3 para retirarte : ');
            if ismember(oppsion,[1,2,3])
                oppsion_valida=true; % Si se ingresa 1, 2 o 3 la opción es válida
            else
                fprintf('Opción no válida. Por favor selecciona 1, 2 o 3.\n');
            end
        end
        end
        %-----------------------------------------------------------------------------------
        if i==2 || i==3 %Computadora tiene menos fichas que apuesta actual doble (puede hacer call, la DESHABILITAMOS) y pero tiene buena mano, procede a foldear
                oppsion=2;
        end
        %-----------------------------------------------------------------------------------
        switch oppsion
            case 1 %call
                diferencia=apuesta_actual-aportes_ronda(i); %Calculo de diferencia
                FICHAS(i)=FICHAS(i)-diferencia; %Descuento de fichas
                %Agregar aportes del jugador (juego y ronda)
                aportes_juego(i)=aportes_juego(i)+diferencia;
                aportes_ronda(i)=aportes_ronda(i)+diferencia;
                fprintf('Iguala la apuesta con %g fichas.\n',diferencia);
            case 2 %ALL IN
                subida=FICHAS(i); %Ingreso de fichas
                FICHAS(i)=0; %Descuento de fichas [ALL IN]
                %Agregar aportes del jugador (juego y ronda)
                aportes_juego(i)=aportes_juego(i)+subida; 
                aportes_ronda(i)=aportes_ronda(i)+subida;
                fprintf('Hace ALL IN.\n');
                all_in(i)=1; %Jugador hace all in
                ALL_IN(i)=1; %Jugador hace all in (supremo)
% ______________POZOS PARALELOS
                subida_valida=true;
            case 3 %fold
                fold_A(i)=0; %Usuario ha hecho fold
                subida_valida=true;
                opcion(end+1)=3; %Guarda opcion para luego evaluar fold
        end
%El doble de la apuesta actual NO supera tus fichas
    elseif apuesta_actual*2<=FICHAS(i)
        if i==1
        fprintf('¿Cuánto deseas subir? (debe ser mayor o igual que el doble de la apuesta actual) [>=%g] : ',apuesta_actual*2);
        subida=input(''); %Ingreso de subida
        end
        %-----------------------------------------------------------------------------------
        if i==2 || i==3 %Computadora tiene mas o igual fichas que apuesta actual doble, apuesta 20 por determinado cuando la apuesta actual es 0, sino apuesta el doble de la actual
            if apuesta_actual==0
                if FICHAS(i)>=20
                subida=20;
                else
                    subida=FICHAS(i);
                end
            else
                subida=apuesta_actual*2;
            end
        end
        %-----------------------------------------------------------------------------------
        if subida>=apuesta_actual*2 %Condicion para poder subir/raise
            if subida>FICHAS(i) %fichas ingresadas superan mi FICHAS totales (opcion invalida)
                fprintf('Las fichas ingresadas superan las fichas totales [ingreso %g > fichas totales %g]. Intenta de nuevo.\n',subida,FICHAS(i)); %El bucle while continua porque la subida no es válida
            else
                fichas(i)=FICHAS(i); %Sirve para verificar all in (porque no podemos utilizar FICHAS ya que se borra)
                FICHAS(i)=FICHAS(i)-subida; %Descuento de fichas
                %Agregar aportes del jugador (juego y ronda
                aportes_juego(i)=aportes_juego(i)+subida;
                aportes_ronda(i)=aportes_ronda(i)+subida;
                apuesta_actual=aportes_ronda(i); %Actualizar apuesta actual
                if subida==fichas(i)
                    fprintf('Hace ALL IN.\n');
                    all_in(i)=1; %Jugador hace all in
                    ALL_IN(i)=1; %Jugador hace all in (supremo)
                    subida_valida = true; %Salimos del bucle while porque la subida es válida
                else
                    fprintf('Se sube la apuesta a %g fichas.\n',subida);
                    subida_valida = true; %Salimos del bucle while porque la subida es válida
                end
            end
        else %(opcion invalida)
            fprintf('Las fichas ingresadas son insuficientes [apuesta actual doble %g > ingreso %g]. Intenta de nuevo.\n',apuesta_actual*2,subida); %El bucle while continua porque la subida no es válida
        end
    end
end