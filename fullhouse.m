% Función auxiliar para verificar Full
function es_full=fullhouse(valores)
    unicos=unique(valores);
    repeticiones=histc(valores, unicos);
    es_full=any(repeticiones==3) && any(repeticiones==2);
end
