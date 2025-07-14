function [jugadores_bote_principal, jugadores_bote_secundario, jugador_bote_terciario]=determinarBotes(aportes_juego, BOTE_PRINCIPAL, BOTE_SECUNDARIO, BOTE_TERCIARIO)

    % Verificamos que haya 3 jugadores
    if length(aportes_juego)~=3
        error('Debe haber exactamente 3 jugadores.');
    end

    % Ordenamos los aportes de los jugadores y obtenemos los índices de origen
    [aportes_ordenados, indices]=sort(aportes_juego);
    
    % Inicializamos los jugadores habilitados para cada bote
    jugadores_bote_principal=[1, 2, 3]; % Todos los jugadores pueden optar al BOTE_PRINCIPAL inicialmente
    jugadores_bote_secundario=[];
    jugador_bote_terciario=[];

    % Caso donde BOTE_SECUNDARIO y BOTE_TERCIARIO son 0 -> Solo BOTE_PRINCIPAL
    if BOTE_SECUNDARIO==0 && BOTE_TERCIARIO==0
        % Todos pueden optar por el BOTE_PRINCIPAL
        return; % No necesitamos más cálculos, todos pueden ganar el principal y no hay otros botes
    end

    % Caso donde solo BOTE_TERCIARIO es 0
    if BOTE_TERCIARIO == 0
        % Todos pueden optar por el BOTE_PRINCIPAL
        jugadores_bote_principal=[1, 2, 3];
        % El jugador con menor apuesta (aportes_ordenados(1)) no puede optar al BOTE_SECUNDARIO
        jugadores_bote_secundario=indices(2:3); % Jugadores 2 y 3, los de apuestas mayores
        return; % No hay BOTE_TERCIARIO
    end

    % Caso general: hay BOTE_PRINCIPAL, BOTE_SECUNDARIO y BOTE_TERCIARIO
    % Todos pueden optar por el BOTE_PRINCIPAL
    jugadores_bote_principal=[1, 2, 3];
    % El jugador con menor apuesta no puede optar al BOTE_SECUNDARIO
    jugadores_bote_secundario=indices(2:3); % Jugadores 2 y 3
    % El jugador con mayor apuesta es el único que puede optar al BOTE_TERCIARIO
    jugador_bote_terciario=indices(3); % Jugador con mayor apuesta
end
