% Función auxiliar para verificar Trío
function es_trio=trio(valores)
    unicos=unique(valores);
    repeticiones=histc(valores, unicos);
    es_trio=any(repeticiones==3);
end
