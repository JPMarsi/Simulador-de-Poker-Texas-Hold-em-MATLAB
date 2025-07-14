% Función auxiliar para verificar Color
function es_color=color(cartas)
    palos=cellfun(@(carta) carta(end), cartas);
    es_color=length(unique(palos))==1;
end