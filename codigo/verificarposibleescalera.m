function posible_escalera=verificarposibleescalera(valores)
    %Eliminar duplicados y ordenar valores
    valores_unicos=unique(sort(valores));
    
    %Verificar si existen al menos 3 cartas que puedan formar parte de una secuencia
    posible_escalera=false;
    if length(valores_unicos)>=3
        %Recorremos las cartas únicas para verificar posibles secuencias
        for i=1:(length(valores_unicos) - 2)
            %Verificar si las 3 cartas tienen un rango máximo de 4 valores
            if (valores_unicos(i+2) - valores_unicos(i)<=4)
                posible_escalera=true;
                return;
            end
        end
    end
end