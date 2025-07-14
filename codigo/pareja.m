% Función auxiliar para verificar Pareja
function es_pareja=pareja(valores)
    unicos=unique(valores);
    repeticiones=histc(valores, unicos);
    es_pareja=any(repeticiones==2);
end