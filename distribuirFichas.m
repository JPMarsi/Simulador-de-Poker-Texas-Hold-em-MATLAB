function FICHAS = distribuirFichas(FICHAS, posiciones_finales, aportes_juego, BOTE_PRINCIPAL, BOTE_SECUNDARIO, BOTE_TERCIARIO)

    % Obtener los jugadores habilitados para cada bote
    [jugadores_bote_principal, jugadores_bote_secundario, jugador_bote_terciario] = determinarBotes(aportes_juego, BOTE_PRINCIPAL, BOTE_SECUNDARIO, BOTE_TERCIARIO);

    % Inicializar ganadores de cada posición
    ganador = posiciones_finales{1};  % Primero en posiciones_finales
    segundo = posiciones_finales{2};  % Segundo en posiciones_finales
    tercero = posiciones_finales{3};  % Tercero en posiciones_finales
    
    % Traducimos 'u', '1' y '2' a índices numéricos para las fichas
    if strcmp(ganador, 'u')
        ganador = 1;  % Usuario
    elseif strcmp(ganador, '1')
        ganador = 2;  % pc1
    else
        ganador = 3;  % pc2
    end
    
    if strcmp(segundo, 'u')
        segundo = 1;  % Usuario
    elseif strcmp(segundo, '1')
        segundo = 2;  % pc1
    else
        segundo = 3;  % pc2
    end
    
    if strcmp(tercero, 'u')
        tercero = 1;  % Usuario
    elseif strcmp(tercero, '1')
        tercero = 2;  % pc1
    else
        tercero = 3;  % pc2
    end

    % Distribuir los botes
    % 1. Bote Principal: Se lo lleva el ganador si está habilitado
    if ismember(ganador, jugadores_bote_principal)
        FICHAS(ganador) = FICHAS(ganador) + BOTE_PRINCIPAL;
    end
    
    % 2. Bote Secundario: Se lo lleva el segundo si está habilitado
    if BOTE_SECUNDARIO > 0 && ismember(segundo, jugadores_bote_secundario)
        FICHAS(segundo) = FICHAS(segundo) + BOTE_SECUNDARIO;
    elseif BOTE_SECUNDARIO > 0 && ismember(tercero, jugadores_bote_secundario)
        % Si el segundo no está habilitado, el tercero puede ganar el BOTE_SECUNDARIO
        FICHAS(tercero) = FICHAS(tercero) + BOTE_SECUNDARIO;
    end

    % 3. Bote Terciario: Solo lo puede ganar el jugador habilitado para ello
    if BOTE_TERCIARIO > 0
        FICHAS(jugador_bote_terciario) = FICHAS(jugador_bote_terciario) + BOTE_TERCIARIO;
    end
end
