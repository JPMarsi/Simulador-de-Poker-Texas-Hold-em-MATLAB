% Función auxiliar para verificar Doble Pareja
function es_doble_pareja=doblepareja(valores)
    unicos=unique(valores);
    repeticiones=histc(valores, unicos);
    es_doble_pareja=sum(repeticiones == 2)==2;
end
