% Función auxiliar para verificar Poker
function es_poker=poker(valores)
    unicos=unique(valores);
    repeticiones=histc(valores, unicos);
    es_poker=any(repeticiones==4);
end
