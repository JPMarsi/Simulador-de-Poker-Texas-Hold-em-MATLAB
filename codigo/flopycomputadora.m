function [OPTION]=flopycomputadora(cartas_comunitarias, cartas_computadora, mapacartas)
    %%Computadora 
    flopcomtotal=[cartas_computadora, cartas_comunitarias(1:3)];
    valores_computadora1=cellfun(@(cartas) mapacartas(cartas(1:end-1)), flopcomtotal);

    %Verificar carta alta, pareja o trío
    carta_alta1=any(valores_computadora1 > 8);
    unicos1=unique(valores_computadora1);
    repeticiones1=histc(valores_computadora1, unicos1);
    pareja1=any(repeticiones1==2);
    trio1=any(repeticiones1==3);
    
    %Verificar si tiene posibilidad de escalera
    posible_escalera=verificarposibleescalera(valores_computadora1);

    % Decisión de la computadora 
    
    if carta_alta1 || pareja1 || trio1 || posible_escalera && ESTADO==0
        OPTION=2;
        if carta_alta1
            OPTION=2;
        end
        if pareja1
            OPTION=2;
        end
        if trio1
            OPTION=2;
        end
        if posible_escalera
            OPTION=2;
        end
    else
        OPTION=3;
    end
end



