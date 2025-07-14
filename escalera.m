% Función auxiliar para verificar Escalera
function es_escalera=escalera(valores)
    valores_unicos=unique(valores);
    es_escalera=false;
    if length(valores_unicos)>=5
        for i=1:(length(valores_unicos)-4)
            if (valores_unicos(i+4)-valores_unicos(i)==4)
                es_escalera=true;
                return;
            end
        end
    end
end 